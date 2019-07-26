package com.yida.admin.controller;


import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.servlet4preview.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yida.admin.service.AdminService;
import com.yida.admin.utils.ExportExcelUtil;






@Controller
@RequestMapping(value="/admin")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private HttpServletRequest request;
	
	//菜单
	@RequestMapping(value="/getAllNavs.do")
	@ResponseBody
	public List<Map<String , Object>> getAllNavs(@RequestParam(defaultValue="0") String id) {
		return adminService.selectNavs(id);
	}
	
	@RequestMapping(value="/getCaiDan.do")
	@ResponseBody
	public Map<String , Object> getNavs(Integer page, Integer rows ) {
		
		System.out.println(page+"|"+rows);
		return adminService.selectNavsByPage(page, rows);
	}
	
	@RequestMapping(value="/addCaiDan.do")
	@ResponseBody
	public int addCaiDan(@RequestBody Map<String , Object> params) {
		
		int res = 0;
		if(params.get("id")!="") {
			res = adminService.updateCaiDan(params);
		}else {
			
			res=adminService.addCaiDan(params);
		}
		return res;
	}
	@RequestMapping(value="/deleteCaiDan.do")
	@ResponseBody
	public int deleteCaiDan(String ids) {
		//System.out.println("ids:"+ids);
		return adminService.deleteCaiDan(ids);
	}
	
	@RequestMapping(value="/editCaiDan.do")
	public String editCaiDan(String id) {
		System.out.println("id:"+id);
		List<Map<String, Object>> list =adminService.selectCaiDanById(id); 
		if(list.size()>0) {
			System.out.println("list:"+list.get(0));
			request.setAttribute("id", id);
			request.setAttribute("text", list.get(0).get("text"));
			request.setAttribute("state", list.get(0).get("state"));
			request.setAttribute("iconCls", list.get(0).get("iconCls"));
			request.setAttribute("url", list.get(0).get("url"));
			request.setAttribute("pid", list.get(0).get("pid"));
		}
		
		return "/admin/caidanAdd.jsp";
	}
	
	
	//地点
	
	@RequestMapping(value="/getPlace.do")
	@ResponseBody
	public Map<String, Object> getPlace(Integer page, Integer rows ){
		
		System.out.println(page+"|"+rows);
		return adminService.selectPlaceByPage(page, rows);
	}
	
	@RequestMapping(value="/addPlace.do")
	@ResponseBody
	public int addPlace(String place) {
		//System.out.println(place);
		return adminService.addPlace(place);
	}
	
	@RequestMapping(value="/editPlace.do")
	public String editPlace(String id,String place,HttpServletRequest request) {
		request.setAttribute("id", id);
		request.setAttribute("place", place);
		return "/admin/placeAdd.jsp";
	}
	
	@RequestMapping(value="/doEditPlace.do")
	@ResponseBody
	public int doEditPlace(String id ,String place) {
		int res = 0;
		res = adminService.editPlace(place, Integer.parseInt(id));
		
		return res;
	}
	
	@RequestMapping(value="/doExcelByCaiDan.do",method=RequestMethod.GET)
	@ResponseBody
	public void doExcelByCaiDan(HttpServletResponse response) throws Exception {
		List<Map<String,Object>> result = adminService.selectAllCaiDan();
		Iterator<Map<String, Object>> ite = result.iterator();
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		while(ite.hasNext()) {
			Map<String, Object> linkMap = new LinkedHashMap<String, Object>();
			Map m=ite.next();
			if(m!=null) {
				String id = "";
				if(m.get("id")!=null&&!m.get("id").equals("null")&&!m.get("id").equals("")){
					id = m.get("id").toString();
				}
				linkMap.put("id", id);
				String text = "";
				if(m.get("text")!=null&&!m.get("text").equals("null")&&!m.get("text").equals("")){
					text = m.get("text").toString();
				}
				linkMap.put("text", text);
				String state = "";
				if(m.get("state")!=null&&!m.get("state").equals("null")&&!m.get("state").equals("")){
					if(m.get("state").equals("open")) {
						state="展开";
					}
					if(m.get("state").equals("closed")) {
						state="关闭";
					}
				}
				linkMap.put("state", state);
				String iconCls = "";
				if(m.get("iconCls")!=null&&!m.get("iconCls").equals("null")&&!m.get("iconCls").equals("")){
					iconCls = m.get("iconCls").toString();
				}
				linkMap.put("iconCls", iconCls);
				String pid = "";
				if(m.get("pid")!=null&&!m.get("pid").equals("null")&&!m.get("pid").equals("")){
					pid = m.get("pid").toString();
				}
				linkMap.put("pid", pid);
				String url = "-";
				if(m.get("url")!=null&&!m.get("url").equals("null")&&!m.get("url").equals("")){
					url = m.get("url").toString();
				}
				linkMap.put("url", url);			
			}
		    list.add(linkMap);
		}
		String fileName = "菜单.xls";        // 定义文件名
		//fileName = URLEncoder.encode(fileName, "UTF-8"); 
		String headString = "菜单信息表";          // 定义表格标题
		String sheetName = "工作表一";                  // 定义工作表表名
		String[] thead = {"id","菜单名","状态","图标","父id","路径"};                    // 定义表头内容
		int[] sheetWidth = {3000,3500,3500,5000,3000,5000};   // 定义每一列宽度
		ExportExcelUtil.export(fileName, headString, sheetName, thead, sheetWidth, list, response);
	}

}
