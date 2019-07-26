package com.yida.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.yida.admin.mapper.AdminMapper;
import com.yida.admin.service.AdminService;



/**
 * 
 * @ClassName AdminServiceImpl
 * @Description 
 * @Author 周轩衔
 * @Date 2018年10月9日 上午12:14:43
 */

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminMapper adminMapper;
	

	public List<Map<String, Object>> selectNavs(String id){
		 return adminMapper.selectNavs(id);
		
	}

	public List<Map<String, Object>> selectAllCaiDan(){
		 return adminMapper.selectAllCaiDan();
		
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public Map<String, Object> selectNavsByPage(Integer page,Integer rows){
		
		 System.out.println(page+"|"+rows);

		 
		 Integer startIndex = (page-1)*rows;
		 List<Map<String, Object>> rowsLists = adminMapper.selectNavsByPage(startIndex, rows);
		 System.out.println(rowsLists);
		 int total = adminMapper.countNavs();
		 
		 Map<String, Object> hm = new HashMap<String, Object>();
		 
		 hm.put("total", total);
		 hm.put("rows", rowsLists);
		
		 return hm;
	}
    
	public int addCaiDan(Map<String , Object> params) {
		return adminMapper.addCaiDan(params);
	}
	

	public List<Map<String, Object>> selectCaiDanById(String id){
		return adminMapper.selectCaiDanById(id);
	}
	
	public int updateCaiDan(Map<String , Object> params) {
		return adminMapper.updateCaiDan(params);
		
	}
	public int deleteCaiDan(String ids) {
		int res = 0;	
	    System.out.println("ids:"+ids); 
		try {      
            	res=adminMapper.deleteCaiDan(ids);
		} catch (Exception e) {
		
			e.printStackTrace();
		}
	
		return res;
	}
   
	public Map<String, Object> selectPlaceByPage(Integer page,Integer rows){
		int startIndex = (page-1)*rows;
		List<Map<String, Object>> placeList = adminMapper.selectPlaceByPage(startIndex, rows);
		int total = adminMapper.countPlace();
		
		Map<String, Object> hm = new HashMap<String, Object>();
	    hm.put("rows", placeList);
	    hm.put("total", total);
		
		return hm;
	}
	
	
	public List<Map<String, Object>> selectOnlyPlaceByPage(Integer page,Integer rows){
		int startIndex = (page-1)*rows;
		List<Map<String, Object>> placeList = adminMapper.selectPlaceByPage(startIndex, rows);
		
		return placeList;
	}
	
	public int addPlace(String place) {
		return adminMapper.addPlace(place);
	}
	
	public int editPlace(String place,int id) {
		return adminMapper.editPlace(place, id);
	}

}
