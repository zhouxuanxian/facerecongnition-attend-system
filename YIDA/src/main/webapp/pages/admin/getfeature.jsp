<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/bootstrap3/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/easyui/themes/IconExtension.css">

<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="<%=basePath%>/static/js/bootstrap3/js/jquery-3.3.1.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="<%=basePath%>/static/js/bootstrap3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/easyui/jquery.easyui.min.js"></script>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>摄像头拍照</title>
</head>
<body align="center" > <!-- onload="setInterval('scroll()',200)" -->

<div>
    <h2>收集人脸信息</h2>
    <div>
    <div style="margin-bottom:20px;margin-top:20px;">
	    <form class="form-inline">
	    
	      <div class="form-group" style="width:25%">
	       <label for="studentNum">学号</label>
	       <input type="text" class="form-control" id="studentNum" placeholder="请输入学号" >
	     </div>
	     <a class="btn btn-primary" href="javascript:void(0);" role="button" onclick="findStudent()">查询</a>
	     <div class="form-group" style="width:40%">
	         <label for="studentId">请确认选择的学生</label>
			 <select class="form-control" id="studentId" style="width:40%">
			 </select>
		</div>
	     </form>
	     
    </div>
   
    
    </div>
</div>

<div>
  <video id="video" width="480" height="320" style="border:1px solid red" autoplay></video>
  <canvas id="canvas" width="480" height="320" ></canvas>
</div>



<br>
<br>
  <div style="margin:0 auto">
    <button id="capture" class="easyui-linkbutton" data-options="iconCls:'icon-search'">采集</button>
    
    <div align="center" id="message" style="color:red;margin-top:30px;">
    </div>
  </div>
  
  <script>
  
 
  
  
    //访问用户媒体设备的兼容方法
    function getUserMedia(constraints, success, error) {
      if (navigator.mediaDevices.getUserMedia) {
        //最新的标准API
        navigator.mediaDevices.getUserMedia(constraints).then(success).catch(error);
      } else if (navigator.webkitGetUserMedia) {
        //webkit核心浏览器
        navigator.webkitGetUserMedia(constraints,success, error)
      } else if (navigator.mozGetUserMedia) {
        //firfox浏览器
        navigator.mozGetUserMedia(constraints, success, error);
      } else if (navigator.getUserMedia) {
        //旧版API
        navigator.getUserMedia(constraints, success, error);
      }
    }

    let video = document.getElementById('video');
    let canvas = document.getElementById('canvas');
    let context = canvas.getContext('2d');

    function success(stream) {
	      //兼容webkit核心浏览器
	      let CompatibleURL = window.URL || window.webkitURL;
	      //将视频流设置为video元素的源
	      console.log("stream:"+stream);
	
	      //video.src = CompatibleURL.createObjectURL(stream);
	      video.srcObject = stream;
	      video.play();
    }
    
    function scroll(){
      $("#message").html("");
  	  context.drawImage(video, 0, 0, 480, 320);      
        //获取浏览器页面的画布对象
        //以下开始编 数据
        var imgData = canvas.toDataURL("image/jpg");
        //将图像转换为base64数据
        var base64Data = imgData.split(",")[1];
       /*  alert(imgData)
        alert(base64Data) */
        //ajax传输
        var options=$("#studentId option:selected");
        var post_data = {
        		doc: imgData,
        		studentId: options.val(),
        		studentName:options.text()
           };
      
        console.log("学生姓名："+options.text())
        return;
       $.ajax({
        	
            url: '<%=basePath%>/photo/sendPhoto.do', 
            type: "POST",
            data: post_data,  
            success: function (data) {
            	 if(data>0){
                 	$("#message").html(options.text()+"采集成功");
                 }
              
            }
        });
    }

    function error(error) {
          console.log(`访问用户媒体设备失败${error.name}, ${error.message}`);
    }

    if (navigator.mediaDevices.getUserMedia || navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia) {
	      //调用用户媒体设备, 访问摄像头
	      getUserMedia({video : {width: 480, height: 320}}, success, error);
    } else {
          alert('不支持访问用户媒体');
    }
    document.getElementById('capture').addEventListener('click', function () {
    	$("#message").html("");
    	if($("#studentId").val()==""){
    		alert("请先确认选择学生");
    		return;
    	}
    	  context.drawImage(video, 0, 0, 480, 320);      
          //获取浏览器页面的画布对象
          //以下开始编 数据
          var imgData = canvas.toDataURL("image/jpg");
          //将图像转换为base64数据
         // var base64Data = imgData.split(",")[1];
          
          var options=$("#studentId option:selected");
          var post_data = {
        		  doc: imgData,
          		  studentId: options.val(),
             };
         $.ajax({
          	
              url: '<%=basePath%>/photo/sendPhoto.do', 
              type: "POST",
              data: post_data,  
              success: function (data) {
              	 if(data>0){
                   	$("#message").html(options.text()+"采集成功");
                   }
                
              }
          });
    
    })
    
     function findStudent(){
      $("#studentId").empty();
	  $.ajax({
      	
          url: '<%=basePath%>/student/getStudent.do', 
          type: "POST",
          data: {
        	  studentNum: $("#studentNum").val()
          },
          success: function (data) {
          	console.log(data)
          	
          	if(data.length>0){
          		for (var i=0;i<data.length;i++){
          			$("#studentId").append('<option value="'+data[i].studentId+'">'+data[i].studentName+'</option>');
          		}
          		
          	}
            
          }
      });
  }
    
  </script>
</body>
</html>