<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>图表分析</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/bootstrap3/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/easyui/themes/IconExtension.css">
<%-- <script type="text/javascript" src="<%=basePath%>/static/js/easyui/jquery.min.js"></script> --%>
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="<%=basePath%>/static/js/bootstrap3/js/jquery-3.3.1.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="<%=basePath%>/static/js/bootstrap3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/jsonHandler.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/easyui/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript" src="<%=basePath%>/static/js/echarts.js"></script>
	
<link href="<%=basePath%>/static/js/lhgdialog/skins/default.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath%>/static/js/lhgdialog/lhgcore.min.js" type="text/javascript"></script>
<script src="<%=basePath%>/static/js/lhgdialog/lhgdialog.min.js" type="text/javascript"></script>
</head>
<body>
<div style="margin:5px;padding:10px">
<form class="form-inline">
	       <span>考勤时间:</span>
			<input id="startDate" type="text" class="easyui-datebox" > - <input id="endDate" type="text" class="easyui-datebox" >
			<span>授课老师:</span>
			<input id="teacherName" class="form-control"  style="width:80px;line-height:20px;border:1px solid #ccc">
			<span>上课学生:</span>
			<input id="studentName" class="form-control" style="width:80px;line-height:20px;border:1px solid #ccc">
			 <span>课程名称:</span>
			<input id="courseName"  class="form-control" style="width:80px;line-height:20px;border:1px solid #ccc">
			<span>课程代码:</span>
			<input id="courseCode"   class="form-control" style="width:80px;line-height:20px;border:1px solid #ccc">
			
			</form>
		
</div>
<div style="margin:5px;padding:10px">
	       
			<form class="form-inline">
			
			
			
			<span>上课地点:</span>
			
			<select class="form-control" id="coursePlaceId"  style="width:10%;">
			<option value="">全部</option>
			</select>
			     
			
			<span>课室号:</span>
			<select class="form-control" id="courseRoomId"  style="width:10%;">
			<option value="">全部</option>
			</select>
			
			<span>上课时间:</span>
			<select class="form-control" id="courseTimeId"  style="width:30%;">
			<option value="">全部</option>
			</select>
			
			<a href="#" class="btn btn-default" onclick="doSearch()">查询</a>
			
			  </form>
</div>
<hr style="height:5px;border:none;border-top:5px ridge green;" />
<form class="form-inline">
<div style="padding:2px;" >
<span>应到人数</span>&nbsp;&nbsp;<input id="count" disabled="disabled"  class="form-control"  style="color:red;" >
<span>实到人数</span>&nbsp;&nbsp;<input id="numberY" disabled="disabled" class="form-control" style="color:red;">
<span>缺席人数</span>&nbsp;&nbsp;<input id="numberN" disabled="disabled" class="form-control" style="color:red;">
<span>迟到人数</span>&nbsp;&nbsp;<input id="numberI" disabled="disabled" class="form-control" style="color:red;">
</div>
</form>

<div id="main" style="width: 600px;height:400px;margin-top:20px;margin-left:200px;">

</div>

<script type="text/javascript">

var myChart = echarts.init(document.getElementById('main'));

var option = {
	    title : {
	        text: '考勤情况统计图',
	        subtext: '五邑大学',
	        x:'center'
	    },
	    tooltip : {
	        trigger: 'item',
	        formatter: "{a} <br/>{b} : {c} ({d}%)"
	    },
	    legend: {
	        orient: 'vertical',
	        left: 'left',
	        data: ['旷课','迟到','已到']
	    },
	    series : [
	        {
	            name: '占比',
	            type: 'pie',
	            radius : '55%',
	            center: ['50%', '60%'],
	            data:[
	                {value:0, name:'旷课'},
	                {value:0, name:'迟到'},
	                {value:0, name:'已到'}
	            ],
	            itemStyle: {
	                emphasis: {
	                    shadowBlur: 10,
	                    shadowOffsetX: 0,
	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
	                }
	            }
	        }
	    ]
	};



$(function(){
	 getCoursePlace();
	  getCourseRoom();
	  getCourseTime();
	  
	var datas = {
			teacherName: $('#teacherName').val(),
			studentName: $('#studentName').val(),
			courseName: $('#courseName').val(),
			courseCode: $('#courseCode').val(),
			startDate: $('#startDate').datebox('getValue'),
			endDate: $('#endDate').datebox('getValue'),
			coursePlaceId:$("#coursePlaceId").val(),
			courseRoomId:$("#courseRoomId").val(),
			courseTimeId:$("#courseTimeId").val()
	};
	
	$.ajax({
         url:'<%=basePath%>/attend/getCountInfo.do',
		 type : 'post',
		 contentType:"application/json;charset=utf-8",
	     data:JSON.stringify(datas),
		 dataType : "json",
		 success : function(data) {
		
			var list = data;
			var numberY = 0;
			var numberN = 0;
			var numberI = 0;
			if(list.length>0){
				for(var i=0;i<list.length;i++){
					
					if(list[i].attendStatus=="L"){
						numberI = list[i].stautsNumber;
					}else if(list[i].attendStatus=="Y"){
						numberY = list[i].stautsNumber;
					}else if(list[i].attendStatus=="N"){
						numberN = list[i].stautsNumber;
					}
				}
			}
			var count = numberY + numberN + numberI;
			$("#count").val(count)
			$("#numberY").val(numberY)
			$("#numberN").val(numberN)
			$("#numberI").val(numberI)
			
			option.series[0].data[0].value=numberN;
			option.series[0].data[1].value=numberI;
			option.series[0].data[2].value=numberY;
			
			
			myChart.setOption(option);
		
		}

	});
	
});
   

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


function doSearch(){
	var datas = {
			teacherName: $('#teacherName').val(),
			studentName: $('#studentName').val(),
			courseName: $('#courseName').val(),
			courseCode: $('#courseCode').val(),
			startDate: $('#startDate').datebox('getValue'),
			endDate: $('#endDate').datebox('getValue'),
			coursePlaceId:$("#coursePlaceId").val(),
			courseRoomId:$("#courseRoomId").val(),
			courseTimeId:$("#courseTimeId").val()
	};
	
	$.ajax({
         url:'<%=basePath%>/attend/getCountInfo.do',
		 type : 'post',
		 contentType:"application/json;charset=utf-8",
	     data:JSON.stringify(datas),
		 dataType : "json",
		 success : function(data) {
			console.log(data)
			var numberY = 0;
			var numberN = 0;
			var numberI = 0;
			if(data.length>0){
				for(var i=0;i<data.length;i++){
					
					if(data[i].attendStatus=="L"){
						numberI = data[i].stautsNumber;
					}else if(data[i].attendStatus=="Y"){
						numberY = data[i].stautsNumber;
					}else if(data[i].attendStatus=="N"){
						numberN = data[i].stautsNumber;
					}
				}
			}
			console.log(numberY)
			console.log(numberN)
			console.log(numberI)
			var count = numberY + numberN + numberI;
			$("#count").val(count)
			$("#numberY").val(numberY)
			$("#numberN").val(numberN)
			$("#numberI").val(numberI)
			option.series[0].data[0].value=numberN;
			option.series[0].data[1].value=numberI;
			option.series[0].data[2].value=numberY;
			
			myChart.setOption(option); 
			
		}

	});
	
}


</script>


</body>
</html>