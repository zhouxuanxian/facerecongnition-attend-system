package com.yida.admin.controller;



import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yida.admin.bean.Student;
import com.yida.admin.service.StudentService;




@Controller
@RequestMapping(value="/student")
public class StudentController {
	
	@Autowired
	private StudentService studentService;
	
	
	@RequestMapping(value="/insertStudent.do")
	@ResponseBody
	public int insertStudent(@RequestBody Map<String, Object> param) {
		return studentService.insert(param);
	}
	
	@RequestMapping(value="/updateStudent.do")
	@ResponseBody
	public int updateStudent(@RequestBody Map<String, Object> param) {
		System.out.println("param:"+param);
		return studentService.update(param);
	}
	
	@RequestMapping(value="/selectStudent.do")
	@ResponseBody
	public Map<String, Object> selectStudent(@RequestParam Map<String , Object> params){
		return studentService.getAll(params);
	}
	
	@RequestMapping(value="/selectStudentById.do")
	@ResponseBody
	public Student selectStudentById(Integer studentId) {
		System.out.println("student:"+studentId);
		return studentService.selectStudentById(studentId);
	}
	
	@RequestMapping(value="/deleteStudent.do")
	@ResponseBody
	public int deleteStudent(String ids) {
		return studentService.delete(ids);
	}

	@RequestMapping(value="/getStudent.do")
	@ResponseBody
	public List<Student> getStudent(String studentNum) {
		return studentService.listStudentByNum(studentNum);
	}
}
