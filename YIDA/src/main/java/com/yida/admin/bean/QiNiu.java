/**   
* @Title: QiNiu.java
* @Package com.vinda.bean
* @Description: 读取配置文件application.yml 中七牛云的配置信息
* @author 周轩衔  
* @date 2019年3月19日 上午9:30:35
*/
package com.yida.admin.bean;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;
@Component
@ConfigurationProperties(prefix = "qiniu")
public class QiNiu {
	private String accessKey;
	private String secretKey;
	private String domain;
	private String bucket;
	private String zone;
	public String getAccessKey() {
		return accessKey;
	}
	public void setAccessKey(String accessKey) {
		this.accessKey = accessKey;
	}
	public String getSecretKey() {
		return secretKey;
	}
	public void setSecretKey(String secretKey) {
		this.secretKey = secretKey;
	}
	public String getDomain() {
		return domain;
	}
	public void setDomain(String domain) {
		this.domain = domain;
	}
	public String getBucket() {
		return bucket;
	}
	public void setBucket(String bucket) {
		this.bucket = bucket;
	}
	public String getZone() {
		return zone;
	}
	public void setZone(String zone) {
		this.zone = zone;
	}
	
	

}
