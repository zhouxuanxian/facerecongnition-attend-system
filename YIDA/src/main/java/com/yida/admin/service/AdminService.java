package com.yida.admin.service;

import java.util.List;
import java.util.Map;

public interface AdminService {
    /**
     * 
    * @Title: selectNavs
    * @Description: 通过pid查询菜单
    * @param @param id
    * @param @return
    * @return List<Map<String,Object>>
    * @throws
     */
	List<Map<String, Object>> selectNavs(String id);
	/**
	* @Title: selectAllCaiDan
	* @Description: 查询所有的菜单
	* @param @return
	* @return List<Map<String,Object>>
	* @throws
	*/
	List<Map<String, Object>> selectAllCaiDan();
	
    /**
     * 
    * @Title: selectNavsByPage
    * @Description: 分页查询菜单
    * @param @param page
    * @param @param rows
    * @param @return
    * @return Map<String,Object>
    * @throws
     */
	Map<String, Object> selectNavsByPage(Integer page, Integer rows);
	
	/**
	 * 
	* @Title: addCaiDan
	* @Description: 查询总的菜单条数
	* @param @param params
	* @param @return
	* @return int
	* @throws
	 */
	int addCaiDan(Map<String, Object> params);
	

	/**
	* @Title: updateCaiDan
	* @Description: 更新菜单
	* @param @param text
	* @param @param state
	* @param @param iconCls
	* @param @param pid
	* @param @param url
	* @param @param id
	* @param @return
	* @return int
	* @throws
	*/
	int updateCaiDan(Map<String , Object> params);
	
	/**
	* @Title: deleteCaiDan
	* @Description: 删除菜单
	* @param @param id
	* @param @return
	* @return int
	* @throws
	*/
	int deleteCaiDan(String ids);
	
	/**
	* @Title: selectPlaceByPage
	* @Description: 通过分页选择地点
	* @param @param page
	* @param @param rows
	* @param @return
	* @return Map<String,Object>
	* @throws
	*/
	Map<String, Object> selectPlaceByPage(Integer page, Integer rows);

	/**
	* @Title: addPlace
	* @Description: 添加地点
	* @param @param place
	* @param @return
	* @return int
	* @throws
	*/
	int addPlace(String place);

	/**
	* @Title: selectOnlyPlaceByPage
	* @Description: 导出到excel查找数据
	* @param @param page
	* @param @param rows
	* @param @return
	* @return List<Map<String,Object>>
	* @throws
	*/
	List<Map<String, Object>> selectOnlyPlaceByPage(Integer page, Integer rows);

	
	int editPlace(String place,int id);
	
	/**
	 * @Description: 根据菜单id查找出菜单
	 * @param id
	 * @return
	 */
	List<Map<String, Object>> selectCaiDanById(String id);

}