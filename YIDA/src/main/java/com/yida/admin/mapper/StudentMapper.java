package com.yida.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yida.admin.bean.Student;


public interface StudentMapper extends BaseMapper<Student>{
	
	/**
	 * 
	* @Title: count
	* @Description: 分页查询的总记录数
	* @param params
	* @return
	* @return int
	* @throws
	 */
	int count(Map<String , Object> params);
	
	/**
	 * 
	* @Title: getAll
	* @Description: 分页查询
	* @param params
	* @return
	* @return List<Student>
	* @throws
	 */
	List<Student> getAll(Map<String , Object> params);
	/**
	 * 
	* @Title: deleteByIds
	* @Description:  批量删除学生
	* @param ids
	* @return
	* @return int
	* @throws
	 */
	@Delete("DELETE FROM student WHERE student_id in (${ids})")
	int deleteByIds(@Param(value="ids") String ids);
	
	/**
	 * 
	* @Title: listStudentByNum
	* @Description: 根据学号模糊查询
	* @param studentNum
	* @return
	* @return List<Student>
	* @throws
	 */
	@Select("SELECT * FROM student WHERE student_num like '%${studentNum}%' ")
	List<Student> listStudentByNum(@Param(value="studentNum") String studentNum);
	
	/**
	 * 
	* @Title: listStudentId
	* @Description: 根据年级查找出所有学生的ID
	* @param grade
	* @return
	* @return List<Map<String,Object>>
	* @throws
	 */
	@Select("select student_id as studentId from student where student_class in (${ydClass}) ")
	List<Map<String, Object>> listStudentId(@Param("ydClass")String ydClass);
}
