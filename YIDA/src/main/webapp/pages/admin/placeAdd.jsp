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
		//alert($("#starttm").val()+","+$("#endtm").val())
		if ($.trim($("#place").val()) == "") {
			alert("地点不能为空");
			$("#place").focus();
			return false;
		}
		if($("#id").val()==''){
			addPlace();
		}else{
			editPlace();
		}
		
		
	}

	//新增数据
	function addPlace() {
		$.ajax({
			type : "post",
			url : "<%=basePath%>admin/addPlace.do",
			data : {
				place : $("#place").val(),
			},
			cache : false,
			async : false,
			success : function(data) {
				if (data > 0) {
					alert("添加成功!");
				 	DG.curWin.location.reload();
				}else{
					alert("保存失败!");
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert("加载失败!");

			}
		});

	}
	
	//编辑数据
	function editPlace() {
		$.ajax({
			type : "post",
			url : "<%=basePath%>admin/doEditPlace.do",
			data : {
				place : $("#place").val(),
				id:$("#id").val()
			},
			cache : false,
			async : false,
			success : function(data) {
				if (data > 0) {
					alert("修改成功!");
				 	DG.curWin.location.reload();
				}else{
					alert("保存失败!");
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert("加载失败!");

			}
		});

	}
</script>
</head>
<body style="background-color: #FFFFFF">
	<div>
		<input type="hidden" name="id" id="id" value="${id }" />
		<table align="center" style="margin-top: 10px;">
			<br>

			<tr height="35px;" style="margin-top: 40px;">
				<th bgcolor="#FFFFFF" id="placeName" class="filename"
					align="right" style="width:100px;background-color: #87CEFA ">地点： </th>
					
				<td class="right_bg">
				<input name="place" type="text" id="place" value="${place }"
					tabindex="1" class="input" maxlength="10" style="width: 150px;height:22px;padding: 0;"  /> <span
					style="color: red">*</span></td>
			</tr>
			
	<!-- 		<tr>
				<td align="left" bgcolor="#FFFFFF" style="width:100px;background-color: #87CEFA;">活动时间</td>
				<td align="left" bgcolor="#FFFFFF" colspan="3"><input
					type="text" style="width: 150px" tabindex="13" id="starttm"
					name="starttm"
					onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
					class="Wdate" readonly>
					至<input
					type="text" style="width: 150px" tabindex="13" id="endtm"
					name="endtm"
					onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
					class="Wdate" readonly></td>
			</tr>
 -->


		</table>
	</div>
</html>