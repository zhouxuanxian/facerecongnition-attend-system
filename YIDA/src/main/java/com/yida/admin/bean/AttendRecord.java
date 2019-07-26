package com.yida.admin.bean;
/**
 * 
 * @ClassName AttendRecord
 * @Description 
 * @Author 周轩衔
 * @Date Jan 26, 2019 8:58:13 PM
 */
import java.sql.Timestamp;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;

/**
 * @ClassName AttendRecord
 * @Description 
 * @Author 周轩衔
 * @Date Feb 14, 2019 12:35:54 AM
 */
public class AttendRecord {
	
	@TableId(type=IdType.AUTO)
	private Integer id;
	private Integer studentId;//学生ID
	private Integer teacherId;//教师ID
	private String courseCode;//课程ID
	private Integer courseTimeId;//上课时间ID
	private Integer coursePlaceId;//上课地点ID
	private Integer courseRoomId;//上课课室ID
	private String status;//状态
	private Timestamp attendTime;//考勤状态
	private Timestamp createTime;//创建时间
	private Timestamp lastUpdateTime;//最后更新时间
	
	
	
	@TableField(exist=false)
	private String teacherName;
	
	@TableField(exist=false)
	private String studentName;
	
	@TableField(exist=false)
	private String studentClass;
	
	@TableField(exist=false)
	private String courseName;
	
	@TableField(exist=false)
	private String week;
	
	@TableField(exist=false)
	private String day;
	
	@TableField(exist=false)
	private String node;
	
	@TableField(exist=false)
	private String startTime;
	
	
	@TableField(exist=false)
	private String endTime;
	
	
	@TableField(exist=false)
	private String place;
	

	@TableField(exist=false)
	private String room;

	

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getStudentId() {
		return studentId;
	}

	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}

	public Integer getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(Integer teacherId) {
		this.teacherId = teacherId;
	}
	public Integer getCourseTimeId() {
		return courseTimeId;
	}

	public void setCourseTimeId(Integer courseTimeId) {
		this.courseTimeId = courseTimeId;
	}

	public Integer getCoursePlaceId() {
		return coursePlaceId;
	}

	public void setCoursePlaceId(Integer coursePlaceId) {
		this.coursePlaceId = coursePlaceId;
	}

	public Integer getCourseRoomId() {
		return courseRoomId;
	}

	public void setCourseRoomId(Integer courseRoomId) {
		this.courseRoomId = courseRoomId;
	}

	public String getTeacherName() {
		return teacherName;
	}

	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}

	public String getStudentName() {
		return studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Timestamp getAttendTime() {
		return attendTime;
	}

	public void setAttendTime(Timestamp attendTime) {
		this.attendTime = attendTime;
	}

	public String getWeek() {
		return week;
	}

	public void setWeek(String week) {
		this.week = week;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public String getNode() {
		return node;
	}

	public void setNode(String node) {
		this.node = node;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public String getRoom() {
		return room;
	}

	public void setRoom(String room) {
		this.room = room;
	}

	public String getCourseCode() {
		return courseCode;
	}

	public void setCourseCode(String courseCode) {
		this.courseCode = courseCode;
	}

	
	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public Timestamp getLastUpdateTime() {
		return lastUpdateTime;
	}

	public void setLastUpdateTime(Timestamp lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}

	
	public String getStudentClass() {
		return studentClass;
	}

	public void setStudentClass(String studentClass) {
		this.studentClass = studentClass;
	}

	@Override
	public String toString() {
		return "AttendRecord [id=" + id + ", studentId=" + studentId + ", teacherId=" + teacherId + ", courseCode="
				+ courseCode + ", courseTimeId=" + courseTimeId + ", coursePlaceId=" + coursePlaceId + ", courseRoomId="
				+ courseRoomId + ", status=" + status + ", attendTime=" + attendTime + "]";
	}


	
	



}
