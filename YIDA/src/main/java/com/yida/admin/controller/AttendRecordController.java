package com.yida.admin.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.yida.admin.service.AttendRecordService;


@RestController
@RequestMapping(value="/attend")
public class AttendRecordController {
	
	@Autowired
	private AttendRecordService attendRecordService;

	/**
	 * 
	* @Title: getAttendRecord
	* @Description: 分页查询考勤记录
	* @param param
	* @return
	* @return Map<String,Object>
	* @throws
	 */
	@PostMapping(value="/getAttendRecord.do")
	public Map<String, Object> getAttendRecord(@RequestParam Map<String, Object> param) {
       
		return attendRecordService.selectByPage(param);
	}
	
	@PostMapping("/insertBaseInfo.do")
	public int insertBaseInfo(@RequestParam Map<String , Object> params) {
		return attendRecordService.insertAttend(params);
	}
	
	@PostMapping("/startDetection.do")
	public List<Map<String, Object>> startDetection(@RequestParam Map<String , Object> params) {
		try {
			return attendRecordService.startDetection(params);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@PostMapping("/getCountInfo.do")
	public List<Map<String, Object>> getCountInfo(@RequestBody Map<String , Object> param){
		System.out.println(param.toString());
		return attendRecordService.getCountInfo(param);
	}

}
