package com.yida.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;


/**
 * 
 * @ClassName CollegeMapper
 * @Description 学院的mapper层，操作数据库
 * @Author 周轩衔
 * @Date 2018年12月9日 下午6:59:57
 */
public interface CollegeMapper {
	
	/**
	 * 
	* @Title: selectCollege
	* @Description: 根据分页获取学院信息
	* @param startIndex
	* @param rows
	* @return
	* @return List<Map<String,Object>>
	* @throws
	 */
	@Select("select * from college order by college_id asc LIMIT #{startIndex},#{rows}")
	List<Map<String, Object>> selectCollege(@Param("startIndex")Integer startIndex,@Param("rows")Integer rows);
	
	
	@Select("select * from college order by college_id asc")
	List<Map<String, Object>> selectColleges();
	
	
	@Select("select * from college where college_id=#{college_id}")
	List<Map<String, Object>> selectCollegeById(@Param("college_id")Integer college_id);
	

	/**
	 * 
	* @Title: countCollege
	* @Description: 学院总记录数
	* @return
	* @return int
	* @throws
	 */
	@Select("SELECT COUNT(*) as num FROM college")
	int countCollege();
	
	/**
	 * 
	* @Title: addCollege
	* @Description: 添加学院
	* @param params
	* @return
	* @return int
	* @throws
	 */
	@Insert("INSERT INTO college(college_name) VALUES(#{college_name})")
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
	@Update("UPDATE college set college_name=#{college_name} WHERE college_id=#{college_id}")
	int updateCollege(Map<String, Object> params);
	
	@Delete("DELETE FROM college where college_id in (${ids})")
	int deleteCollege(@Param(value="ids")String ids);

}
