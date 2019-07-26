package com.yida.admin.service;

import java.util.Map;

public interface CourseTimeService {

	Map<String, Object> selectCourseTimeByPage(Integer page, Integer rows);

}
