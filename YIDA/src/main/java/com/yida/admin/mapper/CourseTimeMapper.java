package com.yida.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
/**
 * 
 * @ClassName CourseTimeMapper
 * @Description 课程时间的mapper
 * @Author zxx
 * @Date Apr 3, 2019 10:49:18 
 */
public interface CourseTimeMapper {

    List<Map<String, Object>> listCourseTime(@Param("startIndex")Integer startIndex,@Param("pageSize")Integer pageSize);
	
	int countCourseTime();
	
}
