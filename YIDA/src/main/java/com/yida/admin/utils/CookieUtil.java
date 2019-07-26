package com.yida.admin.utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CookieUtil {
	
	static Logger logger = LoggerFactory.getLogger(CookieUtil.class);


	
	//获取登录的teacherName
	public static String getTeacherName(HttpServletRequest request) {
		String teacherName = null;
		Cookie[] cookies = request.getCookies();
		if (cookies!=null) {
			for (Cookie cookie : cookies) {
				if(cookie.getName().equals("teacher_name")) {
					logger.info("登录的账户名为："+cookie.getName());
					logger.info("登录的账户值为："+cookie.getValue());
					teacherName = cookie.getValue();				
				}
			}
		}
		return teacherName;
	}
	//获取登录的teacherNum
	public static String getTeacherNum(HttpServletRequest request) {
		String teacherNum = null;
		Cookie[] cookies = request.getCookies();
		if (cookies!=null) {
			for (Cookie cookie : cookies) {
				if(cookie.getName().equals("teacher_num")) {
					logger.info("登录的账户名为："+cookie.getName());
					logger.info("登录的账户值为："+cookie.getValue());
					teacherNum = cookie.getValue();				
				}
			}
		}
		return teacherNum;
	}
}
