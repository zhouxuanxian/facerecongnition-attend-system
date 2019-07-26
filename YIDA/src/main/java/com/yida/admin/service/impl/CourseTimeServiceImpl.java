package com.yida.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yida.admin.mapper.CourseMapper;
import com.yida.admin.mapper.CourseTimeMapper;
import com.yida.admin.service.CourseService;
import com.yida.admin.service.CourseTimeService;





@Service
public class CourseTimeServiceImpl implements CourseTimeService{
	
	@Autowired
	private CourseTimeMapper courseTimeMapper;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Override
	public Map<String, Object> selectCourseTimeByPage(Integer page,Integer rows) {
		
		int startIndex = (page-1)*rows;
		List<Map<String,Object>> list = courseTimeMapper.listCourseTime(startIndex, rows);
		int count = courseTimeMapper.countCourseTime();
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("rows", list);
		hashMap.put("total",count);
		logger.info("课程信息查询分页返回");
		return hashMap;
		
	}

}
