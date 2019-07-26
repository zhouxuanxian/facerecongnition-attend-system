
package com.yida.admin.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yida.admin.service.CollegeService;

@Controller
@RequestMapping(value="/college")
public class CollegeController {
	
	@Autowired
	private CollegeService collegeService;
	
	/**
	* @Title: selectCollege
	* @Description: 根据分页获取学院信息
	* @param page
	* @param rows
	* @return
	* @return Map<String,Object>
	* @throws
	 */
	@RequestMapping(value="/selectCollege.do")
	@ResponseBody
	public Map<String, Object> selectCollege(Integer page,Integer rows){
		return collegeService.selectCollegeByPage(page, rows);
	}
	
	@RequestMapping(value="/getColleges.do")
	@ResponseBody
	public List<Map<String, Object>> getColleges(){
		return collegeService.getColleges();
	}
	
	/**
	 * 
	* @Title: addCollege
	* @Description: 添加学院
	* @param params
	* @return
	* @return int
	* @throws
	 */
	@RequestMapping(value="/addCollege.do")
	@ResponseBody
	public int addCollege(@RequestBody Map<String, Object> params) {
		return collegeService.addCollege(params);
	}
	
	@RequestMapping(value="/editCollege.do")
	public String editCollege(Integer college_id,HttpServletRequest request ) {
		
	    Map<String, Object> map = collegeService.selectCollegeById(college_id);
	    if(map!=null) {
	    	request.setAttribute("college_id", map.get("college_id"));
	    	request.setAttribute("college_name", map.get("college_name"));
	    }
		
		return "/admin/collegeAdd.jsp";
	}
	
	@RequestMapping(value="/updateCollege.do")
	@ResponseBody
	public int updateCollege(@RequestBody Map<String, Object> params) {
		return collegeService.updateCollege(params);
	}
	
	@RequestMapping(value="/deleteCollege.do")
	@ResponseBody
	public int deleteCollege(String ids) {
		return collegeService.deleteCollege(ids);
	}

}
