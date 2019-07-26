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
		 <div style="margin-bottom:5px">
			<a href="javascript:void(0);" onclick="add();" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加学生</a>
			<a href="javascript:void(0);" onclick="edit();" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑学生</a>
			<a href="javascript:void(0);" onclick="delete();" class="easyui-linkbutton" iconCls="icon-remove" plain="true">批量删除</a>
		</div>
		<div>
			<span>姓名:</span>
			<input id="studentName" style="line-height:20px;border:1px solid #ccc">
			<span>班级:</span>
			<input id="studentClass" style="line-height:20px;border:1px solid #ccc">
			<span>学号:</span>
			<input id="studentNum" style="line-height:20px;border:1px solid #ccc">
			<span>学院:</span>
			<select id="collegeId" style="line-height:20px;border:1px solid #ccc">
			<option value="">全部</option>
			</select>
			<a href="#" class="easyui-linkbutton" plain="true" onclick="doSearch()">查询</a>
	    </div>
	  </div> 
<script type="text/javascript">

function add(){
	
	 $("#college").val("");
	 $("#class").val("");
	 $("#name").val("");
	 $("#student_num").val("");
	 $("#phone").val("");
	 $("#sex").val("男");
	 $("#studentId").val("");
	$('#win').window('open');
}
function edit(){
	var selRows = $('#dg').datagrid('getSelections');
	if(selRows.length==0){
		$.messager.alert('提示','请先选中一行');    
		return;
	}else if(selRows.length>=2){
		$.messager.alert('提示','只能选中一行编辑');    
		return;
	}	
	
	$.ajax({
	url:'<%=basePath%>/student/selectStudentById.do?studentId='+selRows[0].studentId,
			type : 'post',
			dataType : "json",
			contentType : 'application/json',
			success : function(data) {
				
				 $("#college").val(data.collegeId);
				 $("#class").val(data.studentClass);
				 $("#name").val(data.studentName);
				 $("#student_num").val(data.studentNum);
				 $("#phone").val(data.studentPhone);
				 $("#sex").val(data.studentSex);
				 $("#studentId").val(data.studentId);
			}

		});
	
	$('#win').window('open');
}
	
function deleteStudent(){
	var selRows = $('#dg').datagrid('getSelections');
	if(selRows.length==0){
		$.messager.alert('提示','请先选中一行');    
		return;
	}else{
		var ids = "";
		for(var i=0;i<selRows.length;i++){
			if(ids==""){
				ids=selRows[i].studentId;
			}else{
				ids=ids+","+selRows[i].studentId;
			}
		}
		$.ajax({
			url:'<%=basePath%>/student/deleteStudent.do?ids='+ids,
					type : 'post',
					success : function(data) {
						if(data>0){
							alert("删除成功！");
							$("#dg").datagrid('reload');
						}					
					}
				});	
	}
}
function doSearch(){
	$('#dg').datagrid('load',{
		studentName: $('#studentName').val(),
		studentClass: $('#studentClass').val(),
		studentNum: $('#studentNum').val(),
		collegeId: $('#collegeId').val()
	});
}
	
