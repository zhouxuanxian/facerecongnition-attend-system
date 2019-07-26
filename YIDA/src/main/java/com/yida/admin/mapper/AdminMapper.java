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
 * @ClassName AdminMapper
 * @Description 
 * @Author 周轩衔
 * @Date 2018年10月9日 上午12:14:10
 */
public interface AdminMapper {

	/**
	* @Title: selectNavs
	* @Description: 通过pid查询菜单
	* @param @param id
	* @param @return
	* @return List<Map<String,Object>>
	* @throws
	 */
	@Select("SELECT * FROM admin_nav where pid=#{id}")
	List<Map<String, Object>> selectNavs(@Param("id") String id);
	
	/**
	 * 
	* @Title: selectAllCaiDan
	* @Description: 查询所有的菜单
	* @param @return
	* @return List<Map<String,Object>>
	* @throws
	 */
	@Select("SELECT id,text,state,iconCls,pid,url FROM admin_nav")
	List<Map<String, Object>> selectAllCaiDan();
	
	/**
	* @Title: selectNavsByPage
	* @Description: 分页查询
	* @param @param page
	* @param @param rows
	* @param @return
	* @return List<Map<String,Object>>
	* @throws
	 */
	@Select("SELECT * FROM admin_nav order by id asc LIMIT #{startIndex},#{rows}")
	List<Map<String, Object>> selectNavsByPage(@Param("startIndex") Integer startIndex ,@Param("rows") Integer rows);

    /**
    * @Title: countNavs
    * @Description: 查询总条数
    * @param @return
    * @return int
    * @throws
     */
	@Select("SELECT COUNT(*) as num FROM admin_nav")
	int countNavs();
	
	/**
	 * 
	* @Title: addCaiDan
	* @Description: 添加菜单
	* @param @param params
	* @param @return
	* @return int
	* @throws
	 */

	@Insert("INSERT INTO admin_nav(text,state,iconCls,pid,url) VALUES(#{text},#{state},#{iconCls},#{pid},#{url} )")
	int addCaiDan(Map<String , Object> params);
	
	/**
	 * @Description: 根据菜单id查找出菜单
	 * @param id
	 * @return 
	 */
	@Select("SELECT * FROM admin_nav where id=#{id}")
	List<Map<String, Object>> selectCaiDanById(@Param("id") String id);
	/**
	 * 
	* @Title: deleteCaiDan
	* @Description: 删除菜单
	* @param @param id
	* @param @return
	* @return int
	* @throws
	 */
	@Delete("DELETE  FROM admin_nav WHERE id in (${ids})")
	int deleteCaiDan(@Param(value="ids") String ids);
	
	/**
	 * 
	* @Title: updateCaiDan
	* @Description: 更新菜单
	* @param @return
	* @return int
	* @throws
	 */
	@Update("UPDATE admin_nav SET text=#{text},state=#{state},iconCls=#{iconCls},pid=#{pid},url=#{url} WHERE id=#{id}")
	int updateCaiDan(Map<String , Object> params);
	
	/**
	 * 
	* @Title: selectPlaceByPage
	* @Description: 查找地点，分页
	* @param @param page
	* @param @param rows
	* @param @return
	* @return List<Map<String,Object>>
	* @throws
	 */
	@Select("SELECT * FROM yida_place order by id asc LIMIT #{startIndex},#{rows}")
	List<Map<String, Object>> selectPlaceByPage(@Param("startIndex")Integer startIndex , @Param("rows")Integer rows);
	
	/**
	* @Title: countPlace
	* @Description: 地点的总条数
	* @param @return
	* @return int
	* @throws
	 */
	@Select("SELECT COUNT(*) as num FROM yida_place")
	int countPlace();
	
	/**
	* @Title: addPlace
	* @Description: 添加地点
	* @param @param place
	* @param @return
	* @return int
	* @throws
	 */
	@Insert("INSERT INTO yida_place(place) VALUES (#{place})")
	int addPlace(@Param("place") String place);
	
	@Update("UPDATE yida_place SET place=#{place} WHERE id=#{id}") 
	int editPlace(@Param("place") String place,@Param("id")int id);
}
