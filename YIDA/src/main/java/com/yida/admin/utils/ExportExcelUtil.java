package com.yida.admin.utils;

import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
/**
 * 
 * @ClassName ExportExcelUtil
 * @Description 实体类导出到excel 的工具类
 * @Author zxx
 * @Date Mar 24, 2019 1:38:45 PM
 */
public class ExportExcelUtil {
	
	/**
	 * 
	* @Title: export
	* @Description: 实体类导出到excel 的静态方法
	* @param fileName  定义文件名
	* @param headString 定义表格标题
	* @param sheetName 定义工作表表名
	* @param thead 定义表头内容
	* @param sheetWidth 定义每一列宽度
	* @param list 数据List<Map<String, Object>>
	* @param response HttpServletResponse
	* @throws Exception
	* @return void
	* @throws
	 */
	public static void export(String fileName,String headString,String sheetName,String[] thead,int[] sheetWidth,List<Map<String, Object>> list,HttpServletResponse response) throws Exception { 
		
		//String fileName = "菜单.xls";        // 定义文件名
		fileName = URLEncoder.encode(fileName, "UTF-8"); 
		//String headString = "菜单信息表";          // 定义表格标题
		//String sheetName = "工作表一";                  // 定义工作表表名
		//String[] thead = {"id","菜单名","状态","图标","父id","路径"};                    // 定义表头内容
		//int[] sheetWidth = {3000,3500,3500,5000,3000,5000};   // 定义每一列宽度
		HSSFWorkbook wb = new HSSFWorkbook();           // 创建Excel文档对象
		HSSFSheet sheet = wb.createSheet(sheetName);    // 创建工作表
		// ①创建表格标题 result.get(0).size() - 1为表格占用列数，从0开始
		ExcelUtil.createHeadTittle(wb, sheet, headString, list.get(0).size() - 1);
		// ②创建表头
		ExcelUtil.createThead(wb, sheet, thead, sheetWidth);
		// ③填入数据
		ExcelUtil.createTable(wb, sheet, list);
	    response.setContentType("application/octet-stream");
        response.setHeader("Content-disposition", "attachment;filename=" + fileName);
        response.flushBuffer();
        wb.write(response.getOutputStream());
		
	}

}