$('#dg').datagrid({    
    url:'<%=basePath%>/student/selectStudent.do',    
    columns:[[ 
    	{checkbox:true},
        {field:'studentId',title:'id',width:100,align:'center'},    
        {field:'studentName',title:'姓名',width:100,align:'center'}, 
        {field:'studentSex',title:'性别',width:100,align:'center'},
        {field:'studentClass',title:'班级',width:150,align:'center'},
        {field:'studentNum',title:'学号',width:150,align:'center'},
        {field:'collegeName',title:'学院',width:150,align:'center',formatter: function(value,row,index){
        	return row.college.collegeName;
        }
        },
        {field:'studentPhone',title:'电话',width:100,align:'center'}
        
       
    ]],
    pagination:true,
    fit:true,
    pageSize:20,
    striped:true,
   // singleSelect:true,
	onDblClickRow: function(rowIndex,rowData){
		
		$.ajax({
			url:'<%=basePath%>/student/selectStudentById.do?studentId='+rowData.studentId,
					type : 'post',
					dataType : "json",
					contentType : 'application/json',
					success : function(data) {
						
						 $("#college").val(data.collegeId);
						 $("#class").val(data.studentClass);
						 $("#name").val(data.studentName);
						 $("#student_num").val(data.studentNum);
						 $("#phone").val(data.studentPhone);
						 $("#sex").val(data.studentSex);
						 $("#studentId").val(data.studentId);
					}
				});
			$('#win').window('open');
		
	}

});
function getcollege(){
	$.ajax({
		url:'<%=basePath%>/college/getColleges.do',
				type : 'post',
				dataType : "json",
				contentType : 'application/json',
				success : function(data) {
					 for(var i=0;i<data.length;i++){
						$("#collegeId").append('<option value="'+data[i].college_id+'">'+data[i].college_name+'</option>');
						$("#college").append('<option value="'+data[i].college_id+'">'+data[i].college_name+'</option>');
					}
					
				}

			});
	
}		
$(function(){	
	getcollege();	
});
function ok(){

	 if( $("#name").val()==""){
		 alert("姓名不为空！")
		 return;
	 }
	 if( $("#sex").val()==""){
		 alert("性别不为空！")
		 return;
	 }
	 if( $("#class").val()==""){
		 alert("班级不为空！")
		 return;
	 }
	 if( $("#student_num").val()==""){
		 alert("学号不为空！")
		 return;
	 }
	 if( $("#college").val()==""){
		 alert("学院不为空！")
		 return;
	 }
	 if( $("#phone").val()==""){
		 alert("电话不为空！")
		 return;
	 }
	 if($("#studentId").val()==""||$("#studentId").val()==0){
			 $.ajax({
					url:'<%=basePath%>/student/insertStudent.do',
							type : 'post',
							data : $("#form1").serializeObject(),
							dataType : "json",
							contentType : 'application/json',
							success : function(data) {
								if(data==1){
									alert("插入成功！")
									$('#win').window('close');
									$('#dg').datagrid('reload'); 
								}			
							}
						});
	     }else{
	    	 
	    	 $.ajax({
					url:'<%=basePath%>/student/updateStudent.do',
							type : 'post',
							data : $("#form1").serializeObject(),
							dataType : "json",
							contentType : 'application/json',
							success : function(data) {
								if(data==1){
									alert("更新成功！")
									$('#win').window('close');
									$('#dg').datagrid('reload'); 
								}			
							}
						});
	    	 
	     }
	
 }
 function cancel(){
	 $('#win').window('close');
 }
</script>

<div id="win" class="easyui-window" closed="true" title="学生管理" style="width:500px;height:300px;">
	<center>
	<form style="padding:10px 20px 10px 40px;" id="form1">
	    <input type="hidden" id="studentId" name="studentId" value="0">
		<p>姓名: <input type="text" id="name" name="name"><span style="color:red;"> *</span></p>
		<p>性别: <select name="sex" id="sex" style="line-height:20px;border:1px solid #ccc;width:130px;">
			<option value="男">男</option>
			<option value="女">女</option>
			</select><span style="color:red;"> *</span></p>
		<p>班级: <input type="text" id="class" name="class"><span style="color:red;"> *</span></p>
		<p>学号: <input type="text" id="student_num" name="studentNum"><span style="color:red;"> *</span></p>
		<p>学院: <select name="college" id="college" style="line-height:20px;border:1px solid #ccc;width:130px;">
			<option value="">全部</option>
			</select><span style="color:red;"> *</span></p>
		<p>电话: <input type="text" id="phone" name="phone"><span style="color:red;"> *</span></p>
		<div style="padding:5px;text-align:center;">
			<a href="javascript:void(0);" onclick="ok()" class="easyui-linkbutton" icon="icon-ok">确定</a>
			<a href="javascript:void(0);" onclick="cancel()" class="easyui-linkbutton" icon="icon-cancel">取消</a>
		</div>
	</form>
	</center>
</div>


</body>
</html>