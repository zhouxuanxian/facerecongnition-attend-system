package com.yida.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yida.admin.bean.Teacher;
import com.yida.admin.mapper.TeacherMapper;
import com.yida.admin.service.TeacherService;


@Service
public class TeacherServiceImpl implements TeacherService{
	
	@Autowired
	private TeacherMapper teacherMapper;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Override
	public Map<String, Object> login(Map<String, Object> param) {
		logger.info("开始校验输入的用户名密码");
		String teacherNum = null;
		String password = null;
		if(param!=null) {
			System.out.println(param.toString());
			if(param.get("teacherNum")!=null&&!param.get("teacherNum").equals("")&&!param.get("teacherNum").equals("null")) {
				teacherNum = param.get("teacherNum").toString();
			}
			if(param.get("password")!=null&&!param.get("password").equals("")&&!param.get("password").equals("null")) {
				password = param.get("password").toString();
			}
		}		
		List<Map<String, Object>> list = teacherMapper.login(teacherNum, password);
		if (list!=null&&list.size()>0) {
			logger.info("登陆成功！");
			return list.get(0);
			
		}else {
			logger.info("登陆失败！");
			return null;			
		}
		
	}

	public Map<String, Object> getAllTeachers(Map<String, Object> param){
		if (param!=null) {
    		int pageSize=Integer.parseInt(param.get("rows").toString());
			int startIndex=(Integer.parseInt(param.get("page").toString())-1)*pageSize;
			param.put("pageSize", pageSize);
			param.put("startIndex", startIndex);
		}	
    	int count = teacherMapper.selectCount(null);
    	List<Teacher> list =teacherMapper.getAllTeachers(param);
        Map<String, Object> hMap=new HashMap<>();
        hMap.put("total", count);
        hMap.put("rows", list);
    	return hMap;
	}

	public int insertTeacher(Map<String, Object> param) {
		Teacher teacher =new Teacher();
		if(param!=null) {
			teacher.setTeacherName(param.get("name").toString());
			teacher.setPhone(param.get("phone").toString());
			teacher.setSex(param.get("sex").toString());
			teacher.setTeacherNum(param.get("teacherNum").toString());	
		}
		return teacherMapper.insert(teacher);
	}

	public int update(Map<String, Object> param) {
		return teacherMapper.updateTeacherById(param);
	}
	
	public Teacher geTeacherById(Integer teacherId) {
		return teacherMapper.geTeacherById(teacherId);
	}
	
	public int delete(String ids) {
		return teacherMapper.deleteByIds(ids);
	}
	
	@Override
	public boolean updatePassword(String password ,String teacherNum ) {
		logger.info("修改密码的账户名为："+teacherNum+",新密码为："+password);
		if (teacherMapper.updatePassword(password, teacherNum)>0) {
			logger.info("密码更新成功");
			return true;
		}else {
			logger.info("密码更新失败");
			return false;
		}
	}

}
