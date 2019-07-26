package com.yida.admin.service.impl;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.yida.admin.bean.AttendRecord;
import com.yida.admin.bean.QiNiu;
import com.yida.admin.mapper.AttendRecordMapper;
import com.yida.admin.mapper.StudentMapper;
import com.yida.admin.service.AttendRecordService;
import com.yida.admin.utils.QiNiuUtil;

import okhttp3.Call;
import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;


@Service
public class AttendRecordServiceImpl implements AttendRecordService{
	
	@Autowired
	private  QiNiu qiNiu;
	
	@Autowired
	private AttendRecordMapper attendRecordMapper;
	
	@Autowired
	private StudentMapper studentMapper;
	

	Logger logger = LoggerFactory.getLogger(getClass());
	
	public Map<String, Object> selectByPage(Map<String, Object> param){
		
	if (param!=null) {
		int pageSize=Integer.parseInt(param.get("rows").toString());
		int startIndex=(Integer.parseInt(param.get("page").toString())-1)*pageSize;
		
		param.put("pageSize", pageSize);
		param.put("startIndex", startIndex);
	   
		
		if(param.get("startDate")!=null && param.get("startDate")!="" && !param.get("startDate").equals("") ) {
			 String startDate = param.get("startDate").toString();
			 String startDateTime = startDate +" 00:00:00";
			 param.put("startDateTime", startDateTime);
		}
		
		if(param.get("endDate")!=null && param.get("endDate")!="" && !param.get("endDate").equals("")) {
			 String endDate = param.get("endDate").toString();
			 String endDateTime = endDate +" 23:59:59";
			 param.put("endDateTime", endDateTime);
		}
		
		
	}	
	
	int count = attendRecordMapper.counts(param);
	List<AttendRecord> list = attendRecordMapper.selectByPage(param);

    Map<String, Object> hMap=new HashMap<>();
    hMap.put("total", count);
    hMap.put("rows", list);
	return hMap;
	}
	@Override
	public int insertAttend(Map<String, Object> param) {
		List<Map<String, Object>> list = null;
		int res = 0;
		if (param!=null) {
			if(param.get("ydClass")!=null&&!param.get("ydClass").equals("")&&!param.get("ydClass").equals("null")	) {
			   list = studentMapper.listStudentId(param.get("ydClass").toString());	
			}
			
			if(list!=null&&list.size()>0) {
				
				List<AttendRecord> attendList = new ArrayList<AttendRecord>();
				
				for(Map<String, Object> item : list) {
					
					AttendRecord attendRecord = new AttendRecord();
					
					if(param.get("teacherId")!=null&&!param.get("teacherId").equals("")&&!param.get("teacherId").equals("null")){
						attendRecord.setTeacherId(Integer.parseInt(param.get("teacherId").toString()));
					}
					if(param.get("courseCode")!=null&&!param.get("courseCode").equals("")&&!param.get("courseCode").equals("null")){
						attendRecord.setCourseCode(param.get("courseCode").toString());
					}
					if(param.get("courseTimeId")!=null&&!param.get("courseTimeId").equals("")&&!param.get("courseTimeId").equals("null")){
						attendRecord.setCourseTimeId(Integer.parseInt(param.get("courseTimeId").toString()));
					}
					if(param.get("coursePlaceId")!=null&&!param.get("coursePlaceId").equals("")&&!param.get("coursePlaceId").equals("null")){
						attendRecord.setCoursePlaceId(Integer.parseInt(param.get("coursePlaceId").toString()));
					}
					if(param.get("courseRoomId")!=null&&!param.get("courseRoomId").equals("")&&!param.get("courseRoomId").equals("null")){
						attendRecord.setCourseRoomId(Integer.parseInt(param.get("courseRoomId").toString()));
					}
					attendRecord.setStudentId(Integer.parseInt(item.get("studentId").toString()));
					attendRecord.setStatus("N");
					attendRecord.setCreateTime(new Timestamp(System.currentTimeMillis()));
					attendRecord.setLastUpdateTime(new Timestamp(System.currentTimeMillis()));
					
					attendList.add(attendRecord);
				}
				
				res = attendRecordMapper.batchInsert(attendList);
				logger.info("鼻批量插入的记录数为："+res);
				
			}
		}
		return res;
	}
	
