<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>教师管理</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/easyui/themes/IconExtension.css">
<script type="text/javascript" src="<%=basePath%>/static/js/easyui/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/jsonHandler.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/easyui/locale/easyui-lang-zh_CN.js"></script>
	
<link href="<%=basePath%>/static/js/lhgdialog/skins/default.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath%>/static/js/lhgdialog/lhgcore.min.js" type="text/javascript"></script>
<script src="<%=basePath%>/static/js/lhgdialog/lhgdialog.min.js" type="text/javascript"></script>
<style>
.datagrid-cell, .datagrid-cell-group, .datagrid-header-rownumber, .datagrid-cell-rownumber{
	font-size:15px;
	font-family:"微软雅黑"
}
.datagrid-header .datagrid-cell span {
    font-size: 16px;
}
.panel-body {
   font-size:15px;
}
.l-btn-text {
   font-size:15px;
}
</style>
</head>
<body>

	<table id="dg" toolbar="#tb">
	</table>
	
	 <div id="tb" style="height:auto;padding:10px">
		<div>
		    <span>考勤时间:</span>
			<input id="startDate" type="text" class="easyui-datebox" > - <input id="endDate" type="text" class="easyui-datebox" >
			<span>授课老师:</span>
			<input id="teacherName" style="width:80px;line-height:20px;border:1px solid #ccc">
			<span>上课学生:</span>
			<input id="studentName" style="width:80px;line-height:20px;border:1px solid #ccc">
			<span>课程名称:</span>
			<input id="courseName" style="width:80px;line-height:20px;border:1px solid #ccc">
			<span>课程代码:</span>
			<input id="courseCode" style="width:80px;line-height:20px;border:1px solid #ccc">
			
			<span>考勤情况:</span>
			<select style="width:80px" id="attendStatus">
			<option value="">全部</option>
			<option value="Y">已到</option>
			<option value="N">缺席</option>
			<option value="I">迟到</option>
			</select>
			
			<a href="#" class="easyui-linkbutton" plain="true" onclick="doSearch()">查询</a>
	    </div>
	  </div> 
<script type="text/javascript">

function doSearch(){
	$('#dg').datagrid('load',{
		teacherName: $('#teacherName').val(),
		studentName: $('#studentName').val(),
		courseName: $('#courseName').val(),
		courseCode: $('#courseCode').val(),
		attendStatus: $('#attendStatus').val(),
		startDate: $('#startDate').datebox('getValue'),
		endDate: $('#endDate').datebox('getValue')
		
		
	});
}
	
$('#dg').datagrid({    
    url:'<%=basePath%>/attend/getAttendRecord.do',    
    columns:[[ 
    	{checkbox:true},
    	{field:'id',title:'id',width:80,align:'center'},    
        {field:'attendTime',title:'考勤时间',width:150,align:'center'}, 
        {field:'status',title:'考勤状态',width:80,align:'center',formatter: function(value,row,index){
        	if(row.status!='已到'){
        		return "<span style='color:red'>"+row.status+"</span>";
        	}else{
        		return row.status;
        	}
        	 
        }},
        {field:'teacherName',title:'授课老师',width:80,align:'center'},
        {field:'studentName',title:'上课学生',width:80,align:'center'},
        {field:'studentClass',title:'班级',width:80,align:'center'},
        {field:'courseName',title:'课程名称',width:100,align:'center'},
        {field:'courseCode',title:'课程代码',width:100,align:'center'},
        {field:'place',title:'上课地点',width:100,align:'center',formatter: function(value,row,index){
        	return row.place+" "+row.room;
        }
        },
        {field:'time',title:'上课时间',width:300,align:'center',formatter: function(value,row,index){
        	return row.week+" "+row.day+" "+row.node + " "+ row.startTime.substring(0,5)+"-"+row.endTime.substring(0,5);
        }
        }
        
    ]],
    pagination:true,
    fit:true,
    pageSize:20,
    striped:true,
    singleSelect:true,

});

</script>


</body>
</html>