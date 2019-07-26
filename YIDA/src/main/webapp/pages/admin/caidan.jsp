<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>菜单管理</title>
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
	<table id="dg"></table>



	<script type="text/javascript">
$('#dg').datagrid({    
    url:'<%=basePath%>/admin/getCaiDan.do',    
    columns:[[ 
    	{checkbox:true},
        {field:'id',title:'id',width:100,align:'center'},    
        {field:'text',title:'菜单名称',width:100,align:'center',formatter: function(value,row,index){
        	if(row.pid==0){
        		return "<span style='color:red'>"+row.text+"</span>";
        	}else{
        		return row.text;
        	}
        }},    
        {field:'state',title:'菜单展开状态',width:100,align:'center',formatter: function(value,row,index){
        	if(row.state=='open'){
        		return '展开';
        	}else{
        		return '关闭';
        	}
        
        }},
        {field:'iconCls',title:'菜单图标',width:200,align:'left'},  
        {field:'pid',title:'父标签id',width:100,align:'center'},
        {field:'url',title:'菜单链接',width:150,align:'center',formatter: function(value,row,index){
        	if(row.url==''){
        		return '无链接';
        	}else{
        		return value;
        	}
        	
        }} 
    ]],
    striped:true,
    pagination:true,
    fit:true,
    singleSelect:true,
    pageSize:20,
/*     onLoadSuccess: function (data) {
    	
  	　　var panel = $("#dg").datagrid('getPanel');
  	　　var tr = panel.find('div.datagrid-body tr');
  	　　tr.each(function () {
  	　　　　var td = $(this).children('td');
  	　　　　td.css({
  	　　　　　　"border-width": "0"
  	　　　　});
  	});
    }, */
    toolbar: [{
		iconCls: 'icon-add',
		text:"添加菜单",
		handler: function(){
			  var url = "caidanAdd.jsp";
		      var title = "添加菜单";
		      dgk = new J.dialog({ 
		    	  id: 'dataAdd', 
		    	  title: title, 
		    	  page: url, 
		    	  rang: true, 
		    	  cover: true,
		    	  iconTitle: false,
                  btnBar: true,
                  width: 600,
                  height:400, 
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
		text:"编辑菜单",
		handler: function(){
			var selRows = $('#dg').datagrid('getSelections');
			if(selRows.length==0){
				$.messager.alert('提示','请先选中一行');    
				
				return;
			}else if(selRows.length>=2){
				
				$.messager.alert('提示','只能选中一行编辑');    
				return;
			}	
			
			var url = "<%=basePath%>/admin/editCaiDan.do?id="+selRows[0].id;
			      var title = "编辑菜单";
			      dgk = new J.dialog({ 
			    	  id: 'dataAdd', 
			    	  title: title, 
			    	  page: url, 
			    	  rang: true, 
			    	  cover: true,
			    	  iconTitle: false,
	                  btnBar: true,
	                  width: 600,
	                  height:400, 
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
						ids=selRows[i].id;
					}else{
						ids=ids+","+selRows[i].id;
					}
				}
				$.ajax({
					url:'<%=basePath%>/admin/deleteCaiDan.do',
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
	},'-',
	{
		iconCls: 'icon-remove',
		text:"导出到Excel",
		handler: function(){
			
		window.location.href="<%=basePath%>/admin/doExcelByCaiDan.do";
				
						

		}
	}
	],
	onDblClickRow: function(rowIndex,rowData){
	
		var url = "<%=basePath%>/admin/editCaiDan.do?id="+rowData.id;
	      var title = "编辑菜单";
	      dgk = new J.dialog({ 
	    	  id: 'dataAdd', 
	    	  title: title, 
	    	  page: url, 
	    	  rang: true, 
	    	  cover: true,
	    	  iconTitle: false,
            btnBar: true,
            width: 600,
            height:400, 
            maxBtn: false, 
            drag: false,
            resize:false,
            esc:true
            });
		  dgk.ShowDialog();
		
	}

});

	</script>
</body>
</html>