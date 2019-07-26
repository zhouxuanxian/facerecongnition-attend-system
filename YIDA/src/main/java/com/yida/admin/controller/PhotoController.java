package com.yida.admin.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.yida.admin.service.PhotoService;






/**
 * 
 * @ClassName PhotoController
 * @Description 
 * @Author 周轩衔
 * @Date 2018年12月20日 下午9:37:05
 */

@RestController
@RequestMapping(value="/photo")
public class PhotoController {
	

	
	Logger logger = LoggerFactory.getLogger(getClass());
    
	@Autowired
	private PhotoService photoService;
	
	/**
	 * 
	* @Title: identify
	* @Description: 人脸收集的接口
	* @param params
	* @return void
	* @throws
	 */
	@RequestMapping(value="/sendPhoto.do")
	public int identify(@RequestParam Map<String , Object> params) {
		
		try {
			return photoService.identify(params);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

}
