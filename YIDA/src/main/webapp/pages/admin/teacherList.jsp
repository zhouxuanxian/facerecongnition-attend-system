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
</head>
<body>

	<table id="dg" toolbar="#tb">
	</table>
	
	 <div id="tb" style="height:auto;padding:10px">
		 <div style="margin-bottom:5px">
			<a href="javascript:void(0);" onclick="add();" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加教师</a>
			<a href="javascript:void(0);" onclick="edit();" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑教师</a>
			<a href="javascript:void(0);" onclick="deleteTeacher();" class="easyui-linkbutton" iconCls="icon-remove" plain="true">批量删除</a>
		</div>
		<div>
			<span>姓名:</span>
			<input id="teacherName" style="line-height:20px;border:1px solid #ccc">
			<span>教工号:</span>
			<input id="teacherNum" style="line-height:20px;border:1px solid #ccc">
			
			<a href="#" class="easyui-linkbutton" plain="true" onclick="doSearch()">查询</a>
	    </div>
	  </div> 
<script type="text/javascript">

function add(){
	
	 $("#name").val("");
	 $("#teacher_num").val("");
	 $("#phone").val("");
	 $("#sex").val("男");
	 $("#teacherId").val("");
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
	url:'<%=basePath%>/teacher/getTeacherById.do?id='+selRows[0].teacherId,
			type : 'post',
			dataType : "json",
			contentType : 'application/json',
			success : function(data) {
				 $("#name").val(data.teacherName);
				 $("#teacher_num").val(data.teacherNum);
				 $("#phone").val(data.phone);
				 $("#sex").val(data.sex);
				 $("#teacherId").val(data.teacherId);
			}

		});
	
	$('#win').window('open');
}
	
function deleteTeacher(){
	var selRows = $('#dg').datagrid('getSelections');
	if(selRows.length==0){
		$.messager.alert('提示','请先选中一行');    
		return;
	}else{
		var ids = "";
		for(var i=0;i<selRows.length;i++){
			if(ids==""){
				ids=selRows[i].teacherId;
			}else{
				ids=ids+","+selRows[i].teacherId;
			}
		}
		
		$.ajax({
			url:'<%=basePath%>/teacher/deleteTeacher.do?ids='+ids,
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
		teacherName: $('#teacherName').val(),
		teacherNum: $('#teacherNum').val()
	});
}
	
$('#dg').datagrid({    
    url:'<%=basePath%>/teacher/getTeachers.do',    
    columns:[[ 
    	{checkbox:true},
    	{field:'teacherId',title:'id',width:100,align:'center'},    
        {field:'teacherName',title:'姓名',width:100,align:'center'}, 
        {field:'sex',title:'性别',width:100,align:'center'},
        {field:'teacherNum',title:'教工号',width:100,align:'center'},
        {field:'phone',title:'电话',width:100,align:'center'}
    ]],
    pagination:true,
    fit:true,
    pageSize:20,
    //striped:true,
   // singleSelect:true,
	onDblClickRow: function(rowIndex,rowData){
		
		$.ajax({
			url:'<%=basePath%>/teacher/getTeacherById.do?id='+rowData.teacherId,
					type : 'post',
					dataType : "json",
					contentType : 'application/json',
					success : function(data) {
						 $("#name").val(data.teacherName);
						 $("#teacher_num").val(data.teacherNum);
						 $("#phone").val(data.phone);
						 $("#sex").val(data.sex);
						 $("#teacherId").val(data.teacherId);
					}
				});
			$('#win').window('open');
		
	}

});
function ok(){
	//alert($("#form1").serializeObject())
	 if($("#name").val()==""){
		 alert("姓名不为空！")
		 return;
	 }
	 if($("#sex").val()==""){
		 alert("性别不为空！")
		 return;
	 }
	 if($("#teacher_num").val()==""){
		 alert("教工号不为空！")
		 return;
	 }
	 if($("#phone").val()==""){
		 alert("电话不为空！")
		 return;
	 }
	 if($("#teacherId").val()==""||$("#teacherId").val()==0||$("#teacherId").val()=="0"){
		     
			 $.ajax({
					url:'<%=basePath%>/teacher/insert.do',
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
					url:'<%=basePath%>/teacher/update.do',
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

<div id="win" class="easyui-window" closed="true" title="教师管理" style="width:500px;height:300px;">
	<center>
	<form style="padding:10px 20px 10px 40px;" id="form1">
	    <input type="hidden" id="teacherId" name="teacherId" value="0">
		<p>姓名: <input type="text" id="name" name="name"><span style="color:red;"> *</span></p>
		<p>性别: <select name="sex" id="sex" style="line-height:20px;border:1px solid #ccc;width:130px;">
			<option value="男">男</option>
			<option value="女">女</option>
			</select><span style="color:red;"> *</span></p>
		<p>教工号: <input type="text" id="teacher_num" name="teacherNum"><span style="color:red;"> *</span></p>
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