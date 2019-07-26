package com.yida.admin.controller;



import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yida.admin.service.CourseTimeService;







@Controller
@RequestMapping(value="/courseTime")
public class CourseTimeController {
	
	@Autowired
	private CourseTimeService courseTimeService;
	
	@RequestMapping(value="/selectCourseTime.do")
	@ResponseBody
	public Map<String, Object> selectCourseTime(Integer page,Integer rows){
		return courseTimeService.selectCourseTimeByPage(page, rows);
	}

}
