package com.yida.admin.mapper;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yida.admin.bean.AttendRecord;


public interface AttendRecordMapper extends BaseMapper<AttendRecord>{
	
	/**
	 * 
	* @Title: selectByPage
	* @Description: 分页查询考勤记录的data
	* @param param
	* @return
	* @return List<AttendRecord>
	* @throws
	 */
	List<AttendRecord> selectByPage(Map<String, Object> param);
	/**
	 * 
	* @Title: counts
	* @Description: 分页查询考勤记录的总数
	* @param param
	* @return
	* @return int
	* @throws
	 */
	int counts(Map<String, Object> param);
	
	/**
	 * 
	* @Title: batchInsert
	* @Description: 批量插入学生记录
	* @param list
	* @return void
	* @throws
	 */
	int batchInsert(List<AttendRecord> list);
	
	/**
	 * 
	* @Title: updateRecord
	* @Description: 更新记录，已到学生
	* @param attendTime
	* @param lastUpdateTime
	* @param teacherId
	* @param courseCode
	* @param courseTimeId
	* @param coursePlaceId
	* @param courseRoomId
	* @param studentId
	* @return
	* @return int
	* @throws
	 */
	@Update("update student_attend set status=#{status},attend_time=#{attendTime},last_update_time=#{lastUpdateTime} "
			+ "where teacher_id=#{teacherId} and course_code=#{courseCode} "
			+ "and course_time_id=#{courseTimeId} and course_place_id =#{coursePlaceId} "
			+ "and course_room_id=#{courseRoomId} and student_id in (${studentId}) ")
	int updateRecord( @Param("status")String status,
			        @Param("attendTime")Timestamp attendTime,
					@Param("lastUpdateTime")Timestamp lastUpdateTime,
					@Param("teacherId")String teacherId,
					@Param("courseCode")String courseCode,
					@Param("courseTimeId")String courseTimeId,
					@Param("coursePlaceId")String coursePlaceId,
					@Param("courseRoomId")String courseRoomId,
					@Param("studentId")String studentId
					);
	
	/**
	 * 
	* @Title: listStudentIn
	* @Description: 查询已经考勤的学生
	* @param teacherId
	* @param courseCode
	* @param courseTimeId
	* @param coursePlaceId
	* @param courseRoomId
	* @return
	* @return List<Map<String,Object>>
	* @throws
	 */
	@Select("select s.student_name studentName,a.status  from student s left join student_attend a on a.student_id = s.student_id "
			+ "where a.teacher_id=#{teacherId} and a.course_code=#{courseCode} "
			+ "and a.course_time_id=#{courseTimeId} and a.course_place_id =#{coursePlaceId} "
			+ "and a.course_room_id=#{courseRoomId} and (a.status='Y' or a.status='L') ")
	List<Map<String, Object>> listStudentIn(@Param("teacherId")String teacherId,
											@Param("courseCode")String courseCode,
											@Param("courseTimeId")String courseTimeId,
											@Param("coursePlaceId")String coursePlaceId,
											@Param("courseRoomId")String courseRoomId);
	
	/**
	 * 
	* @Title: getStartTime
	* @Description: 查询上课的时间
	* @param id
	* @return
	* @return List<Map<String,Object>>
	* @throws
	 */
	@Select("select * from course_time where id=#{id}")
	AttendRecord getStartTime(@Param("id") String id);
	
	
	List<Map<String, Object>> getCountInfo(Map<String, Object> param);
}
