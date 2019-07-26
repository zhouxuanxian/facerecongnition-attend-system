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
     <div align="left" style="margin-top:10px;margin-left:10px;padding:10px;">
         <form class="form-inline">
	    
	     <div class="form-group" style="width:15%">
	       <input type="text" class="form-control" id="teacherName" placeholder="教师姓名" >
	     </div>
	     <a class="btn btn-primary" href="javascript:void(0);" role="button" onclick="findTeacher()">查询</a>
	     <div class="form-group" style="width:30%">
	         <label for="studentId">请确认上课教师</label>
			 <select class="form-control" id="teacherId" style="width:40%">
			 </select>
		</div>
		  <div class="form-group" style="width:15%">
	       <input type="text" class="form-control" id="courseName" placeholder="课程名称" >
	     </div>
	     <a class="btn btn-primary" href="javascript:void(0);" role="button" onclick="findCourse()">查询</a>
	     <div class="form-group" style="width:30%">
	         <label for="studentId">请确认上课课程</label>
			 <select class="form-control" id="courseCode" style="width:40%">
			 </select>
		</div>
	     </form>
	     
	     <div style="margin-top:10px;margin-left:10px;padding:10px;">
	     <form class="form-inline" style="margin-top:10px;">
	     	 <div class="form-group" style="width:100%">
	     	     <div style="float:left;width:20%">
		            <label for="coursePlaceId">上课地点</label>
				    <select class="form-control" id="coursePlaceId" style="width:70%;">
				 </select>
				 </div>
				 
				   <div style="float:left;width:20%">
				   <label for="courseRoomId">课室号</label>
				   <select class="form-control" id="courseRoomId"  style="width:70%;">
			       </select>
			       </div>
			         <div style="float:left;width:40%">
			        <label for="courseTimeId">上课时间</label>
				   <select class="form-control" id="courseTimeId"  style="width:70%;">
			       </select>
			       </div>
			     <div style="float:left;">
	             
	             </div>
		    </div>
		 
		 </form>
		
	     </div>
	     
	    <div style="width:100%;float:left">
	    <div style="width:12%;height:100px;margin-left:10px;float:left;margin-top:30px;">
			<div style="height:10%;font-size:16px;">选择上课的班级</div>
			<div style="overflow:auto;height:90%;font-size:14px;padding-left:30px;padding-top:10px;margin-top:10px;" align="left" id="systemList">
			
			</div>
	    </div>
	    
	    <div style="float:left;width:10%;margin-top:30px;margin-left:20px;">
	      <Button id="capture" class="btn btn-primary" onclick="startBase()" >开始考勤</Button>
	      <button id="start" class="btn btn-primary" style="display:none;" onclick="start()">手动采集识别</button>
	     </div>
	     
	      <div style="margin-top:30px;float:left;margin-left:20px;">
		  <video id="video" width="480" height="320" style="border:1px solid red" autoplay></video>
		  <canvas id="canvas" width="480" height="320" style="display:none;"></canvas> 
		</div>
	     
	    </div>
	   
	
		
</div>


	<div align="left" style="margin-top:50px;margin-left:20px">
		   <div style="font-size:16px;margin-bottom:10px;color:red">已考勤学生:</div>
		   
		   <div id="studentIn">
		    
		   </div>
		   
		</div>


