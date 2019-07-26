package com.yida.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yida.admin.bean.Teacher;


public interface TeacherMapper extends BaseMapper<Teacher>{
	
	/**
	 * 
	* @Title: login
	* @Description: 教师根据用户名密码登录
	* @param account
	* @param password
	* @return
	* @return List<Map<String,Object>>
	* @throws
	 */
	@Select("select * from teacher where teacher_num=#{teacherNum} and password=#{password} ")
	List<Map<String, Object>> login(@Param("teacherNum") String teacherNum,@Param("password") String password);

	/**
	 * 
	* @Title: getAllTeachers
	* @Description: 分页条件查询学生信息
	* @param param
	* @return
	* @return List<Teacher>
	* @throws
	 */
	List<Teacher> getAllTeachers(Map<String, Object> param);

	/**
	 * 
	* @Title: geTeacherById
	* @Description: 根据教师ID查询教师
	* @param id
	* @return
	* @return Teacher
	* @throws
	 */
	@Select("select * from teacher where teacher_id=#{arg0}")
	Teacher geTeacherById(Integer id);
	
	/**
	 * 
	* @Title: updateTeacherById
	* @Description: 更新教师
	* @param param
	* @return
	* @return int
	* @throws
	 */
	@Update(" UPDATE teacher  SET teacher_name=#{name}, sex=#{sex}, phone=#{phone}, teacher_num=#{teacherNum} where teacher_id=#{teacherId}")
	int updateTeacherById(Map<String, Object> param);
	
	/**
	 * 
	* @Title: deleteByIds
	* @Description: 批量删除教师
	* @param ids
	* @return
	* @return int
	* @throws
	 */
	@Delete("DELETE FROM teacher WHERE teacher_id in (${ids})")
	int deleteByIds(@Param(value="ids") String ids);
	
	@Update("update teacher set password=#{password} where teacher_num=#{teacherNum}")
	int updatePassword(@Param("password") String password,@Param("teacherNum") String teacherNum);
}
