package com.lh.back.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.net.ftp.FTPClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * ftp工具类
 * @author zengxiaohui
 * @date 2017年8月24日 上午10:32:02
 * @version 1.0
 */
public class FtpUtils {

	private static final Logger logger = LoggerFactory.getLogger(FtpUtils.class);

	private static final String FTP_URL = ConfigUtils.getConfig("ftp.url");
	private static final String FTP_USER = ConfigUtils.getConfig("ftp.user");
	private static final String FTP_PWD = ConfigUtils.getConfig("ftp.password");

	/**
	 * ftp 上传方法
	 * 
	 * @param uploadFullFilename
	 *            上传文件名（含目录，目录不存在，则创建）
	 * @param file
	 *            文件流
	 * @return
	 */
	public static boolean uploadUpyunFtp(String uploadFullFilename, InputStream file) {
		return uploadUpyunFtp(uploadFullFilename, file, null);
	}

	/**
	 * upyun ftp 上传方法
	 * 
	 * @param uploadFullFilename
	 *            上传文件名（含目录，目录不存在，则创建）
	 * @param file
	 *            文件流
	 * @param deleteFullFilename
	 *            删除的文件名（含目录）
	 * @return
	 */
	public static boolean uploadUpyunFtp(String uploadFullFilename, InputStream file, String deleteFullFilename) {
		String uploadPath = getPath(uploadFullFilename);
		String uploadFilename = getFilename(uploadFullFilename);

		FTPClient ftpClient = new FTPClient();
		try {
			uploadPath = new String(uploadPath.getBytes("UTF8"), "iso-8859-1");// 解决目录中文乱码
			uploadFilename = new String(uploadFilename.getBytes("UTF8"), "iso-8859-1");// 解决文件名中文乱码

			ftpClient.connect(FTP_URL); // 设置你连接ftp服务器地址
			ftpClient.login(FTP_USER, FTP_PWD); // 设置ftp服务器的用户名，密码
			ftpClient.enterLocalPassiveMode(); // 设置成passive模式

			if (!ftpClient.changeWorkingDirectory(uploadPath)) { // 跳转目的目录失败
				ftpClient.changeWorkingDirectory("/"); // 跳转根目录

				if (!ftpClient.makeDirectory(uploadPath) || !ftpClient.changeWorkingDirectory(uploadPath)) {// 创建并跳转目的目录
					return false;
				}
			}

			ftpClient.setBufferSize(1024);
			ftpClient.setFileType(FTPClient.BINARY_FILE_TYPE);// 设置文件类型

			boolean upload = ftpClient.storeFile(uploadFilename, file); // 上传
			if (upload) {
				// 删除指定文件
				if (StringUtils.isNotBlank(deleteFullFilename)) {
					ftpClient.deleteFile(deleteFullFilename);
				}
			}
			return upload;
		} catch (Exception e) {
			logger.error("上传文件到ftp发生异常", e);
			return false;
		} finally {
			try {
				if (ftpClient.isConnected()) {
					ftpClient.logout();
					ftpClient.disconnect();
				}
			} catch (IOException e) {
				logger.error("断开ftp连接异常", e);
			}
		}
	}

	/**
	 * 删除ftp上的文件
	 * 
	 * @param fullFilename
	 * @return
	 */
	public static boolean deleteFile(String fullFilename) {
		FTPClient ftpClient = new FTPClient();

		try {
			ftpClient.connect(FTP_URL);
			ftpClient.login(FTP_USER, FTP_PWD); // 设置ftp服务器的用户名，密码
			ftpClient.enterLocalPassiveMode(); // 设置成passive模式

			return ftpClient.deleteFile(fullFilename);
		} catch (Exception e) {
			logger.error("删除ftp文件异常", e);
		} finally {
			try {
				if (ftpClient.isConnected()) {
					ftpClient.logout();
					ftpClient.disconnect();
				}
			} catch (IOException e) {
				logger.error("断开ftp连接异常", e);
			}
		}
		return false;
	}



	/**
	 * 获取文件名
	 * 
	 * @param url
	 * @return
	 */
	public static String getFullFilename(String url) {
		String tmp = url.replaceFirst("http://", "");
		int index = tmp.indexOf("/");
		return tmp.substring(index);
	}

	/**
	 * 获取路径
	 * 
	 * @param fullFilename
	 * @return
	 */
	public static String getPath(String fullFilename) {
		int lastIndex = fullFilename.lastIndexOf("/");
		if (lastIndex != -1) {
			return fullFilename.substring(0, lastIndex);
		} else {
			return null;
		}
	}

	/**
	 * 获取文件名
	 * 
	 * @param fullFilename
	 *            包含路径的文件名
	 * @return
	 */
	public static String getFilename(String fullFilename) {
		int lastIndex = fullFilename.lastIndexOf("/");
		if (lastIndex != -1) {
			return fullFilename.substring(lastIndex + 1);
		} else {
			return null;
		}
	}

	/**
	 * 获取文件名后缀
	 * 
	 * @param filename
	 *            文件名
	 */
	public static String getSuffix(String filename) {
		return filename.substring(filename.lastIndexOf("."));
	}

	/**
	 * 根据上传的文件名生成新文件名
	 * 
	 * @param oldFilename
	 * @return
	 */
	public static String getNewFilename(String oldFilename) {
		return UUID.randomUUID() + getSuffix(oldFilename);
	}

}
