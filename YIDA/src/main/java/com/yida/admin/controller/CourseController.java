package com.yida.admin.controller;



import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.yida.admin.service.CourseService;






@RestController
@RequestMapping(value="/course")
public class CourseController {
	
	@Autowired
	private CourseService courseService;
	
	@RequestMapping(value="/selectCourse.do")
	public Map<String, Object> selectCourse(Integer page,Integer rows){
		return courseService.selectCourseByPage(page, rows);
	}

	@GetMapping(value="/selectCoursePlace.do")
	public List<Map<String, Object>> listCoursePlace(){
		return courseService.listCoursePlace();		
	}
	
	@GetMapping(value="/selectCourseRoom.do")
	public List<Map<String, Object>> listCourseRoom(){
		return courseService.listCourseRoom();		
	}
	
	@GetMapping(value="/selectCourseTime.do")
	public List<Map<String, Object>> listCourseTime(){
		return courseService.listCourseTime();		
	}
	
	@GetMapping(value="/selectTeacher.do")
	public List<Map<String, Object>> listTeacher(){
		return courseService.listTeacher();		
	}
	
	@GetMapping(value="/listCourse.do")
	public List<Map<String, Object>> listCourse(){
		return courseService.listCourse();		
	}
	
	@GetMapping(value="/listClass.do")
	public List<Map<String, Object>> listClass(){
		return courseService.listClass();		
	}
	
	@PostMapping("/getCoursePlace.do")
	public List<Map<String, Object>> getCoursePlace(@RequestParam Map<String, Object> param){
		return courseService.listCoursePlaceByPage(param);
	}
	
	@PostMapping("/getCourseRoom.do")
	public Map<String, Object>  getCourseRoom(@RequestParam Map<String, Object> param){
		return courseService.listCourseRoomByPage(param);
	}
}
