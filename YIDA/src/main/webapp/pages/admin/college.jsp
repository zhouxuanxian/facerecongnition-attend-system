<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>学院管理</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/js/easyui/themes/IconExtension.css">
<script type="text/javascript" src="<%=basePath%>/static/js/easyui/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/jsonHandler.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/easyui/locale/easyui-lang-zh_CN.js"></script>
	
<link href="<%=basePath%>/static/js/lhgdialog/skins/default.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath%>/static/js/lhgdialog/lhgcore.min.js" type="text/javascript"></script>
<script src="<%=basePath%>/static/js/lhgdialog/lhgdialog.min.js" type="text/javascript"></script>
<style>
.datagrid-cell, .datagrid-cell-group, .datagrid-header-rownumber, .datagrid-cell-rownumber{
	font-size:15px;
	font-family:"微软雅黑"
}
.datagrid-header .datagrid-cell span {
    font-size: 16px;
}
.panel-body {
   font-size:15px;
}
.l-btn-text {
   font-size:15px;
}
</style>
</head>
<body>
	<table id="dg">
	
	</table>
	<script type="text/javascript">
$('#dg').datagrid({    
    url:'<%=basePath%>/college/selectCollege.do',    
    columns:[[ 
    	{checkbox:true},
        {field:'college_id',title:'id',width:100,align:'center'},    
        {field:'college_name',title:'学院',width:200,align:'center'}
    ]],
    pagination:true,
    fit:true,
    pageSize:20,
    striped:true,
   // singleSelect:true,
    toolbar: [{
		iconCls: 'icon-add',
		text:"添加学院",
		handler: function(){
			  var url = "collegeAdd.jsp";
		      var title = "添加学院";
		      dgk = new J.dialog({ 
		    	  id: 'dataAdd', 
		    	  title: title, 
		    	  page: url, 
		    	  rang: true, 
		    	  cover: true,
		    	  iconTitle: false,
                  btnBar: true,
                  width: 400,
                  height:200, 
                  maxBtn: false, 
                  drag: false,
                  resize:false,
                  esc:true
                  });
			  dgk.ShowDialog();

		}
	},'-',
  
	{
		iconCls: 'icon-edit',
		text:"编辑学院",
		handler: function(){
			var selRows = $('#dg').datagrid('getSelections');
			if(selRows.length==0){
				$.messager.alert('提示','请先选中一行');    
				
				return;
			}else if(selRows.length>=2){
				
				$.messager.alert('提示','只能选中一行编辑');    
				return;
			}	
			
			var url = "<%=basePath%>/college/editCollege.do?college_id="+selRows[0].college_id;
			      var title = "编辑学院";
			      dgk = new J.dialog({ 
			    	  id: 'dataAdd', 
			    	  title: title, 
			    	  page: url, 
			    	  rang: true, 
			    	  cover: true,
			    	  iconTitle: false,
	                  btnBar: true,
	                  width: 400,
	                  height:200, 
	                  maxBtn: false, 
	                  drag: false,
	                  resize:false,
	                  esc:true
	                  });
				  dgk.ShowDialog();
			
		}
	},'-',
	{
		iconCls: 'icon-remove',
		text:"批量删除",
		handler: function(){
			
			var selRows = $('#dg').datagrid('getSelections');
			if(selRows.length==0){
			
				$.messager.alert('提示','请先选中一行');    
				return;
			}else{
				var ids = "";
				for(var i=0;i<selRows.length;i++){
					if(ids==""){
						ids=selRows[i].college_id;
					}else{
						ids=ids+","+selRows[i].college_id;
					}
				}
				$.ajax({
					url:'<%=basePath%>/college/deleteCollege.do',
							type : 'post',
							data : {
								ids:ids
							},
							
							success : function(data) {
								if(data>0){
									alert("删除成功！");
									$.messager.show({
										title : '删除提示',
										iconCls : 'icon-ok',
										msg : '成功删除记录。',
										timeout : 3000,
										showType : 'slide'
									});

									$("#dg").datagrid('reload');
								}
								
							}

						});
				
			}
			
		}
	}
	],
	onDblClickRow: function(rowIndex,rowData){
	
		var url = "<%=basePath%>/college/editCollege.do?college_id="+rowData.college_id;
	      var title = "编辑学院";
	      dgk = new J.dialog({ 
	    	  id: 'dataAdd', 
	    	  title: title, 
	    	  page: url, 
	    	  rang: true, 
	    	  cover: true,
	    	  iconTitle: false,
            btnBar: true,
            width: 400,
            height:200, 
            maxBtn: false, 
            drag: false,
            resize:false,
            esc:true
            });
		  dgk.ShowDialog();
		
	},/* onLoadSuccess: function (data) {
    	
	  	　　var panel = $("#dg").datagrid('getPanel');
	  	　　var tr = panel.find('div.datagrid-body tr');
	  	　　tr.each(function () {
	  	　　　　var td = $(this).children('td');
	  	　　　　td.css({
	  	　　　　　　"border-width": "0"
	  	　　　　});
	  	});
	    }, */

});

	</script>
</body>
</html>