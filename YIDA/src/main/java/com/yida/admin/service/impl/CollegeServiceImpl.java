package com.yida.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yida.admin.mapper.CollegeMapper;
import com.yida.admin.service.CollegeService;



@Service
public class CollegeServiceImpl implements CollegeService{
	
	@Autowired
	private CollegeMapper collegeMapper;

	public Map<String, Object> selectCollegeByPage(Integer page, Integer rows){
		Integer startIndex=(page-1)*rows;
		List<Map<String,Object>> list = collegeMapper.selectCollege(startIndex, rows);
		int count = collegeMapper.countCollege();
		HashMap<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("rows", list);
		hMap.put("total", count);
		return hMap;
	}

	public List<Map<String, Object>> getColleges(){
		return collegeMapper.selectColleges();
	}
	
	public Map<String, Object> selectCollegeById(Integer college_id){
		List<Map<String,Object>> list = collegeMapper.selectCollegeById(college_id);
		if (list.size()>0) 
			return list.get(0);
	    else 
		    return null;
	}
	public int addCollege(Map<String, Object> params) {
		return collegeMapper.addCollege(params);
	}
	
	public int updateCollege(Map<String, Object> params) {
		return collegeMapper.updateCollege(params);
	}
	
	public int deleteCollege(String ids) {
		return collegeMapper.deleteCollege(ids);
	}
}
