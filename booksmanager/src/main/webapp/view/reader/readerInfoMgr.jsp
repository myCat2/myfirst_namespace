<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
	<meta charset="UTF-8">
	<title>读者信息管理</title>
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
  		        title:'读者信息管理', 
  		        iconCls:'icon-more',//图标 
  		        border: true, 
  		        collapsible: true,//是否可折叠的 
  		        fit: true,//自动大小 
  		        method: "post",
  		        url:"<%=path%>/reader/queryReaderList.do",
  		        idField:'readerId', 
  		        singleSelect: false,//是否单选 
  		        pagination: true,//分页控件 
  		      	pageSize: 10,//每页显示的记录条数，默认为10 
  	        	pageList: [10,20,30],//可以设置每页记录条数的列表 
  		        rownumbers: true,//行号 
  		        /* sortName: 'id',
  		        sortOrder: 'asc',  */
  		        remoteSort: false,
  		        columns: [[  
  					{field:'chk',checkbox: true,width:100},
  					{field:'readerId',title:'读者编号',width:100, sortable: true},
  	 		        {field:'readerName',title:'姓名',width:100, sortable: true},    
  	 		        {field:'readerSex',title:'性别',width:100},
  	 		        {field:'readerDate',title:'注册日期',width:200},
  	 		     	{field:'readerIdentity',title:'社会身份',width:100},
  	 		  		{field:'readerTel',title:'电话',width:120},
  	 		  		{field:'readerAddress',title:'地址',width:400}
  		 		]], 
  		        toolbar: "#toolbar"
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
					url: "<%=path%>/reader/queryReaderList.do",
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
  			
	  		
  			//打开修改学生窗体
  		    $("#edit").click(function(){
  		    	var selectRow=$("#dataList").datagrid("getSelections");
  		    	if(selectRow.length==0){
  		    		$.messager.alert("消息提醒", "请选择要修改的读者!", "warning");
  		    		return;
  		    	}else if(selectRow.length>1){
  		    		$.messager.alert("消息提醒", "一次只能修改一个读者，请重新选择!", "warning");
  		    		return;
  		    	}else{
  		    		$("#editDialog").dialog("open");
  		    	}
  		    });
  		  	//修改学生信息窗体
  		    $("#editDialog").dialog({
  		    	title: "学生信息",
  		    	width: 600,
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
  	  						text:'修改读者',
  	  						plain: true,
  	  						iconCls:'icon-edit',
  	  						handler:function(){
  	  							var validate = $("#editForm").form("validate");
	  	  						var selectRow=$("#dataList").datagrid("getSelected");
	  	  						
	  	  						var reader={
  	  								readerId:selectRow.readerId,
  	  								readerName:$("#edit_readerName").val(),
  	  								readerSex:$("#edit_readerSex").combobox('getValue')==0?"男":$("#edit_readerSex").combobox('getValue'),
  	    	  						readerIdentity:$("#edit_readerIdentity").combobox('getValue')==0?"公民":$("#edit_readerIdentity").combobox('getValue'),
  	  								readerTel:$("#edit_readerPhone").val(),
  	  								readerAddress:$("#edit_readerAddress").val()
	  	  						};
	  	  						
  	  							if(!validate){
  	  								$.messager.alert("消息提醒","请检查你输入的数据!","warning");
  	  								return;
  	  							} else{
  	  								$.ajax({
  	  									type: "post",
	  	  								url: "<%=path%>/reader/updateReader.do",
	  									data: JSON.stringify(reader),
	  									dataType:"json",
	  									contentType:"application/json",
  	  									success: function(data){
  	  										if(data.flag == "1"){
  	  											$.messager.alert("消息提醒","修改成功!","info");
  	  											//清空选择
  	  											$('#dataList').datagrid('clearSelections');
  	  											//关闭窗口
  	  											$("#editDialog").dialog("close");
  	  											//清空原表格数据
					  	  						$("#edit_readerName").textbox('setValue',"");
												$("#edit_readerSex").combobox('setValue',0);
												$("#edit_readerIdentity").combobox('setValue',0);
												$("#edit_readerPhone").textbox('setValue', "");
												$("#edit_readerAddress").textbox('setValue', "");
  	  								  			//datagrid初始化 
  	  								  			$('#dataList').datagrid("reload","<%=path%>/reader/queryReaderList.do");
  	  										} else{
  	  											$.messager.alert("消息提醒","修改失败","warning");
  	  											return;
  	  										}
  	  									}
  	  								});
  	  							}
  	  						}
  	  					},
  	  					{
  	  						text:'重置',
  	  						plain: true,
  	  						iconCls:'icon-reload',
  	  						handler:function(){
	  	  						var selectRow=$("#dataList").datagrid("getSelected");
	  	  						$("#edit_readerName").textbox('setValue',selectRow.readerName);
								$("#edit_readerSex").combobox('setValue',selectRow.readerSex);
								$("#edit_readerIdentity").combobox('setValue',selectRow.readerIdentity);
								$("#edit_readerPhone").textbox('setValue', selectRow.readerTel);
								$("#edit_readerAddress").textbox('setValue', selectRow.readerAddress);
  	  						}
  	  					}],
		  		    	onBeforeOpen:function(){
  	  						var selectRow=$("#dataList").datagrid("getSelected");
  	  						$("#edit_readerName").textbox('setValue',selectRow.readerName);
							$("#edit_readerSex").combobox('setValue',selectRow.readerSex);
							$("#edit_readerIdentity").combobox('setValue',selectRow.readerIdentity);
							$("#edit_readerPhone").textbox('setValue', selectRow.readerTel);
							$("#edit_readerAddress").textbox('setValue', selectRow.readerAddress);
		  		    	}
  		    });
  			
  			//添加按钮
  		    $("#add").click(function(){
  		    	$("#addDialog").dialog("open");
  		    });
  			//设置添加学生窗口
  		    $("#addDialog").dialog({
  		    	title: "添加读者",
  		    	width: 400,
  		    	height: 450,
  		    	iconCls: "icon-add",
  		    	modal: true,
  		    	collapsible: false,
  		    	minimizable: false,
  		    	maximizable: false,
  		    	draggable: true,
  		    	closed: true,
  		    	buttons: [
  		    		{
  						text:'添加',
  						plain: true,
  						iconCls:'icon-add',
  						handler:function(){
  							var reader=
  							{
  								readerName:$("#add_readerName").val(),
  	  							readerSex:$("#add_readerSex").combobox('getValue')==0?"男":$("#add_readerSex").combobox('getValue'),
  	  							readerIdentity:$("#add_readerIdentity").combobox('getValue')==0?"公民":$("#add_readerIdentity").combobox('getValue'),
  	  							readerTel:$("#add_readerPhone").val(),
  	  							readerAddress:$("#add_readerAddress").val()
  							};
	  						var validate = $("#addForm").form("validate");
  							if(!validate){
  								$.messager.alert("消息提醒","请检查你输入的数据!","warning");
  								return;
  							} else{
  								$.ajax({
  									type: "post",
  									url: "<%=path%>/reader/insertReader.do",
  									data: JSON.stringify(reader),
  									dataType:"json",
  									contentType:"application/json",
  									success: function(data){
  										if(data.flag == "1"){
  											$.messager.alert("消息提醒","添加成功","warning");
  											//清空表格
  											$("#add_readerName").textbox('setValue', "");
  				  							$("#add_readerSex").combobox('setValue',0);
  				  							$("#add_readerIdentity").combobox('setValue',0);
  				  							$("#add_readerPhone").textbox('setValue', "");
  				  							$("#add_readerAddress").textbox('setValue', "");
  								  			//datagrid初始化 
  								  			$('#dataList').datagrid("reload","<%=path%>/reader/queryReaderList.do");
  										} else{
  											$.messager.alert("消息提醒","添加失败","warning");
  											return;
  										}
  									}
  								});
  							}
  						}
  					},
  					{
  						text:'重置',
  						plain: true,
  						iconCls:'icon-reload',
  						handler:function(){
  							$("#add_readerName").textbox('setValue', "");
  							$("#add_readerSex").combobox('setValue',0);
  							$("#add_readerIdentity").combobox('setValue',0);
  							$("#add_readerPhone").textbox('setValue', "");
  							$("#add_readerAddress").textbox('setValue', "");
  						}
  					}
  				]
  		    });
  			
  			//删除按钮点击事件
  			$("#delete").click(function(){
  				var selectRows=$("#dataList").datagrid("getSelections");
  				if(selectRows.length==0){
  		    		$.messager.alert("消息提醒", "请选择要删除的读者!", "warning");
  				}else{
  					var ids=new Array(selectRows.length);
  					for(var i=0;i<selectRows.length;i++){
  						ids[i]=selectRows[i].readerId;
  					}
  					$.messager.confirm("消息提醒", "将删除与学生相关的所有数据(包括成绩和用户)，确认继续？", function(r){
  	            		if(r){
  	            			$.ajax({
  								type: "post",
  								url: "<%=path%>/reader/deleteReaderList.do",
  								data: {"ids":ids},
  								traditional: true,//这里设置为true
  								success: function(map){
  									if(map.flag == ids.length){
  										$.messager.alert("消息提醒","删除成功!","info");
  										
  							  			//datagrid初始化 
  							  			$('#dataList').datagrid("reload","<%=path%>/reader/queryReaderList.do");
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
  			//打开图书归还窗体
  		    $("#returnBooks").click(function(){
  		    	var selectRow=$("#dataList").datagrid("getSelections");
  		    	if(selectRow.length==0){
  		    		$.messager.alert("消息提醒", "请选择要归还图书的读者!", "warning");
  		    		return;
  		    	}else if(selectRow.length>1){
  		    		$.messager.alert("消息提醒", "一次只能对一个读者进行归还图书操作，请重新选择!", "warning");
  		    		return;
  		    	}else{
  		    		$("#returnBooksDialog").dialog("open");
  		    	}
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
  	  						text:'归还图书',
  	  						plain: true,
  	  						iconCls:'icon-redo',
  	  						handler:function(){
  	  							var validate = $("#editForm").form("validate");
	  	  						var selectRow=$("#dataList").datagrid("getSelected");
	  	  						
	  	  						var reader={
  	  								readerId:selectRow.readerId,
  	  								readerName:$("#edit_readerName").val(),
  	  								readerSex:$("#edit_readerSex").combobox('getValue')==0?"男":$("#edit_readerSex").combobox('getValue'),
  	    	  						readerIdentity:$("#edit_readerIdentity").combobox('getValue')==0?"公民":$("#edit_readerIdentity").combobox('getValue'),
  	  								readerTel:$("#edit_readerPhone").val(),
  	  								readerAddress:$("#edit_readerAddress").val()
	  	  						};
	  	  						
  	  							if(!validate){
  	  								$.messager.alert("消息提醒","请检查你输入的数据!","warning");
  	  								return;
  	  							} else{
  	  								$.ajax({
  	  									type: "post",
	  	  								url: "<%=path%>/reader/updateReader.do",
	  									data: JSON.stringify(reader),
	  									dataType:"json",
	  									contentType:"application/json",
  	  									success: function(data){
  	  										if(data.flag == "1"){
  	  											$.messager.alert("消息提醒","修改成功!","info");
  	  											//清空选择
  	  											$('#dataList').datagrid('clearSelections');
  	  											//关闭窗口
  	  											$("#editDialog").dialog("close");
  	  											//清空原表格数据
					  	  						$("#edit_readerName").textbox('setValue',"");
												$("#edit_readerSex").combobox('setValue',0);
												$("#edit_readerIdentity").combobox('setValue',0);
												$("#edit_readerPhone").textbox('setValue', "");
												$("#edit_readerAddress").textbox('setValue', "");
  	  								  			//datagrid初始化 
  	  								  			$('#dataList').datagrid("reload","<%=path%>/reader/queryReaderList.do");
  	  										} else{
  	  											$.messager.alert("消息提醒","修改失败","warning");
  	  											return;
  	  										}
  	  									}
  	  								});
  	  							}
  	  						}
  	  					},
  	  					{
  	  						text:'重置',
  	  						plain: true,
  	  						iconCls:'icon-reload',
  	  						handler:function(){
	  	  						var selectRow=$("#dataList").datagrid("getSelected");
	  	  						$("#edit_readerName").textbox('setValue',selectRow.readerName);
								$("#edit_readerSex").combobox('setValue',selectRow.readerSex);
								$("#edit_readerIdentity").combobox('setValue',selectRow.readerIdentity);
								$("#edit_readerPhone").textbox('setValue', selectRow.readerTel);
								$("#edit_readerAddress").textbox('setValue', selectRow.readerAddress);
  	  						}
  	  					}],
		  		    	onBeforeOpen:function(){
  	  						var selectRow=$("#dataList").datagrid("getSelected");
		  		    		$('#readerId').textbox('setValue',selectRow.readerId);
		  		    		$('#booksList').datagrid({ 
		  		  		        title:'借阅图书列表', 
		  		  		        iconCls:'icon-more',//图标 
		  		  		        border: true, 
		  		  		        collapsible: true,//是否可折叠的 
		  		  		        fit: false,//自动大小 
		  		  		        method: "post",
		  		  		        url:"<%=path%>/reader/queryReaderList.do",
		  		  		        idField:'readerId', 
		  		  		        singleSelect: false,//是否单选 
		  		  		        rownumbers: true,//行号 
		  		  		        remoteSort: false,
		  		  		        columns: [[  
		  		  					{field:'chk',checkbox: true,width:100},
		  		  	 		        {field:'readerName',title:'姓名',width:100, sortable: true}
		  		  		 		]]
		  		  		    });
		  		    	}
  		    });
  			//查看历史借阅
  		    $("#historicalBorrow").click(function(){
  		    	var selectRow=$("#dataList").datagrid("getSelections");
  		    	if(selectRow.length==0){
  		    		$.messager.alert("消息提醒", "请选择要查看历史借阅的读者!", "warning");
  		    		return;
  		    	}else if(selectRow.length>1){
  		    		$.messager.alert("消息提醒", "一次只能对一个读者进行查看历史借阅操作，请重新选择!", "warning");
  		    		$('#dataList').datagrid('clearSelections');
  		    		return;
  		    	}else{
  		    		$("#historicalBorrowDialog").dialog("open");
  		    	}
  		    });
  				
  			//历史借阅窗体
  		    $("#historicalBorrowDialog").dialog({
  		    	title: "历史借阅",
  		    	width: 600,
  		    	height: 500,
  		    	iconCls: "icon-play",
  		    	modal: true,
  		    	collapsible: false,
  		    	minimizable: false,
  		    	maximizable: false,
  		    	draggable: true,
  		    	closed: true,
  		    	buttons: [{
  	  						text:'关闭',
  	  						plain: true,
  	  						iconCls:'icon-ok',
  	  						handler:function(){
  	  							$("#historicalBorrowDialog").dialog('close');
  	  						}
  	  					}],
  		    	onBeforeOpen:function(){
  		    		//borrowList初始化 
		  		    $('#borrowList').datagrid({ 
		  		        iconCls:'icon-more',//图标 
		  		        border: true, 
		  		        collapsible: false,//是否可折叠的 
		  		        fit: true,//自动大小 
		  		        singleSelect: false,//是否单选 
		  		        rownumbers: true,//行号 
		  		        remoteSort: false,
		  		        columns: [[  
		  	 		        {field:'bookName',title:'书名',width:100, sortable: true},    
		  	 		        {field:'borrowTime',title:'借阅时间',width:180},
		  	 		        {field:'returnTime',title:'归还时间',width:180},
		  	 		     	{field:'borrowPrice',title:'借阅价格',width:78}
		  		 		]]
		  		    });
  		    		var selectRow=$("#dataList").datagrid("getSelected");
  		    		$.ajax({
						type: 'post',
						url: '<%=path%>/borrow/queryHistoricalBorrow.do',
						data: {readerId:selectRow.readerId},
						dataType:'json',
						success: function(data){
							if(data.flag=="NoData"){
								//清空选择，这里一定要清空选择，因为在此请求时，easyui可能会搞不清楚选择哪条（自认为，不清楚原理）
								$('#dataList').datagrid('clearSelections');
								$("#historicalBorrowDialog").dialog('open');
								$('#borrowList').innerHtml("暂无借阅记录,要记得多读书哦~");
							}else{
								$('#dataList').datagrid('clearSelections');
								$('#borrowList').datagrid("loadData",data);
								//$("#historicalBorrowDialog").dialog('open');
								
							}
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
		<div style="float: left;"><a id="add" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a></div>
		<div style="float: left;" class="datagrid-btn-separator"></div>
		<div style="float: left; margin-right: 10px;"><a id="edit" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a></div>
		<div style="float: left;" class="datagrid-btn-separator"></div>
		<div style="float: left; margin-right: 10px;"><a id="delete" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-some-delete',plain:true">删除</a></div>
		<div style="float: left;" class="datagrid-btn-separator"></div>
	    <div style="float: left;">
	    <input id="key" name="key" style="height: 25px ;width: 180px;" class="easyui-textbox" data-options="prompt:'请输入读者编号/读者姓名'"/>
	    <a id="search" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">查询</a></div>
	    <div style="float: left;" class="datagrid-btn-separator"></div>
	    <a id="historicalBorrow" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">历史借阅</a></div>
	</div>
	
	<!-- 添加窗口 -->
	<div id="addDialog" style="padding: 10px">  
    	<form id="addForm" >
	    	<table cellpadding="8" >
	    		<tr>
	    			<td>姓名:</td>
	    			<td><input id="add_readerName" style="width: 200px; height: 30px;" class="easyui-textbox"  name="add_readerName"   data-options="required:true, missingMessage:'不能为空 ' "   /></td>
	    		</tr>
	    		<tr>
	    			<td>性别:</td>
	    			<td><select id="add_readerSex" class="easyui-combobox" name="add_readerSex" style="width: 200px; height: 30px;" data-options="editable:false,required:true, missingMessage:'不能为空 ' ">   
						    <option value="0">--请选择性别--</option>
						    <option value="男">男</option>   
						    <option value="女">女</option>   
						</select></td>
	    		</tr>
	    		<tr>
	    			<td>社会身份:</td>
	    			<td><select id="add_readerIdentity" class="easyui-combobox" name="add_readerIdentity" style="width: 200px; height: 30px;" data-options="editable:false">   
						    <option value="0">--请选择社会身份--</option>
						    <option value="学生">群众</option>   
						    <option value="公民">公民</option>   
						    <option value="政府人员">政府人员</option>
						    <option value="公职人员">公职人员</option>
						</select>
					</td>
	    		</tr>
	    		<tr>
	    			<td>电话:</td>
	    			<td><input id="add_readerPhone" style="width: 200px; height: 30px;" class="easyui-textbox"  name="add_readerPhone"   data-options="required:true, missingMessage:'不能为空',validType:'tel'" /></td>
	    		</tr>
	    		<tr>
	    			<td>地址:</td>
	    			<td><input id="add_readerAddress" style="width: 200px; height: 30px;" class="easyui-textbox"  name="add_readerAddress"   data-options="required:true, missingMessage:'不能为空'" /></td>
	    		</tr>
	    	</table>
	    </form>
	</div>
	<!-- 修改窗口 -->
	<div id="editDialog" style="padding: 10px">  
    	<form id="editForm" >
	    	<table cellpadding="8" >
	    		<tr>
	    			<td>姓名:</td>
	    			<td><input id="edit_readerName" style="width: 200px; height: 30px;" class="easyui-textbox"  name="edit_readerName"   data-options="required:true, missingMessage:'不能为空'" /></td>
	    		</tr>
	    		<tr>
	    			<td>性别:</td>
	    			<td><select id="edit_readerSex" class="easyui-combobox" name="edit_readerSex" style="width: 200px; height: 30px;" data-options="editable:false">   
						    <option value="0">--请选择性别--</option>
						    <option value="男">男</option>   
						    <option value="女">女</option>   
						</select></td>
	    		</tr>
	    		<tr>
	    			<td>社会身份:</td>
	    			<td><select id="edit_readerIdentity" class="easyui-combobox" name="edit_readerIdentity" style="width: 200px; height: 30px;" data-options="editable:false">   
						    <option value="0">--请选择社会身份--</option>
						    <option value="学生">群众</option>   
						    <option value="公民">公民</option>   
						    <option value="政府人员">政府人员</option>
						    <option value="公职人员">公职人员</option>
						</select>
					</td>
	    		</tr>
	    		<tr>
	    			<td>电话:</td>
	    			<td><input id="edit_readerPhone" style="width: 200px; height: 30px;" class="easyui-textbox"  name="edit_readerPhone"   data-options="required:true, missingMessage:'不能为空',validType:'tel'" /></td>
	    		</tr>
	    		<tr>
	    			<td>地址:</td>
	    			<td><input id="edit_readerAddress" style="width: 200px; height: 30px;" class="easyui-textbox"  name="edit_readerAddress"   data-options="required:true, missingMessage:'不能为空'" /></td>
	    		</tr>
	    	</table>
	    </form>
	</div>
	<!-- 历史借阅窗口 -->
	<div id="historicalBorrowDialog" style="padding: 10px">  
    	<table cellpadding="8" id="borrowList">
    	</table>
	</div>
	
</body>

<script type="text/javascript">  
	//textbox数据验证
	$.extend($.fn.textbox.defaults.rules, {  
	    tel: {  
	        validator: function(value){
	            var partten = /^1[3,5,7,8]\d{9}$/;
	            return partten.test(value);  
	        },  
	        message: '请填写正确的手机号！'  
	    }
    });
	
	
</script>
</html>