<br>
<br>
  
  <script>
  
  $(function(){
	  var status = 0;
	  getCoursePlace();
	  getCourseRoom();
	  getCourseTime();
	  getTeacher();
	  getCourse();  
	  listClass();
	  
	  setInterval(scroll,2000);
	  
  });
  function startBase(){
	 
		var listClass = ""; 

        $('input[name="system"]:checked').each(function(){ 
        	if(listClass!=""){
        		listClass += "," + $(this).val();
        	}else{
        		listClass = $(this).val();
        	}
        		
        });
        console.log(listClass);
        if(listClass.length<=0){
        	alert('请选择系统！');
        	return;
        }
       

		  $("#capture").hide();
		  $("#start").show();
		  
		  
        var post_data = {
      		  //doc: base64Data,
      		  ydClass: listClass,
      		  teacherId: $("#teacherId").val(),
      		  courseCode: $("#courseCode").val(),
      		  courseTimeId:  $("#courseTimeId").val(),
      		  coursePlaceId:  $("#coursePlaceId").val(),
      		  courseRoomId:  $("#courseRoomId").val(),
           };
        console.log(post_data)
       
        $.ajax({
        	
            url: '<%=basePath%>/attend/insertBaseInfo.do',
            type: "POST",
            data: post_data,
            success: function (data) {
            	console.log(data)
              if(data>0){
            	  status = 1;
              }
              
            }
        });
        
	  
  }
  
  function listClass(){
	  $.ajax({
          url: '<%=basePath%>/course/listClass.do',
          type: "GET",
          success: function (data) {
           
            if(data.length>0){
            	for(var i=0,len=data.length;i<len;i++){
            		  $("#systemList").append('<label><input type="checkbox" name="system" value="'+data[i].studentClass+'">&nbsp;&nbsp;'+data[i].studentClass+'</label><br>');            		  
            	}
            }
          }
      });
  }  
  function getCoursePlace(){
	  console.log("查询所有的地点");
	  $.ajax({
          url: '<%=basePath%>/course/selectCoursePlace.do',
          type: "GET",
          success: function (data) {
           
            if(data.length>0){
            	for(var i=0,len=data.length;i<len;i++){
            		 $("#coursePlaceId").append('<option value="'+data[i].id+'">'+data[i].place+'</option>');
            
            	}
            }
          }
      });
  }
  
  function getCourseRoom(){
	  console.log("查询所有的课室");
	  $.ajax({
          url: '<%=basePath%>/course/selectCourseRoom.do',
          type: "GET",
          success: function (data) {
           
            if(data.length>0){
            	for(var i=0,len=data.length;i<len;i++){
            		 $("#courseRoomId").append('<option value="'+data[i].id+'">'+data[i].room+'</option>')
            	}
            }
          }
      });
  }
  function getCourseTime(){
	  console.log("查询所有的上课时间");
	  $.ajax({
          url: '<%=basePath%>/course/selectCourseTime.do',
          type: "GET",
          success: function (data) {
           
            if(data.length>0){
            	for(var i=0,len=data.length;i<len;i++){
            		 $("#courseTimeId").append('<option value="'+data[i].id+'">'+data[i].week+' '+data[i].day+' '+data[i].node+' '+data[i].start_time+'-'+data[i].end_time+'</option>')
            	}
            }
          }
      });
  }
  
  function getTeacher(){
	  console.log("查询所有的laoshi");
	  $.ajax({
          url: '<%=basePath%>/course/selectTeacher.do',
          type: "GET",
          success: function (data) {
           
            if(data.length>0){
            	for(var i=0,len=data.length;i<len;i++){
            		 $("#teacherId").append('<option value="'+data[i].teacher_id+'">'+data[i].teacher_name+'</option>')
            	}
            }
          }
      });
  }
  
  function getCourse(){
	  console.log("查询所有的kecheng");
	  $.ajax({
          url: '<%=basePath%>/course/listCourse.do',
          type: "GET",
          success: function (data) {
           
            if(data.length>0){
            	for(var i=0,len=data.length;i<len;i++){
            		 $("#courseCode").append('<option value="'+data[i].course_code+'">'+data[i].course_name+'</option>')
            	}
            }
          }
      });
  }
  
 
  
  
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
  	  context.drawImage(video, 0, 0, 480, 320);      
        //获取浏览器页面的画布对象
        //以下开始编 数据
        var imgData = canvas.toDataURL("image/jpg");
        //将图像转换为base64数据
        var base64Data = imgData.split(",")[1];
        if(status>0){
        	
        
        console.log("开始识别")
        var listClass = ""; 
        $('input[name="system"]:checked').each(function(){ 
        	if(listClass!=""){
        		listClass += "," + $(this).val();
        	}else{
        		listClass = $(this).val();
        	}
        		
        });
      
        
          var post_data = {
        		  doc: imgData, 	
          		  teacherId: $("#teacherId").val(),
          		  courseCode: $("#courseCode").val(),
          		  courseTimeId:  $("#courseTimeId").val(),
          		  coursePlaceId:  $("#coursePlaceId").val(),
          		  courseRoomId:  $("#courseRoomId").val(),
          		  ydClass: listClass
             };
          console.log(post_data)
          
          $.ajax({
          	
              url: '<%=basePath%>/attend/startDetection.do',
              type: "POST",
              data: post_data,
              success: function (data) {
            	$("#studentIn").empty();
                if(data.length>0){
                	for(var i=0,len=data.length;i<len;i++){
                		$("#studentIn").append('<span style="margin-left:10px;">'+data[i].studentName+'</span>')
                	}
                }
                
              }
          });
        }
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
    function start(){
    	  context.drawImage(video, 0, 0, 480, 320);      
          //获取浏览器页面的画布对象
          //以下开始编 数据
          var imgData = canvas.toDataURL("image/jpg");
          //将图像转换为base64数据
     
          var listClass = ""; 

        $('input[name="system"]:checked').each(function(){ 
        	if(listClass!=""){
        		listClass += "," + $(this).val();
        	}else{
        		listClass = $(this).val();
        	}
        		
        });
      
        
          var post_data = {
        		  doc: imgData, 	
          		  teacherId: $("#teacherId").val(),
          		  courseCode: $("#courseCode").val(),
          		  courseTimeId:  $("#courseTimeId").val(),
          		  coursePlaceId:  $("#coursePlaceId").val(),
          		  courseRoomId:  $("#courseRoomId").val(),
          		  ydClass: listClass
             };
          console.log(post_data)
          
          $.ajax({
          	
              url: '<%=basePath%>/attend/startDetection.do',
              type: "POST",
              data: post_data,
              success: function (data) {
            	$("#studentIn").empty();
                if(data.length>0){
                	for(var i=0,len=data.length;i<len;i++){
                		$("#studentIn").append('<span style="margin-left:10px;">'+data[i].studentName+'</span>')
                	}
                }
                
              }
          });
    
    }
  
   
    
  </script>
</body>
</html>