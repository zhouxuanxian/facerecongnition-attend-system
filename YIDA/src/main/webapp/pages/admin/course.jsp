<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>课程管理</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/easyui/themes/IconExtension.css">
<script type="text/javascript" src="<%=basePath%>/static/js/easyui/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/jsonHandler.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/easyui/locale/easyui-lang-zh_CN.js"></script>

</head>
<body>

	<table id="dg">
	
	</table>
	<script type="text/javascript">

	function doSearch(){
		$('#dg').datagrid('load',{
			course_code: $('#course_code').val(),
			student_name: $('#student_name').val(),
			teacher_name: $('#teacher_name').val()
		});
	}

	$('#dg').datagrid({    
    url:'<%=basePath%>/course/selectCourse.do',    
    columns:[[ 
    	{checkbox:true},
        {field:'id',title:'id',width:100,align:'center'},    
        {field:'courseCode',title:'课程代码',width:100,align:'center'},
        {field:'courseName',title:'课程名称',width:100,align:'center'},
       
    ]],
    pagination:true,
    fit:true,
    pageSize:20
    
	});


	</script>
</body>
</html>