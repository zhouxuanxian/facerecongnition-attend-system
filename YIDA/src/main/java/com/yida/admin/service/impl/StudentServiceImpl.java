package com.yida.admin.service.impl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.yida.admin.bean.Student;
import com.yida.admin.mapper.StudentMapper;
import com.yida.admin.service.StudentService;


@Service
public class StudentServiceImpl implements StudentService{

	@Autowired
	private StudentMapper studentMapper;

	public int insert(Map<String, Object> params) {
		Student student = new Student();
	    if (params!=null) {
			if (!params.get("class").equals("null")&&!params.get("class").equals("")&&params.get("class").toString()!=null) {
				student.setStudentClass(params.get("class").toString());
			}
			if (!params.get("name").equals("null")&&!params.get("name").equals("")&&params.get("name").toString()!=null) {
				student.setStudentName(params.get("name").toString());
			}
			if (!params.get("sex").equals("null")&&!params.get("sex").equals("")&&params.get("sex").toString()!=null) {
				student.setStudentSex(params.get("sex").toString());
			}
			if (!params.get("studentNum").equals("null")&&!params.get("studentNum").equals("")&&params.get("studentNum").toString()!=null) {
				student.setStudentNum(params.get("studentNum").toString());
			}
			if (!params.get("college").equals("null")&&!params.get("college").equals("")&&params.get("college").toString()!=null) {
				student.setCollegeId(Integer.parseInt(params.get("college").toString()));
			}
			if (!params.get("phone").equals("null")&&!params.get("phone").equals("")&&params.get("phone").toString()!=null) {
				student.setStudentPhone(params.get("phone").toString());
			}
		}
		return studentMapper.insert(student);
	}
	
	public List<Student> select(Map<String , Object> params){
		QueryWrapper<Student> queryWrapper=new QueryWrapper<>();
		
		if (params!=null) {
			if (params.get("studentName")!=null&&!params.get("studentName").equals("")) {
				queryWrapper.like("student_name", params.get("studentName").toString());
				
			}
			if (params.get("studentClass")!=null&&!params.get("studentClass").equals("")) {
				queryWrapper.eq("student_class", params.get("studentClass").toString());
				
			}
			if (params.get("studentNum")!=null&&!params.get("studentNum").equals("")) {
				queryWrapper.eq("student_num", params.get("studentNum").toString());
				
			}
			if (params.get("collegeId")!=null&&!params.get("collegeId").equals("")) {
				queryWrapper.eq("college_id", params.get("collegeId").toString());
		
			}
		}
		
		System.out.println("queryWrapper.getSqlSelect():"+queryWrapper.getSqlSelect());
		
		
		List<Student> list = studentMapper.selectList(queryWrapper);
		return list;
	}
    
    public Map<String, Object> getAll(Map<String , Object> params) {
    	if (params!=null) {
    		int pageSize=Integer.parseInt(params.get("rows").toString());
			int startIndex=(Integer.parseInt(params.get("page").toString())-1)*pageSize;
			params.put("pageSize", pageSize);
			params.put("startIndex", startIndex);
		}
    	
    	int count = studentMapper.count(params);
    	List<Student> list =studentMapper.getAll(params);
        Map<String, Object> hMap=new HashMap<>();
        hMap.put("total", count);
        hMap.put("rows", list);
    	return hMap;
    }
	
    public Student selectStudentById(Integer studentId) {
    	return studentMapper.selectById(studentId);
    }

    public int update(Map<String, Object> params) {
    	Student student = new Student();
	    if (params!=null) {
			if (!params.get("class").equals("null")&&!params.get("class").equals("")&&params.get("class").toString()!=null) {
				student.setStudentClass(params.get("class").toString());
			}
			if (!params.get("name").equals("null")&&!params.get("name").equals("")&&params.get("name").toString()!=null) {
				student.setStudentName(params.get("name").toString());
			}
			if (!params.get("sex").equals("null")&&!params.get("sex").equals("")&&params.get("sex").toString()!=null) {
				student.setStudentSex(params.get("sex").toString());
			}
			if (!params.get("studentNum").equals("null")&&!params.get("studentNum").equals("")&&params.get("studentNum").toString()!=null) {
				student.setStudentNum(params.get("studentNum").toString());
			}
			if (!params.get("college").equals("null")&&!params.get("college").equals("")&&params.get("college").toString()!=null) {
				student.setCollegeId(Integer.parseInt(params.get("college").toString()));
			}
			if (!params.get("phone").equals("null")&&!params.get("phone").equals("")&&params.get("phone").toString()!=null) {
				student.setStudentPhone(params.get("phone").toString());
			}
		}
	    student.setStudentId(Integer.parseInt(params.get("studentId").toString()));
	  
    	return studentMapper.updateById(student);
    }

    public int delete(String ids) {
    	return studentMapper.deleteByIds(ids);
    }

    public List<Student> listStudentByNum(String studentNum) {
		return studentMapper.listStudentByNum(studentNum);
	}
}