	public List<Map<String, Object>> startDetection(Map<String, Object> params) throws Exception {
		List<Map<String, Object>> list = null;
		if (params!=null) {
			String url = "http://120.79.140.190/recfeature/";
			OkHttpClient okHttpClient = new OkHttpClient();
			RequestBody body = new FormBody.Builder()
			    .add("doc", params.get("doc").toString().split(",")[1])
			    .add("class", params.get("ydClass").toString())
			    .build();
			Request request = new Request.Builder()
			    .url(url)
			    .post(body)
			    .build();
			Call call = okHttpClient.newCall(request);
			try {
			    Response response = call.execute();
			    logger.info("开始识别人脸信息，请求外部的识别接口成功返回！");
			    String res = response.body().string();
			    if (res!=null) {
			    	 System.out.println(res);
			    	 JSONObject jsonObject = JSONObject.parseObject(res);
					 String studentString =  (String) jsonObject.get("result");
					 JSONArray studentArr = JSONArray.parseArray(studentString);
					 logger.info("返回学生id数组为"+studentArr);
					 if(studentArr.size()>0) {
						 String idString = "";
						 for(int i=0,len=studentArr.size();i<len;i++) {
							 if(i==0) {
								 idString = studentArr.get(i).toString();
							 }else {
								 idString += "," + studentArr.get(i).toString();
							 }
						 }
						 logger.info("返回学生id字符串为"+idString);
						 String teacherId = params.get("teacherId").toString();
						 String courseCode = params.get("courseCode").toString();
						 String courseTimeId = params.get("courseTimeId").toString();
						 String coursePlaceId = params.get("coursePlaceId").toString();
						 String courseRoomId = params.get("courseRoomId").toString();
						 Timestamp attendTime = new Timestamp(System.currentTimeMillis());
						 Timestamp lastUpdateTime = new Timestamp(System.currentTimeMillis());
						 AttendRecord bean = attendRecordMapper.getStartTime(params.get("courseTimeId").toString());
						 if(bean!=null) {
							 Date t = new Date();
							 SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd ");
							 String startDate = df.format(t) + bean.getStartTime();
							 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							 int num = 0;
							 if(sdf.parse(startDate).getTime()>attendTime.getTime()) {
								 num =attendRecordMapper.updateRecord("Y",attendTime, lastUpdateTime, teacherId, courseCode, courseTimeId, coursePlaceId, courseRoomId, idString);
							 }else {
								 num =attendRecordMapper.updateRecord("L",attendTime, lastUpdateTime, teacherId, courseCode, courseTimeId, coursePlaceId, courseRoomId, idString);
							 }
							 logger.info("更新记录考勤成功记录数为"+num);
						 }
						 list = attendRecordMapper.listStudentIn(teacherId, courseCode, courseTimeId, coursePlaceId, courseRoomId); 
					 }else {
						 logger.info("未监测到学生");
						 String teacherId = params.get("teacherId").toString();
						 String courseCode = params.get("courseCode").toString();
						 String courseTimeId = params.get("courseTimeId").toString();
						 String coursePlaceId = params.get("coursePlaceId").toString();
						 String courseRoomId = params.get("courseRoomId").toString();
						 list = attendRecordMapper.listStudentIn(teacherId, courseCode, courseTimeId, coursePlaceId, courseRoomId);
					 }
				}
			    response.close();
			} catch (IOException e) {
			    e.printStackTrace();
			}
			logger.info("开始上传图片到七牛云");
			Map<String, Object> hashMap = QiNiuUtil.uploadPhoto(QiNiuUtil.base64ToMultipart(params.get("doc").toString()), qiNiu);
			logger.info("七牛云返回：" + hashMap);
		}
		return list;
	}
	
	public List<Map<String, Object>> getCountInfo(Map<String, Object> param){
		if(param!=null) {
			if(param.get("startDate")!=null && param.get("startDate")!="" && !param.get("startDate").equals("") ) {
				 String startDate = param.get("startDate").toString();
				 String startDateTime = startDate +" 00:00:00";
				 param.put("startDateTime", startDateTime);
			}
			
			if(param.get("endDate")!=null && param.get("endDate")!="" && !param.get("endDate").equals("")) {
				 String endDate = param.get("endDate").toString();
				 String endDateTime = endDate +" 23:59:59";
				 param.put("endDateTime", endDateTime);
			}
			
		}
		return attendRecordMapper.getCountInfo(param);
	}
}
