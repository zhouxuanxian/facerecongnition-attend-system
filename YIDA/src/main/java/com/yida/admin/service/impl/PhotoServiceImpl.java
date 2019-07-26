package com.yida.admin.service.impl;

import java.io.IOException;
import java.sql.Timestamp;

import java.util.Map;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.alibaba.fastjson.JSONObject;
import com.yida.admin.bean.FaceCollect;
import com.yida.admin.bean.QiNiu;
import com.yida.admin.mapper.PhotoMapper;
import com.yida.admin.service.PhotoService;
import com.yida.admin.utils.QiNiuUtil;

import okhttp3.Call;
import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

@Service
public class PhotoServiceImpl implements PhotoService{

	@Autowired
	private  QiNiu qiNiu;
	
	@Autowired
	private PhotoMapper photoMapper;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Override
	public int identify(Map<String , Object> params) throws Exception  {
		int res = 0;
		
		if(params!=null) {
			String url = "http://120.79.140.190/getfeature/";
			OkHttpClient okHttpClient = new OkHttpClient();
			RequestBody body = new FormBody.Builder()
			    .add("doc", params.get("doc").toString().split(",")[1])
			    .build();
			Request request = new Request.Builder()
			    .url(url)
			    .post(body)
			    .build();
			Call call = okHttpClient.newCall(request);
			
			try {
			    Response response = call.execute();
			    logger.info("开始收集人脸信息，请求外部的识别接口成功返回！");
			    String result = response.body().string();
			    System.out.println(result);
			    if (result!=null) {
			    	
			    	JSONObject jsonObject = JSONObject.parseObject(result);
					JSONObject feabase64 = (JSONObject) jsonObject.get("feature_value");
					Integer num = (Integer) jsonObject.get("status");
					
					//当识别为一张人脸时
					if (num==1) {
						String featureId = "";
						String featureValue = "";
						for (Map.Entry<String, Object> entry : feabase64.entrySet()) {
							logger.info("返回的featureId为："+entry.getKey());
							logger.info("返回的featureValue为："+entry.getValue());
				            featureId = entry.getKey();
				            featureValue = (String) entry.getValue();
				            break;
				        }
						String studentId = "";
						if(params.get("studentId")!=null&&!params.get("studentId").equals("")&&!params.get("studentId").equals("null")) {
							studentId = params.get("studentId").toString();
						}
						Timestamp createTime = new Timestamp(System.currentTimeMillis());
						FaceCollect fCollect = new FaceCollect();
						fCollect.setCreateTime(createTime);
						fCollect.setFeatureId(featureId);
						fCollect.setFeatureValue(featureValue);
						fCollect.setStudentId(studentId);
						res = photoMapper.insert(fCollect);
						logger.info("收集人脸插入的记录数为："+res);
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
		return res;
	}
	
}
