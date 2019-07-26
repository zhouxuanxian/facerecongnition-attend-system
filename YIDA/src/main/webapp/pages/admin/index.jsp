<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link rel="stylesheet" type="text/css" href="<%=basePath%>static/js/bootstrap3/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="<%=basePath%>static/js/bootstrap3/css/bootstrap-table.min.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/js/easyui/themes/IconExtension.css">
<script type="text/javascript" src="<%=basePath %>static/js/easyui/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jsonHandler.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/easyui/locale/easyui-lang-zh_CN.js"></script>

<link href="<%=basePath%>static/js/lhgdialog/skins/default.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath%>static/js/lhgdialog/lhgcore.min.js" type="text/javascript"></script>
<script src="<%=basePath%>static/js/lhgdialog/lhgdialog.min.js" type="text/javascript"></script>


<style>
.tree-title{
font-size:18px;

}
.tree-node{
margin-top:8px;
}
.panel-title{
font-size:18px;

}

</style>
</head>

<body class="easyui-layout">   

    <div data-options="region:'north',title:'五邑大学',split:true" style="height:112px;">
     <div style="width:100%;line-height:70px;">
			   
	  <div class="container-fluid">
	  <div class="navbar-header" style="width:100%">
      <ul class="nav navbar-nav navbar-left">
		 <span id="teacherName" style="font-size:18px;"></span>					
										
	  </ul> 
	  
      <ul class="nav navbar-nav navbar-right"> 
	      <li><a href="<%=basePath %>teacher/resetPassword.do"><span class="glyphicon glyphicon-wrench"></span> 修改密码</a></li>
	      <li><a href="<%=basePath %>teacher/login.do"><span class="glyphicon glyphicon-log-out"></span> 退出</a></li> 
	  </ul> 
	  </div>
	  </div>
	
	  
    </div>
    
    
    </div>   
  <!--   <div data-options="region:'south',title:'南',split:true" style="height:100px;"></div>  -->  
    <div data-options="region:'west',title:'人脸识别考勤系统',split:true,iconCls:'icon-world'" style="width:220px;height:150px;">
   <ul id="tt">
    
    </ul>  
   
    </div>   
    <div data-options="region:'center'" style="background:#eee;">
		<div id="tabs" class="easyui-tabs" data-options="fit:true">   
	            <div title="我的桌面" style="padding:20px;font-size:25px;"  data-options="iconCls:'icon-house'">   
                    欢迎使用五邑大学人脸识别考勤后台管理系统
                </div> 
    
		</div>  
		    
    </div>  
    
    <script type="text/javascript">
 $(function(){
	 
	 
	  $.ajax({
          url: '<%=basePath%>teacher/getTeacherName.do',
          type: "POST",
          success: function (data) {
        	  if(data){
        		  $("#teacherName").html("欢迎"+data+"登录");
        	  }else{
        		  $("#teacherName").html("请登录");
        	  }
        	
           
          }
      });
	 
/*     $("a[pageUrl]").click(function(){
    	var pageUrl = $(this).attr("pageUrl");
    	var title = $(this).text();
    	
    	if($("#tt").tabs("exists", title) ){
    		
    		$("#tt").tabs("select",title);
    		
    	}else{
    		
    		$("#tt").tabs("add",{
    			title:title,
    			content:"<iframe src='"+pageUrl+"' width='100%' height='100%' frameborder='0'></iframe>",
    			closable:true
    			
    			
    		});
    		
    	}
    	
    	
    	
    });
     */
	
	$('#tt').tree({   
		animate:true,
		lines:true,
	    url:'<%=basePath %>admin/getAllNavs.do',
	    loadFilter:function(rows){
	    	return convert(rows);//转化数据格式
	    },
	    onDblClick:function(node){
	    	if(node.pid==0){
	    		//node.state="open";
	    		//alert(node.target)
	    		$('#tt').tree('expand', node.target);
	    	}
	    },
	    onClick: function(node){    	
	    	if( $("#tabs").tabs("exists",node.text) ){
	    		
	    		$("#tabs").tabs("select", node.text);
	    		
	    	}else{
	    		//alert(node.url)
	    		var content = '<iframe scrolling="auto" frameborder="0"  src="'+node.url+'" style="width:100%;height:100%;"></iframe>';
	    	    if(node.url!=''){
	    	    	$("#tabs").tabs("add",{
	    	    		id:node.id,
		    			title:node.text,
		    			closable:true,
		    			content:content
		    			<%-- href:"<%=basePath %>/pages/admin/"+node.url --%>
		    			
		    		});	    	    	
	    	    }	    	    		
	    	}    	
		}	    
	}); 
    
}); 
	function convert(rows){
		function exists(rows, pid){
			for(var i=0; i<rows.length; i++){
				if (rows[i].id == pid) return true;
			}
			return false;
		}
		
		var nodes = [];
		// get the top level nodes
		for(var i=0; i<rows.length; i++){
			var row = rows[i];
			if (!exists(rows, row.pid)){
				nodes.push({
					id:row.id,
					text:row.text,
					iconCls:row.iconCls,
					state:row.state,
					pid:row.pid,
					url:row.url
				});
			}
		}
		
		var toDo = [];
		for(var i=0; i<nodes.length; i++){
			toDo.push(nodes[i]);
		}
		while(toDo.length){
			var node = toDo.shift();	// the parent node
			// get the children nodes
			for(var i=0; i<rows.length; i++){
				var row = rows[i];
				if (row.pid == node.id){
					var child = {
							id:row.id,
							text:row.text,
							iconCls:row.iconCls,
							state:row.state,
							pid:row.pid,
							url:row.url
							};
					if (node.children){
						node.children.push(child);
					} else {
						node.children = [child];
					}
					toDo.push(child);
				}
			}
		}
		return nodes;
	}
 
    
    </script> 
</body>  
</html>