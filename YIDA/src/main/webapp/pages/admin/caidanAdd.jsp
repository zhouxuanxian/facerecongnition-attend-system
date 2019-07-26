<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta content="IE=EmulateIE7" http-equiv="X-UA-Compatible" />
<title></title>
<script type="text/javascript" src="<%=basePath%>static/js/easyui/jquery.min.js"></script>
<link href="<%=basePath%>static/js/lhgdialog/skins/default.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath%>static/js/lhgdialog/lhgcore.min.js" type="text/javascript"></script>
<script src="<%=basePath%>static/js/lhgdialog/lhgdialog.min.js" type="text/javascript"></script>
<script src="<%=basePath%>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath%>static/js/jsonHandler.js"></script>
<style type="text/css">

.filename {
	font-size: 16px;
}
.input:focus {
    outline:none;
    border: 1px solid #87CEFA ;
}
</style>

<script language="javascript" type="text/javascript">
	var DG = frameElement.lhgDG;
	DG.addBtn('ok', '保存', function() {
		check();
	});

	function check() {
		
	    if($("#text").val()==''){
	    	alert("菜单名称不能为空");
			$("#text").focus();
			return false;
		}
	    if($("#iconCls").val()==''){
	    	alert("菜单图标不能为空");
			$("#iconCls").focus();
			return false;
		}
		
		
		if($("#id").val()==''){
			add();
		}else{
			edit();
		}
		
		
	}

	//新增数据
	function add() {
		$.ajax({
	        url:'<%=basePath%>admin/addCaiDan.do',
			type : 'post',
			data : $("#form1").serializeObject(),
			dataType : "json",
			contentType : 'application/json',
			success : function(data) {
			
				if (data == 1) {
					alert("添加成功！")
				}
				
				window.parent.location.reload(); 
			}

		});
		
	}
	
	//编辑数据
	function edit() {
		
		$.ajax({
	        url:'<%=basePath%>admin/addCaiDan.do',
			type : 'post',
			data : $("#form1").serializeObject(),
			dataType : "json",
			contentType : 'application/json',
			success : function(data) {
			
				if (data == 1) {
					alert("修改成功！")
				}
				
				window.parent.location.reload(); 
			}

		});

	}

	function getFirstNav(){
		$.ajax({
			url:'<%=basePath%>/admin/getAllNavs.do',
					type : 'post',
					data : {
						id:0
					},
					dataType : "json",
					contentType : 'application/json',
					success : function(data) {
									
						 for(var i=0;i<data.length;i++){
							
							$("#pid").append('<option value="'+data[i].id+'">'+data[i].text+'</option>')
						} 
						
						
						 $("#pid").val($("#pidValue").val());
						
					}

				});
		
	}		
			
	$(function(){	
		getFirstNav();	
		 $("#state").val($("#stateValue").val());
		
	});
</script>
</head>
<body style="background-color: #FFFFFF">
	<div>
		<input type="hidden" id="pidValue" value="${pid}" />
		<input type="hidden" id="stateValue" value="${state}" />
		<table align="center" style="margin-top: 10px;">
			
			<form id="form1">
			<input type="hidden" name="id" id="id" value="${id}" />
			
			<tr height="35px;" style="margin-top: 40px;">
				<th bgcolor="#FFFFFF" class="filename"
					align="right" style="width:100px;background-color: #87CEFA ">菜单名称： </th>
					
				<td class="right_bg">
				<input name="text" type="text" id="text" value="${text }"
					tabindex="1" class="input" maxlength="10" style="width: 150px;height:22px;padding: 0;"  /> <span
					style="color: red">*</span></td>
			</tr>
				<tr height="35px;" style="margin-top: 40px;">
				<th bgcolor="#FFFFFF" class="filename"
					align="right" style="width:100px;background-color: #87CEFA ">展开状态： </th>
					
				<td class="right_bg">
				<select name="state" id="state" style="width: 150px;">
						<option value="open">展开</option>
						<option value="closed">关闭</option>
					</select>
					
					</td>
			</tr>
				<tr height="35px;" style="margin-top: 40px;">
				<th bgcolor="#FFFFFF" class="filename"
					align="right" style="width:100px;background-color: #87CEFA ">菜单图标： </th>
					
				<td class="right_bg">
				<input name="iconCls" type="text" id="iconCls" value="${iconCls }"
					tabindex="1" class="input" style="width: 150px;height:22px;padding: 0;"  /> <span
					style="color: red">*</span></td>
			</tr>
			
		
			
		   <tr height="35px;" style="margin-top: 40px;">
				<th bgcolor="#FFFFFF" class="filename"
					align="right" style="width:100px;background-color: #87CEFA ">菜单链接： </th>
					
				<td class="right_bg">
				<input name="url" type="text" id="url" value="${url }"
					tabindex="1" class="input"  style="width: 150px;height:22px;padding: 0;"  /></td>
			</tr>
		
				<tr height="35px;" style="margin-top: 40px;">
				<th bgcolor="#FFFFFF" class="filename"
					align="right" style="width:100px;background-color: #87CEFA ">父标签键： </th>
					
				<td class="right_bg">
				<select name="pid" id="pid" style="width: 150px;">
						<option value="0" selected="selected">无</option>
				</select>
				</td>
			</tr>
			
			</form>

		</table>
	</div>
</html>