package com.zzq.back.utils;

import java.util.HashMap;
import java.util.Map;

/**
 * 构造通用结果工具，如返回flag，msg或者retCode,retMsg
 * @author zengxiaohui
 * @date 2017年1月4日
 */
public class ResultUtils {
	
	/** 内部使用的返回标识，flag=true,false */
	public static final String FLAG = "flag";
	
	/** 内部使用的返回提示信息 */
	public static final String MSG = "msg";
	
	/**
	 * 构造返回结果，含flag，msg
	 * @param flag
	 * @param msg
	 * @return
	 */
	public static Map<String,Object> buildFlagAndMsgMap(boolean flag,String msg){
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put(FLAG, flag);
		resultMap.put(MSG, msg);
		return resultMap;
	}
	
	/**
	 * 获取flag标识
	 * @param resultMap
	 * @return
	 */
	public static Boolean getFlag(Map<String,Object> resultMap){
		Object flagObj = resultMap.get(FLAG);
		return (flagObj != null && flagObj instanceof Boolean) ? (Boolean) flagObj : false;
	}
	
	/**
	 * 获取msg
	 * @param resultMap
	 * @return
	 */
	public static String getMsg(Map<String,Object> resultMap){
		Object msgObj = resultMap.get(MSG);
		return (msgObj != null && msgObj instanceof String) ? (String) msgObj : "";
	}
}
