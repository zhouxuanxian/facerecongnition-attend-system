package com.yida.admin.service;


import java.util.List;
import java.util.Map;



public interface AttendRecordService {

	Map<String, Object> selectByPage(Map<String, Object> param);

	int insertAttend(Map<String, Object> param);

	List<Map<String, Object>> startDetection(Map<String, Object> param) throws Exception;

	List<Map<String, Object>> getCountInfo(Map<String, Object> param);
}
