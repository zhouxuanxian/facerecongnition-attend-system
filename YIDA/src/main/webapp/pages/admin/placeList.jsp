<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>地点管理</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>static/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>static/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>static/js/easyui/themes/IconExtension.css">
<script type="text/javascript" src="<%=basePath%>static/js/easyui/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>static/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>static/js/jsonHandler.js"></script>

<link href="<%=basePath%>static/js/lhgdialog/skins/default.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath%>static/js/lhgdialog/lhgcore.min.js" type="text/javascript"></script>
<script src="<%=basePath%>static/js/lhgdialog/lhgdialog.min.js" type="text/javascript"></script>
</head>
<body>
	<table id="dg"></table>



	<script type="text/javascript">
$('#dg').datagrid({    
    url:'<%=basePath%>admin/getPlace.do',    
    columns:[[ 
    	{checkbox:true},
        {field:'id',title:'id',width:100,align:'center'},    
        {field:'place',title:'地点',width:100,align:'center'},    
       
    ]],
    pagination:true,
    fit:true,
    pageSize:20,
    //striped:true,
   // singleSelect:true,
    toolbar: [{
		iconCls: 'icon-add',
		text:"添加地点",
		handler: function(){
			  var url = "placeAdd.jsp";
		      var title = "添加地点";
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
		text:"编辑地点",
		handler: function(){
		    var selRows = $('#dg').datagrid('getSelections');
			if(selRows.length==0){
				$.messager.alert('提示','请先选中一行');    
				return;
			}else if(selRows.length>=2){
				
				$.messager.alert('提示','只能选中一行编辑');    
				return;
			}	 
			//alert()
			 var url = "<%=basePath%>admin/editPlace.do?id="+selRows[0].id+"&place="+selRows[0].place;
		      var title = "编辑地点";
		      dgk = new J.dialog({ 
		    	  id: 'dataEdit', 
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

		}
	}
	
	
	],
	onDblClickRow: function(rowIndex,rowData){
		
		alert(rowData);
		 var url = "<%=basePath%>admin/editPlace.do?id="+rowData.id+"&place="+rowData.place;
	      var title = "编辑地点";
	      dgk = new J.dialog({ 
	    	  id: 'dataEdit', 
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

});



		

	</script>
	
</body>
</html>