package com.yida.admin.controller;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import com.yida.admin.bean.Teacher;
import com.yida.admin.service.TeacherService;
import com.yida.admin.utils.CookieUtil;



@Controller
@RequestMapping(value="/teacher")
public class TeacherContoller {

	@Autowired
	private TeacherService teacherService;
	
	@Autowired
	private HttpServletRequest request;
	
	@Autowired
	private HttpServletResponse response;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	/**
	 * 
	* @Title: login
	* @Description: 跳转到登录页面的接口
	* @return
	* @return String
	* @throws
	 */
	@RequestMapping("/login.do")
	public String login() {
		Cookie[] cookies = request.getCookies();
		if (cookies!=null) {
			for (Cookie cookie : cookies) {
				cookie.setMaxAge(0);
				cookie.setPath(request.getContextPath());
				response.addCookie(cookie);
			}
		}
		return "redirect:/pages/admin/login.jsp";
	}
	
	/**
	 * 
	* @Title: getTeacherName
	* @Description:  获取登录的教师姓名
	* @return
	* @return String
	* @throws
	 */
	@PostMapping(value="/getTeacherName.do")
	@ResponseBody
	public String getTeacherName(){
		logger.info("登录的姓名为："+CookieUtil.getTeacherName(request));
		return CookieUtil.getTeacherName(request);
	}
	
	/**
	 * 
	* @Title: getTeacherNum
	* @Description:  获取登录的教师工号
	* @return
	* @return String
	* @throws
	 */
	@PostMapping(value="/getTeacherNum.do")
	@ResponseBody
	public String getTeacherNum(){
		logger.info("登录的姓名为："+CookieUtil.getTeacherNum(request));
		return CookieUtil.getTeacherNum(request);
	}
	
	/**
	 * 
	* @Title: resetPassword
	* @Description: 跳转到密码重置的页面
	* @return
	* @return String
	* @throws
	 */
	@RequestMapping("/resetPassword.do")
	public String resetPassword() {
		request.setAttribute("teacherNum", CookieUtil.getTeacherNum(request));
		return "admin/resetPassword.jsp";	
	}
	
	@RequestMapping("/updatePassword.do")
	@ResponseBody
	public boolean updatePassword(@RequestParam(required=true,value="password") String password,
			@RequestParam(required=true,value="teacherNum") String teacherNum) {
		return teacherService.updatePassword(password, teacherNum);
	}
	
	/**
	 * 
	* @Title: getlogin
	* @Description: 验证登录的接口
	* @param param
	* @return
	* @throws Exception
	* @return String
	* @throws
	 */
	@RequestMapping("/getLogin.do")
	public String getlogin(@RequestParam Map<String, Object> param) throws Exception {
		Map<String, Object> result = teacherService.login(param);
		
		if (result!=null) {
			logger.info("登录的教师信息为："+result.toString());
			if(result.get("teacher_name")!=null) {
				Cookie cookie = new Cookie("teacher_name", result.get("teacher_name").toString());
				cookie.setPath(request.getContextPath());
				response.addCookie(cookie);
			}
			if(result.get("teacher_num")!=null) {
				Cookie cookie = new Cookie("teacher_num", result.get("teacher_num").toString());
				cookie.setPath(request.getContextPath());
				response.addCookie(cookie);
			}
			return "redirect:/pages/admin/index.jsp";
		}else {			
			return "/admin/redirect.jsp"; 
		}
	}
	
	@RequestMapping(value="/getTeachers.do")
	@ResponseBody
	public Map<String,Object> getTeachers(@RequestParam Map<String, Object> param){
		return teacherService.getAllTeachers(param);
	}
	
	@RequestMapping(value="/insert.do")
	@ResponseBody
	public int insert(@RequestBody Map<String, Object> param) {
		System.out.println(param);
		return teacherService.insertTeacher(param);
	}
	
	@RequestMapping(value="/update.do")
	@ResponseBody
	public int Update(@RequestBody Map<String, Object> param) {
		System.out.println(param);
		return teacherService.update(param);
	}
	
	@RequestMapping(value="/getTeacherById.do")
	@ResponseBody
	public Teacher geTeacherById(Integer id) {
		return teacherService.geTeacherById(id);
	}
	
	@RequestMapping(value="/deleteTeacher.do")
	@ResponseBody
	public int delete(String ids) {
		System.out.println(ids);
		return teacherService.delete(ids);
	}
}
