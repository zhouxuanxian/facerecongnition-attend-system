package com.yida.admin.mapper;

import java.sql.Timestamp;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yida.admin.bean.FaceCollect;

public interface PhotoMapper extends BaseMapper<FaceCollect>{

	/**
	 * 
	* @Title: insertFaceInfo
	* @Description: 插入学生收集的信息
	* @param studentId
	* @param featureId
	* @return
	* @return int
	* @throws
	 */
	@Insert("insert into face_collect(student_id,feature_id,create_time) values (#{studentId},#{featureId},#{createTime}) ")
    int insertFaceInfo(@Param("studentId")String studentId,@Param("featureId") String featureId,@Param("createTime") Timestamp createTime);
}
