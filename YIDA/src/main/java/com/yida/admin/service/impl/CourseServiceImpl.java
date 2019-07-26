package com.yida.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yida.admin.mapper.CourseMapper;
import com.yida.admin.service.CourseService;





@Service
public class CourseServiceImpl implements CourseService{
	
	@Autowired
	private CourseMapper courseMapper;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	public Map<String, Object> selectCourseByPage(Integer page,Integer rows) {
		
		int startIndex = (page-1)*rows;
		List<Map<String,Object>> list = courseMapper.listCourse(startIndex, rows);
		int count = courseMapper.countCourse();
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("rows", list);
		hashMap.put("total",count);
		logger.info("课程信息查询分页返回");
		return hashMap;
		
	}
	
	@Override
	public List<Map<String, Object>> listCoursePlace() {
		return courseMapper.listCoursePlace();
	}

	@Override
	public List<Map<String, Object>> listCourseRoom() {
		return courseMapper.listCourseRoom();
	}
	@Override
	public List<Map<String, Object>> listCourseTime() {
		return courseMapper.listCourseTime();
	}
	@Override
	public List<Map<String, Object>> listTeacher() {
		return courseMapper.listTeacher();
	}
	@Override
	public List<Map<String, Object>> listCourse() {
		return courseMapper.getCourse();
	}
	@Override
	public List<Map<String, Object>> listClass() {
		return courseMapper.ListClass();
	}
	@Override
	public List<Map<String, Object>> listCoursePlaceByPage(Map<String, Object> param){
		if(param!=null) {
			Integer pageSize=Integer.parseInt(param.get("rows").toString());
			Integer startIndex=(Integer.parseInt(param.get("page").toString())-1)*pageSize; 
			return courseMapper.listCoursePlaceByPage(startIndex, pageSize);
		}else {
			return null;
		}
		
	}
	
	@Override
	public Map<String, Object> listCourseRoomByPage(Map<String, Object> param){
		if(param!=null) {
			Integer pageSize=Integer.parseInt(param.get("rows").toString());
			Integer startIndex=(Integer.parseInt(param.get("page").toString())-1)*pageSize; 
			int count = courseMapper.countRoom();
			Map<String, Object> map = new HashMap<>();
			map.put("total", count);
			map.put("rows", courseMapper.listCourseRoomByPage(startIndex, pageSize));
			return map ;
	
		}else {
			return null;
		}
		
	}
	
}
