<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
	<meta charset="UTF-8">
	<title>借阅管理</title>
	<link rel="stylesheet" type="text/css" href="<%=path %>/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path %>/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=path %>/easyui/css/demo.css">
	<script type="text/javascript" src="<%=path %>/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="<%=path %>/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=path %>/easyui/js/validateExtends.js"></script>
 	<!-- <style>
 		.pagination{
 			position:relative;
 			bottom:31px;
 		}
 	</style> -->
 	<script type="text/javascript">
  		
  		$(function(){
  			//datagrid初始化 
  		    $('#dataList').datagrid({ 
  		        title:'借阅管理', 
  		        iconCls:'icon-more',//图标 
  		        border: true, 
  		        collapsible: true,//是否可折叠的 
  		        fit: true,//自动大小 
  		        method: "post",
  		        url:"<%=path%>/borrow/queryBorrowList.do",
  		        idField:'borrowId', 
  		        singleSelect: false,//是否单选 
  		        pagination: true,//分页控件 
  		      	pageSize: 10,//每页显示的记录条数，默认为10 
  	        	pageList: [10,20,30],//可以设置每页记录条数的列表 
  		        rownumbers: true,//行号 
  		        /* sortName: 'id',
  		        sortOrder: 'asc',  */
  		        remoteSort: false,
  		        columns: [[  
  					{field:'chk',checkbox: true,width:200},
  					{field:'readerId',title:'读者编号',width:200, sortable: true},
  	 		        {field:'readerName',title:'读者姓名',width:200, sortable: true},    
  	 		        {field:'bookName',title:'书籍名称',width:200},
  	 		        {field:'bookTypeName',title:'书籍类型',width:200},
  	 		     	{field:'borrowDate',title:'借阅日期',width:200},
  	 		  		{field:'returnBook',title:'是否归还',width:125,formatter:aaa}
  		 		]], 
  		        toolbar: "#toolbar",
  		        onLoadSuccess:function(){
  		        	$('.btnReturn').linkbutton({plain:true,iconCls:'icon-redo'});
  		        	$('#dataList').datagrid('fixRowHeight');
  		        }
  		    }); 
  			//格式化还书栏
  		    function aaa(val, rowdata, rowIndex)
  	        {
  	            return "<a class='btnReturn' href='javascript:;' id='returnBook'>归还</a>";//此处传参时要严格注意单引号和双引号的使用
  	        }
  			
  			//打开借阅窗口
  		    $("#returnBook").live("click",function(){
				var selectRow=$("#dataList").datagrid("getSelected");
  		    	$.messager.confirm("消息提醒", "将归还选中的图书，确认继续？", function(r1){
            		if(r1){
            			$.messager.confirm("消息提醒", "图书是否损坏/丢失？", function(r2){
            				//损坏
                    		if(r2){
                    			var borrow={
                    				borrowId:selectRow.borrowId,
                    				bookId:selectRow.bookId,
                   					backDate:new Date(),
                   					borrowIsdamaged:1
                    			};
                    			$.ajax({
        							type: 'post',
        							url: '<%=path%>/borrow/insertReturn.do',
        							data: JSON.stringify(borrow),
        							dataType:'json',
        							contentType:'application/json',
        							success: function(data){
        								if(data.flag=="success"){
        									//清空选择，这里一定要清空选择，因为在此请求时，easyui可能会搞不清楚选择哪条（自认为，不清楚原理）
        									$('#dataList').datagrid('clearSelections');
        									$("#r_borrowDate").text(data.dataMap.r_borrowDate);
        									$("#r_returnDate").text(data.dataMap.r_returnDate);
        									$("#r_allowDays").text(data.dataMap.r_allowDays);
        									$("#r_exceedDays").text(data.dataMap.r_exceedDays);
        									$("#r_damagedBook").text(data.dataMap.r_damagedBook);
        									$("#r_punishMoney").text(data.dataMap.r_punishMoney);
        									$("#returnBooksDialog").dialog('open');
        								}else if(data.flag=="fail"){
        									$.messager.alert("消息提醒","还书失败，请重新尝试","warning");
        									return;
        								}else{
        									$.messager.alert("消息提醒","未知错误，请重新尝试","warning");
        									return;
        								}
        							}
        						});
                    		}else{//没有损坏
                    			//alert("没损坏");
                    			var borrow={
                    				borrowId:selectRow.borrowId,
                    				bookId:selectRow.bookId,
                   					backDate:new Date(),
                   					borrowIsdamaged:0
                    			};
                    			$.ajax({
                    				type:"post",
                    				url:"<%=path%>/borrow/insertReturn.do",
                    				data:JSON.stringify(borrow),
                    				dataType:'json',
                    				contentType:'application/json',
                    				success:function(data){
                    					if(data.flag=="success"){
                    						//清空选择，这里一定要清空选择，因为在此请求时，easyui可能会搞不清楚选择哪条（自认为，不清楚原理）
            								$('#dataList').datagrid('clearSelections');
                    						$("#r_borrowDate").text(data.dataMap.r_borrowDate);
        									$("#r_returnDate").text(data.dataMap.r_returnDate);
        									$("#r_allowDays").text(data.dataMap.r_allowDays);
        									$("#r_exceedDays").text(data.dataMap.r_exceedDays);
        									$("#r_damagedBook").text(data.dataMap.r_damagedBook);
        									$("#r_punishMoney").text(data.dataMap.r_punishMoney);
        									$.messager.alert("消息提醒","归还成功","warning");
        									$("#returnBooksDialog").dialog('open');
        								}else if(data.flag=="fail"){
        									$.messager.alert("消息提醒","还书失败，请重新尝试","warning");
        									return;
        								}else{
        									$.messager.alert("消息提醒","未知错误，请重新尝试","warning");
        									return;
        								}
                    				}
                    			});
                    		}
                    		
        	            });
            			
            		}
	            });
  		    	
  		    });
  			//图书归还窗体
  		    $("#returnBooksDialog").dialog({
  		    	title: "图书归还",
  		    	width: 400,
  		    	height: 500,
  		    	iconCls: "icon-play",
  		    	modal: true,
  		    	collapsible: false,
  		    	minimizable: false,
  		    	maximizable: false,
  		    	draggable: true,
  		    	closed: true,
  		    	buttons: [
  	  		    		{
  	  						text:'确认',
  	  						plain: true,
  	  						iconCls:'icon-redo',
  	  						handler:function(){
  	  							//关闭窗口
								$("#returnBooksDialog").dialog("close");
								
  	  							//刷新数据
								$('#dataList').datagrid("reload","<%=path%>/borrow/queryBorrowList.do");
  	  						}
  	  					}]
  	  			
  		    });
  			
  			//设置分页控件 
  			var p = $('#dataList').datagrid('getPager');
  			$(p).pagination({
  				pageSize: 10,//每页显示的记录条数，默认为10 
  	        	pageList: [10,20,30],//可以设置每页记录条数的列表 
  				beforePageText : '第',//页数文本框前显示的汉字 
  				afterPageText : '页    共 {pages} 页',
  				displayMsg : '当前显示 {from} - {to} 条记录   共 {total} 条记录',
  			});
  			
  			//模糊查询
  		    $("#search").on("click",function(){
  		    	var key=$("#key").val();
  		    	$("#key").val("");
  		    	$.ajax({
					type: "post",
					url: "<%=path%>/borrow/queryBorrowList.do",
					data: {"key":key},
					success: function(data){
						if(data != null){
				  			//datagrid初始化 
 				  			$('#dataList').datagrid("loadData",data);
 						} else{
							$.messager.alert("消息提醒","查询失败","warning");
							return;
						}
					}
				});
  		    });
  			
  			//删除按钮点击事件
  			$("#delete").click(function(){
  				var selectRows=$("#dataList").datagrid("getSelections");
  				if(selectRows.length==0){
  		    		$.messager.alert("消息提醒", "请选择要删除的借阅记录!", "warning");
  				}else{
  					var ids=new Array(selectRows.length);
  					for(var i=0;i<selectRows.length;i++){
  						ids[i]=selectRows[i].borrowId;
  					}
  					$.messager.confirm("消息提醒", "将删除选中的借阅记录，确认继续？", function(r){
  	            		if(r){
  	            			$.ajax({
  								type: "post",
  								url: "<%=path%>/borrow/deleteBorrowList.do",
  								data: {"ids":ids},
  								traditional: true,//这里设置为true
  								success: function(map){
  									if(map.flag == ids.length){
  										$.messager.alert("消息提醒","删除成功!","info");
  										
  							  			//datagrid初始化 
  							  			$('#dataList').datagrid("reload","<%=path%>/borrow/queryBorrowList.do");
  									} else{
  										$.messager.alert("消息提醒","删除失败！","warning");
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
	<!-- 数据列表 -->
	<table id="dataList" cellspacing="0" cellpadding="0"> 
	</table> 
	
	<!-- 工具栏 -->
	<div id="toolbar">
		<div style="float: left; margin-right: 10px;"><a id="delete" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-some-delete',plain:true">批量删除</a></div>
		<div style="float: left;" class="datagrid-btn-separator"></div>
	    <div style="float: left;">
	    <input style="height: 25px ;width: 180px;" class="easyui-textbox" data-options="prompt:'请输入书名/读者姓名'" id="key" name="key"/>
	    <a id="search" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">查询</a></div>
	</div>
	
	<!-- 归还确认窗口 -->
	<div id="returnBooksDialog" style="padding: 10px">
	    	<table cellpadding="8">
	    		<tr>
	    			<td>借阅日期:</td>
	    			<td><label id="r_borrowDate"></label></td>
	    		</tr>
	    		<tr>
	    			<td>归还日期:</td>
	    			<td><label id="r_returnDate"></label></td>
	    		</tr>
	    		<tr>
	    			<td>可借天数:</td>
	    			<td><label id="r_allowDays"></label></td>
	    		</tr>
	    		<tr>
	    			<td>超出天数:</td>
	    			<td><label id="r_exceedDays"></label></td>
	    		</tr>
	    		<tr>
	    			<td>损坏/丢失书籍数量:</td>
	    			<td><label id="r_damagedBook"></label></td>
	    		</tr>
	    		<tr>
	    			<td>罚款:</td>
	    			<td><label id="r_punishMoney"></label></td>
	    		</tr>
	    	</table>
	</div>
</body>

</html>