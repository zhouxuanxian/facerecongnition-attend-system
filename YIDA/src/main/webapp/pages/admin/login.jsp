<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
%>
<!DOCTYPE html>
<html>
<head>
	<title>人脸识别考勤后台管理系统</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath %>/static/css/login.css">
	

	<!--<link href='//fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
-->
	<!-- For-Mobile-Apps-and-Meta-Tags -->
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="keywords" content="Simple Login Form Widget Responsive, Login Form Web Template, Flat Pricing Tables, Flat Drop-Downs, Sign-Up Web Templates, Flat Web Templates, Login Sign-up Responsive Web Template, Smartphone Compatible Web Template, Free Web Designs for Nokia, Samsung, LG, Sony Ericsson, Motorola Web Design" />
		<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
	<!-- //For-Mobile-Apps-and-Meta-Tags -->

</head>

<body>
    <h1>人脸识别考勤后台管理系统</h1>
    <div class="container w3">
        <h2>现在登录</h2>
		<form action="<%=basePath %>/teacher/getLogin.do" method="post">
			<div class="username">
				<span class="username" style="height:19px">教工号:</span>
				<input type="text" name="teacherNum" class="name" placeholder="" required="">
				<div class="clear"></div>
			</div>
			<div class="password-agileits">
				<span class="username"style="height:19px">密码:</span>
				<input type="password" name="password" class="password" placeholder="" required="">
				<div class="clear"></div>
			</div>
			<div class="rem-for-agile">
				<!-- <label><input type="checkbox" name="remember" class="remember">记得我</label> -->
				<!-- <a href="#">忘记了密码</a><br> -->
			</div>
			<div class="login-w3">
					<input type="submit" class="login" value="登录">
			</div>
			<div class="clear"></div>
		</form>
	</div>
	<div class="footer-w3l">
		<p>五邑大学</p>
	</div>
</body>
</html>