package com.yida.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * 
 * @ClassName CourseMapper
 * @Description 
 * @Author 周轩衔
 * @Date 2018年12月10日 下午8:50:29
 */
public interface CourseMapper {
	
	
	
	List<Map<String, Object>> listCourse(@Param("startIndex")Integer startIndex,@Param("pageSize")Integer pageSize);
	
	int countCourse();
	
	@Select("select * from course_room limit #{startIndex},#{pageSize}")
	List<Map<String, Object>> listCourseRoomByPage(@Param("startIndex")Integer startIndex,@Param("pageSize")Integer pageSize);
	
	@Select("select count(*) from course_room")
	int countRoom();

	
	@Select("select * from course_place limit #{startIndex},#{pageSize}")
	List<Map<String, Object>> listCoursePlaceByPage(@Param("startIndex")Integer startIndex,@Param("pageSize")Integer pageSize);

	@Select("select * from course_place")
	List<Map<String, Object>> listCoursePlace();
	
	@Select("select * from course_room")
	List<Map<String, Object>> listCourseRoom();
	
	@Select("select * from course_time")
	List<Map<String, Object>> listCourseTime();
	
	@Select("select * from teacher")
	List<Map<String, Object>> listTeacher();
	
	@Select("select * from course")
	List<Map<String, Object>> getCourse();
	
   @Select("select student_class as studentClass from student group by student_class")
   List<Map<String, Object>> ListClass();
}
