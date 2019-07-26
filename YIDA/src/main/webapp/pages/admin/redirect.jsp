<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>重定向</title>

<script src="<%=basePath%>/static/js/bootstrap3/js/jquery-3.3.1.min.js"></script>
</head>
<body>
<script type="text/javascript">
$(function(){
	 alert("账户或密码错误，请重新输入！")
	 window.location.href = '<%=basePath %>/pages/admin/login.jsp';
})
</script>
</body>
</html>