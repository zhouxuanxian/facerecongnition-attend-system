<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/easyui/themes/IconExtension.css">
<script type="text/javascript" src="<%=basePath%>/static/js/easyui/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/jsonHandler.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/easyui/locale/easyui-lang-zh_CN.js"></script>
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

	<table id="dg">
	
	</table>
	<script type="text/javascript">


	$('#dg').datagrid({    
    url:'<%=basePath%>/course/getCourseRoom.do',    
    columns:[[ 
    	{checkbox:true},
        {field:'id',title:'id',width:100,align:'center'},    
        {field:'room',title:'课室',width:100,align:'center'},
      
    ]],
    pagination:true,
    fit:true,
    pageSize:20,
    striped:true
	});


	</script>
</body>
</html>