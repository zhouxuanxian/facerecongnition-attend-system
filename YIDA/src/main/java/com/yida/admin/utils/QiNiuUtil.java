package com.yida.admin.utils;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.qiniu.common.QiniuException;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.UploadManager;
import com.qiniu.storage.model.DefaultPutRet;
import com.qiniu.util.Auth;
import com.yida.admin.bean.QiNiu;
import sun.misc.BASE64Decoder;



/**
 * @ClassName QiNiuUtil
 * @Description 
 * @Author 周轩衔
 * @Date 2019年3月18日 下午5:11:38
 */

public class QiNiuUtil {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
    /**
     * 
    * @Title: base64ToMultipart
    * @Description:  图片base64 转 MultipartFile
    * @param  base64
    * @param @throws IOException
    * @return MultipartFile
    * @throws
     */
	public static MultipartFile base64ToMultipart(String base64) {
		try {
	        String[] baseStrs = base64.split(",");
	        BASE64Decoder decoder = new BASE64Decoder();
	        byte[] b = new byte[0];
	        b = decoder.decodeBuffer(baseStrs[1]);
	        for(int i = 0; i < b.length; ++i) {
	            if (b[i] < 0) {
	                b[i] += 256;
	            }
	        }
	        return new BASE64DecodedMultipartFile(b, baseStrs[0]);
	    } catch (IOException e) {
	        e.printStackTrace();
	        return null;
	    }
	}
	
	/**
	* @Title: uploadPhoto
	* @Description: 图片上传到七牛云的工具类
	* @param file
	* @param qiNiu
	* @return
	* @throws Exception
	* @return Map<String,Object>
	* @throws
	 */
    public static Map<String, Object> uploadPhoto(MultipartFile file,QiNiu qiNiu) throws Exception {
    	Map<String, Object> hMap = new HashMap<>();
    	//构造一个带指定Zone对象的配置类
    	Configuration cfg = new Configuration(Zone.zone2());
    	//...其他参数参考类注释
    	UploadManager uploadManager = new UploadManager(cfg);
    	//...生成上传凭证，然后准备上传
    	String accessKey = qiNiu.getAccessKey();
    	String secretKey = qiNiu.getSecretKey();
    	String bucket = qiNiu.getBucket();
    	//以文件内容的fileName作为文件名
    	String fileName = file.getOriginalFilename();//xxx.jpg
        String uuid = UUID.randomUUID().toString();//abcd
        String newFileName = uuid + fileName.substring(fileName.lastIndexOf("."));//新的文件名
    	Auth auth = Auth.create(accessKey, secretKey);
    	String upToken = auth.uploadToken(bucket);
    	try {
    	    Response response = uploadManager.put(file.getBytes(), newFileName, upToken);
    	    //解析上传成功的结果
    	    DefaultPutRet putRet = new Gson().fromJson(response.bodyString(), DefaultPutRet.class);
    	    hMap.put("state", "SUCCESS");
    	    hMap.put("key", putRet.key);
    	    hMap.put("hash", putRet.hash);
    	    hMap.put("url", "http:/"+qiNiu.getDomain()+"/"+putRet.key);
    	} catch (QiniuException ex) {
    	    Response r = ex.response;
    	    System.err.println(r.toString());
    	    hMap.put("state", "ERROR");
    	    hMap.put("key", "");
    	    hMap.put("hash", "");
    	    hMap.put("url", "");
    	}
    	return hMap;
    }
	

}
