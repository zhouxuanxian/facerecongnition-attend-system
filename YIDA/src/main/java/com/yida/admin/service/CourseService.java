package com.yida.admin.service;

import java.util.List;
import java.util.Map;

public interface CourseService {

	Map<String, Object> selectCourseByPage(Integer page, Integer rows);

	List<Map<String, Object>> listCoursePlace();

	List<Map<String, Object>> listCourseTime();

	List<Map<String, Object>> listCourseRoom();

	List<Map<String, Object>> listTeacher();

	List<Map<String, Object>> listCourse();

	List<Map<String, Object>> listClass();

	List<Map<String, Object>> listCoursePlaceByPage(Map<String, Object> param);

	Map<String, Object> listCourseRoomByPage(Map<String, Object> param);

}
