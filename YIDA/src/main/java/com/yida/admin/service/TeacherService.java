package com.yida.admin.service;

import java.util.Map;

import com.yida.admin.bean.Teacher;



public interface TeacherService {

	/**
	 * 
	* @Title: getAllTeachers
	* @Description: 条件查询，分页
	* @param param
	* @return
	* @return Map<String,Object>
	* @throws
	 */
	Map<String, Object> getAllTeachers(Map<String, Object> param);

	/**
	 * 
	* @Title: insertTeacher
	* @Description: 教师插入
	* @param teacher
	* @return
	* @return int
	* @throws
	 */
	int insertTeacher(Map<String, Object> param);

	/**
	 * 
	* @Title: geTeacherById
	* @Description: 根据ID查询教师
	* @param teacherId
	* @return
	* @return Teacher
	* @throws
	 */
	Teacher geTeacherById(Integer teacherId);

	/**
	 * 
	* @Title: update
	* @Description: 根据ID更新教师
	* @param param
	* @return
	* @return int
	* @throws
	 */
	int update(Map<String, Object> param);

	/**
	 * 
	* @Title: delete
	* @Description: 批量删除的id
	* @param ids
	* @return
	* @return int
	* @throws
	 */
	int delete(String ids);

	/**
	 * 
	* @Title: login
	* @Description: 校验教师登录
	* @param param
	* @return
	* @return Map<String,Object>
	* @throws
	 */
	Map<String, Object> login(Map<String, Object> param);

	boolean updatePassword(String password, String teacherNum);

}
