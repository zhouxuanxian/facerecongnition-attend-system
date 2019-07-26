package com.yida.admin.bean;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;

/**
 * 
 * @ClassName Teacher
 * @Description 
 * @Author 周轩衔
 * @Date Dec 24, 2018 7:40:58 PM
 */
public class Teacher {
	@TableId(type=IdType.AUTO)
	private Integer teacherId;
	private String teacherName;
	private String sex;
	private String phone;
	private String teacherNum;

	
	
	public Integer getTeacherId() {
		return teacherId;
	}



	public void setTeacherId(Integer teacherId) {
		this.teacherId = teacherId;
	}



	public String getTeacherName() {
		return teacherName;
	}



	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}



	public String getSex() {
		return sex;
	}



	public void setSex(String sex) {
		this.sex = sex;
	}



	public String getPhone() {
		return phone;
	}



	public void setPhone(String phone) {
		this.phone = phone;
	}



	public String getTeacherNum() {
		return teacherNum;
	}



	public void setTeacherNum(String teacherNum) {
		this.teacherNum = teacherNum;
	}



	public String toString() {
		return "Teacher [teacherId=" + teacherId + ", teacherName=" + teacherName + ", sex=" + sex + ", phone=" + phone
				+ ", teacherNum=" + teacherNum + "]";
	}
	
	
}
