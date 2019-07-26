package com.yida.admin.service;

import java.util.List;
import java.util.Map;

public interface CollegeService {

	/**
	 * 
	* @Title: selectCollegeByPage
	* @Description: 根据分页获取学院的信息
	* @param page
	* @param rows
	* @return
	* @return Map<String,Object>
	* @throws
	 */
	Map<String, Object> selectCollegeByPage(Integer page, Integer rows);

	/**
	 * 
	* @Title: addCollege
	* @Description: 添加学院
	* @param params
	* @return
	* @return int
	* @throws
	 */
	int addCollege(Map<String, Object> params);

	/**
	 * 
	* @Title: updateCollege
	* @Description: 更新学院
	* @param params
	* @return
	* @return int
	* @throws
	 */
	int updateCollege(Map<String, Object> params);

	/**
	 * 
	* @Title: selectCollegeById
	* @Description: 根据学院ID查找学院的信息
	* @param college_id
	* @return
	* @return Map<String,Object>
	* @throws
	 */
	Map<String, Object> selectCollegeById(Integer college_id);

	int deleteCollege(String ids);

	List<Map<String, Object>> getColleges();

	
}
