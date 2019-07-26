package com.yida;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;

@EnableAutoConfiguration
@ComponentScan(basePackages= { "com.yida.*.controller" , "com.yida.*.service" , "com.yida.*.bean"})
@MapperScan(value="com.yida.*.mapper")
public class ApplicationStart {
	  public static void main(String[] args) {
			SpringApplication.run(ApplicationStart.class, args);	
		}
}
