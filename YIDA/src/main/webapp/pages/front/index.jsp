<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
</head>
<body>
<input value="<%=basePath %>">
<h1>hello zxx</h1>
<img alt="" src="<%=basePath %>/static/images/test.jpg">
</body>
</html>