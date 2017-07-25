package com.zzq.back.controller.sys;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.zzq.back.entity.User;

@Controller
@RequestMapping(value ="/")
public class LoginController {

	private static final String PATH_PREFIX = "sys";
	
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String login(){
		return PATH_PREFIX + "/login";
	}
	
	@RequestMapping(value = "/login",method= RequestMethod.POST)
	public String loginManage(User user,Model model){
		Subject subject=SecurityUtils.getSubject();
		UsernamePasswordToken token=new UsernamePasswordToken(user.getUsername(), user.getPassword());
		try{
			subject.login(token);
			Session session=subject.getSession();
			System.out.println("sessionId:"+session.getId());
			System.out.println("sessionHost:"+session.getHost());
			System.out.println("sessionTimeout:"+session.getTimeout());
			session.setAttribute("info", "session的数据");
			return "redirect:/";
		}catch(Exception e){
			e.printStackTrace();
			return PATH_PREFIX + "/login";
		}
		//return PATH_PREFIX + "/login";
	}
}
