package org.zeng.file;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import org.zeng.sha_256.StringEncrypt;

public class Operation {
	public StringBuffer readTxtFile(String filePath) {
		StringBuffer sb = new StringBuffer();
		try {
			String encoding = "utf-8";
			File file = new File(filePath);
			if (file.isFile() && file.exists()) { // 判断文件是否存在
				InputStreamReader read = new InputStreamReader(new FileInputStream(file), encoding);// 考虑到编码格式
				BufferedReader bufferedReader = new BufferedReader(read);
				String lineTxt = null;
				while ((lineTxt = bufferedReader.readLine()) != null) {
					sb.append(StringEncrypt.Encrypt(lineTxt, "") + "\n");
				}
				read.close();
			} else {
				System.out.println("找不到指定的文件");
			}
		} catch (Exception e) {
			System.out.println("读取文件内容出错");
			e.printStackTrace();
		}
		return sb;
	}

	public void writeStringToTxtFile(StringBuffer sb) {
		File fp = new File("D:\\sha256.txt");
		String str = sb.toString();
		PrintWriter pfp;
		try {
			pfp = new PrintWriter(fp);
			pfp.print(str);
			pfp.close();
		} catch (FileNotFoundException e) {
			System.out.println("写入文件内容出错");
			e.printStackTrace();
		}
	}
}
