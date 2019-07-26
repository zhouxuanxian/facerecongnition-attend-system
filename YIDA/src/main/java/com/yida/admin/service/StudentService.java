package com.yida.admin.service;

import java.util.List;
import java.util.Map;

import com.yida.admin.bean.Student;



public interface StudentService {

	/**
	 * 
	* @Title: insert
	* @Description: 插入学生
	* @param params
	* @return
	* @return int
	* @throws
	 */
	int insert(Map<String, Object> params);

	/**
	* @Title: select
	* @Description: 分页，条件查询所有的学生
	* @param params
	* @return
	* @return List<Student>
	* @throws
	 */
	List<Student> select(Map<String , Object> params);

	 Map<String, Object> getAll(Map<String , Object> params);

	/**
	 * 
	* @Title: selectStudentById
	* @Description: 通过studentid查询学生
	* @param studentId
	* @return
	* @return Student
	* @throws
	 */
	Student selectStudentById(Integer studentId);

	/**
	 * 
	* @Title: update
	* @Description: 更新学生
	* @param params
	* @return
	* @return int
	* @throws
	 */
	int update(Map<String, Object> params);

	/**
	 * 
	* @Title: delete
	* @Description: 批量删除
	* @param ids
	* @return
	* @return int
	* @throws
	 */
	int delete(String ids);

	List<Student> listStudentByNum(String studentNum);

}
