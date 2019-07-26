<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/easyui/themes/IconExtension.css">
<script type="text/javascript" src="<%=basePath%>/static/js/easyui/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/jsonHandler.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/easyui/locale/easyui-lang-zh_CN.js"></script>

<style type="text/css">
		.left{
			width:120px;
			float:left;
		}
		.left table{
			background:#E0ECFF;
		}
		.left td{
			background:#eee;
		}
		.right{
			float:right;
			width:600px;
		}
		.right table{
			background:#E0ECFF;
			width:100%;
		}
		.right td{
			background:#fafafa;
			text-align:center;
			padding:2px;
		}
		.right td{
			background:#E0ECFF;
		}
		.right td.drop{
			background:#fafafa;
			width:100px;
		}
		.right td.over{
			background:#FBEC88;
		}
		.item{
			text-align:center;
			border:1px solid #499B33;
			background:#fafafa;
			width:100px;
		}
		.assigned{
			border:1px solid #BC2A4D;
		}
		
	</style>
	<script>
		$(function(){
			$('.left .item').draggable({
				revert:true,
				proxy:'clone'
			});
			$('.right td.drop').droppable({
				onDragEnter:function(){
					$(this).addClass('over');
				},
				onDragLeave:function(){
					$(this).removeClass('over');
				},
				onDrop:function(e,source){
					$(this).removeClass('over');
					if ($(source).hasClass('assigned')){
						$(this).append(source);
					} else {
						var c = $(source).clone().addClass('assigned');
						$(this).empty().append(c);
						c.draggable({
							revert:true
						});
					}
				}
			});
		});
	</script>
</head>
<body>
<div style="width:750px;">
	<div class="left">
		<table>
			<tr>
				<td><div class="item">English</div></td>
			</tr>
			<tr>
				<td><div class="item">Science</div></td>
			</tr>
			<tr>
				<td><div class="item">Music</div></td>
			</tr>
			<tr>
				<td><div class="item">History</div></td>
			</tr>
			<tr>
				<td><div class="item">Computer</div></td>
			</tr>
			<tr>
				<td><div class="item">Mathematics</div></td>
			</tr>
			<tr>
				<td><div class="item">Arts</div></td>
			</tr>
			<tr>
				<td><div class="item">Ethics</div></td>
			</tr>
		</table>
	</div>
	<div class="right">
		<table>
			<tr>
				<td class="blank"></td>
				<td class="title">Monday</td>
				<td class="title">Tuesday</td>
				<td class="title">Wednesday</td>
				<td class="title">Thursday</td>
				<td class="title">Friday</td>
			</tr>
			<tr>
				<td class="time">08:00</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>
			<tr>
				<td class="time">09:00</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>
			<tr>
				<td class="time">10:00</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>
			<tr>
				<td class="time">11:00</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>
			<tr>
				<td class="time">12:00</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>
			<tr>
				<td class="time">13:00</td>
				<td class="lunch" colspan="5">Lunch</td>
			</tr>
			<tr>
				<td class="time">14:00</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>
			<tr>
				<td class="time">15:00</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>
			<tr>
				<td class="time">16:00</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>
		</table>
	</div>
</div>
</body>
</html>