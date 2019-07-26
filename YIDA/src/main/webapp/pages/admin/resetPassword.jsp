<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>修改密码</title>

  
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/bootstrap3/css/bootstrap.min.css">
      <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/bootstrap3/css/bootstrapValidator.css">
    <%--   <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/bootstrap3/css/bootstrap-table.min.css"> --%>
   
   <style type="text/css">
   .row{
   margin-top:20px;
   }
   </style>
  </head>
  <body >
  <input type="hidden" id="teacherNum" value="${teacherNum}">
  <div style="padding:30px;">
	
	
           
           
           <div>
           
           
			 <form class="form-horizontal" id="defaultForm">
			  <div class="form-group">
			    <label for="password" class="col-sm-4 control-label">设置密码</label>
			    <div class="col-sm-5">
			      <input type="password" class="form-control" name="password" id="password" placeholder="请输入大于等于6位的密码">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="confirmPassword" class="col-sm-4 control-label">确认密码</label>
			    <div class="col-sm-5">
			      <input type="password" class="form-control" name="confirmPassword"  placeholder="请确认密码">
			    </div>
			  </div>
			
				  <div class="form-group">
				    <div class="col-sm-offset-6 col-sm-7">
				      <button type="submit" class="btn btn-default" id="submit">提交</button>
				      <a  class="btn btn-default" role="button"  href="javascript:void(0);" onclick="javascript:history.back(-1);">取消</a>
				    </div>
				  </div>
			</form>
           
           
           </div>



			



</div>

  <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="<%=basePath%>/static/js/bootstrap3/js/jquery-3.3.1.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="<%=basePath%>/static/js/bootstrap3/js/bootstrap.min.js"></script>
<%--     <script src="<%=basePath%>/static/js/bootstrap3/js/bootstrap-table.min.js"></script>
    <script src="<%=basePath%>/static/js/bootstrap3/js/bootstrap-table-locale-all.min.js"></script> --%>
    <script src="<%=basePath%>/static/js/bootstrap3/js/bootstrapValidator.js"></script>
    
    <%-- <script type="text/javascript" src="<%=basePath%>/static/js/jsonHandler.js"></script> --%>

<script type="text/javascript">


$(function() {
	
	if($("#teacherNum").val()==""){
		alert('登录已过期，请重新登录！');    
		window.location.href = '<%=basePath %>/teacher/login.do';
	} 
	
	$('#defaultForm').bootstrapValidator({
		 //message: 'This value is not valid',
         feedbackIcons: {/*input状态样式图片*/
             valid: 'glyphicon glyphicon-ok',
             invalid: 'glyphicon glyphicon-remove',
             validating: 'glyphicon glyphicon-refresh'
         },
         fields: {
        password: {
            validators: {
                notEmpty: {
                    message: '设置密码不为空'
                },
                stringLength: {
                    min: 6,
                    max: 20,
                    message: '密码长度为6-20'
                },
	              identical: {
	                   field: 'confirmPassword',
	                  message: '两次密码不一致'
	               }
             }
         },
         confirmPassword: {
             validators: {
                 notEmpty: {
                     message: '确认密码不为空'
                 },
                 stringLength: {
                     min: 6,
                     max: 20,
                     message: '密码长度为6-20'
                 },
                 identical: {
                     field: 'password',
                     message: '两次密码不一致'
                 }
             }
         }
         
         }

 });
 
 $("#submit").on("click",function(){

	   var bootstrapValidator = $("#defaultForm").data('bootstrapValidator');
	   bootstrapValidator.validate();
	   console.log(bootstrapValidator.isValid())
	   if(bootstrapValidator.isValid()){
		   $.ajax({
				url:'<%=basePath%>/teacher/updatePassword.do',
						type: 'post',
						data: {
							password: $("#password").val(),
							teacherNum: $("#teacherNum").val()
						},
						success: function(data) {
							if(data){
								alert("密码修改成功,请重新登录！")
								window.location.href = '<%=basePath %>/teacher/login.do';
							}				
						}
				});	
	   }
	   else{
		   return;
	   }
		   
	 
 });
 
 
});
	

</script>

  
 
  </body>
</html>