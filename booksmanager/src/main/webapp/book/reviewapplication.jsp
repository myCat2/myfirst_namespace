<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>批阅列表</title>
	<link rel="stylesheet" type="text/css" href="../easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="../easyui/css/demo.css">
	<script type="text/javascript" src="../easyui/jquery.min.js"></script>
	<script type="text/javascript" src="../easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../easyui/js/validateExtends.js"></script>
	<script type="text/javascript" src="../easyui/themes/locale/easyui-lang-zh_CN.js"></script>
	
	<script type="text/javascript">
	
	$(function() {	
		//datagrid初始化 
	    $('#dataList').datagrid({ 
	        title:'批阅列表', 
	        iconCls:'icon-more',//图标 
	        border: true, 
	        collapsible:false,//是否可折叠的 
	        fit: true,//自动大小 
	        method: "post",/* ${pageContext.request.contextPath} */
	        url: "${pageContext.request.contextPath}/bookType/Purchaselist.do",
	        idField:'purchaseId', 
	        singleSelect:false,//是否单选 
	        pagination:true,//分页控件 
	        rownumbers:true,//行号 
	        sortName:'purchaseId',
	        sortOrder:'DESC', 
	        remoteSort: false,
	        columns: [[  
				{field:'chk',checkbox: true,width:50},
 		        {field:'purchaseId',title:'申请编号',width:150, sortable: true},    
 		        {field:'purchaseNo',title:'申请流水号',width:150, sortable: true},    
 		        {field:'book',title:'图书名称',width:150, 
 		        	formatter: function(value,row,index){
 						if (row.book){
 							return row.book.bookName;
 						} else {
 							return value;
 						}
 					}
				},
				
 		        {field:'purchaseReason',title:'申请原因',width:150},
 		       {field:'purchaseDate',title:'申请日期',width:150},
 		       {field:'emp',title:'操作员姓名',width:150, 
 		        	formatter: function(value,row,index){
 						if (row.emp){
 							return row.emp.empName;
 						} else {
 							return value;
 						}
 					}
				},
     			{field:'purchaseRemark',title:'审批类型',width:150}
 		     
	 		]], 
	        toolbar: "#toolbar"
	    });  
	    //设置分页控件 
	    var p = $('#dataList').datagrid('getPager'); 
	    $(p).pagination({ 
	        pageSize: 10,//每页显示的记录条数，默认为10 
	        pageList: [10,20,30,50,100],//可以设置每页记录条数的列表 
	        beforePageText: '第',//页数文本框前显示的汉字 
	        afterPageText: '页    共 {pages} 页', 
	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
	    }); 
	    //删除
	    $("#delete").click(function(){
	    	var selectRows = $("#dataList").datagrid("getSelections");
        	var selectLength = selectRows.length;
        	
        	if(selectLength == 0){
            	$.messager.alert("消息提醒", "请选择数据进行删除!", "warning");
            } else{
            	var strIds=[];
    			for(var i=0;i<selectRows.length;i++){
    				strIds.push(selectRows[i].purchaseId);
    			}
    			var ids=strIds.join(",");
            
            	var bookIds=[];
    			for(var i=0;i<selectRows.length;i++){
    				bookIds.push(selectRows[i].bookId);
    			}
    			var bookids=bookIds.join(",");
            
            	$.messager.confirm("消息提醒", "将批阅您选择的所有数据，确认继续？", function(r){
            		if(r){
            			$.ajax({
							type: "post",
							url: "${pageContext.request.contextPath}/bookType/update.do",
							data: {ids:ids,bookids:bookids},
							success: function(msg){
								if(msg.msg == "success"){
									$.messager.alert("消息提醒","批阅成功!","info");
									//刷新表格
									$("#dataList").datagrid("reload");
									$("#dataList").datagrid("uncheckAll");
								} else{
									$.messager.alert("消息提醒","批阅失败,请检查您选择的申请是否已通过!","warning");
									return;
								}
							}
						});
            		}
            	});
            }
	    });
	
	});
	
	
	</script>
</head>
<body>
	<!-- 学生列表 -->
	<table id="dataList" cellspacing="0" cellpadding="0"> 
	    
	</table> 
	<!-- 工具栏 -->
	<div id="toolbar">
		<div style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id="delete" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-some-delete',plain:true">批准申请</a></div>
	</div>
	
</body>
</html>
