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
		
	    if($("#college_name").val()==''){
	    	alert("学院名称不能为空");
			$("#text").focus();
			return false;
		}
	    college_name
		if($("#college_id").val()==''){
			add();
		}else{
			edit();
		}
		
		
	}

	//新增数据
	function add() {
		$.ajax({
	        url:'<%=basePath%>college/addCollege.do',
			type : 'post',
			data : $("#form1").serializeObject(),
			dataType : "json",
			contentType : 'application/json',
			success : function(data) {
			
				if (data == 1) {
					alert("添加成功！")
				}
				
				DG.curWin.location.reload(); 
			}

		});
		
	}
	
	//编辑数据
	function edit() {		
		$.ajax({
	        url:'<%=basePath%>college/updateCollege.do',
			type : 'post',
			data : $("#form1").serializeObject(),
			dataType : "json",
			contentType : 'application/json',
			success : function(data) {
			
				if (data == 1) {
					alert("修改成功！")
				}
				
				DG.curWin.location.reload();
			}

		});

	}

</script>
</head>
<body style="background-color: #FFFFFF">
	<div>

		<table align="center" style="margin-top: 30px;">
			
			<form id="form1">
			<input type="hidden" name="college_id" id="college_id" value="${college_id}" />
			
			<tr height="35px;">
				<th bgcolor="#FFFFFF" class="filename"
					align="right" style="width:100px;background-color: #87CEFA ">学院名称： </th>
					
				<td class="right_bg">
				<input name="college_name" type="text" id="college_name" value="${college_name }"
					tabindex="1" class="input" maxlength="10" style="width: 150px;height:22px;padding: 0;"  /> <span
					style="color: red">*</span></td>
			</tr>
			
			</form>

		</table>
	</div>
</html>