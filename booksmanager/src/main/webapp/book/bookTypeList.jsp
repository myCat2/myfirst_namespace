<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>图书列表</title>
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
	        title:'图书类型列表', 
	        iconCls:'icon-more',//图标 
	        border: true, 
	        collapsible:false,//是否可折叠的 
	        fit: true,//自动大小 
	        method: "post",/* ${pageContext.request.contextPath} */
	        url: "${pageContext.request.contextPath}/bookType/booktypelist.do",
	        idField:'bookTypeId', 
	        singleSelect:false,//是否单选 
	        pagination:true,//分页控件 
	        rownumbers:true,//行号 
	        sortName:'bookTypeId',
	        sortOrder:'DESC', 
	        remoteSort: false,
	        columns: [[  
				{field:'chk',checkbox: true,width:50},
 		        {field:'bookTypeId',title:'图书类型编号',width:500, sortable: true},    
 		        {field:'bookTypeName',title:'图书类型名称',width:500, sortable: true},    
 		        
 		  
	 		]], 
	        toolbar: "#toolbar"
	    }); 
	    //设置分页控件 
	    var p = $('#dataList').datagrid('getPager'); 
	    $(p).pagination({ 
	        pageSize: 10,//每页显示的记录条数，默认为10 
	        pageList: [5,10,20,30,50,100],//可以设置每页记录条数的列表 
	        beforePageText: '第',//页数文本框前显示的汉字 
	        afterPageText: '页    共 {pages} 页', 
	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
	    }); 
	    //设置工具类按钮
	    $("#add").click(function(){
	    	$("#addDialog").dialog("open");
	    });
	    //修改
	    $("#edit").click(function(){
	    	var selectRows = $("#dataList").datagrid("getSelections");
        	if(selectRows.length != 1){
            	$.messager.alert("消息提醒", "请选择一条数据进行操作!", "warning");
            } else{
		    	$("#editDialog").dialog("open");
            }
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
    				strIds.push(selectRows[i].bookTypeId);
    			}
    			var ids=strIds.join(",");
            	
            	$.messager.confirm("消息提醒", "将删除该图书类型，确认继续？", function(r){
            		if(r){
            			$.ajax({
							type: "post",
							url: "${pageContext.request.contextPath}/bookType/delete.do",
							data: {ids:ids},
							success: function(msg){
								if(msg.msg == "success"){
									$.messager.alert("消息提醒","删除成功!","info");
									//刷新表格
									$("#dataList").datagrid("reload");
									$("#dataList").datagrid("uncheckAll");
								} else{
									$.messager.alert("消息提醒","删除失败!","warning");
									return;
								}
							}
						});
            		}
            	});
            }
	    });
	  	//设置添加图书窗口
	    $("#addDialog").dialog({
	    	title: "添加图书类型",
	    	width: 650,
	    	height: 460,
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
					iconCls:'icon-user_add',
					handler:function(){
						
						var validate = $("#addForm").form("validate");
						if(!validate){
							$.messager.alert("消息提醒","请检查你输入的数据!","warning");
							return;
							
						} else{
							var booktype = {
  								bookTypeName:$("#a_bookTypeName").val(),
								bookTypeState:1
  							};
							$.ajax({
								type: "post",
								url: "${pageContext.request.contextPath}/bookType/save.do",
								data: booktype,//JSON.stringify(book),/* $("#addForm").serialize(), */
								dataType:"json",
								//contentType:"application/json",
								success: function(msg){
									if(msg.msg == "success"){
										$.messager.alert("消息提醒","添加成功!","info");
										//关闭窗口
										$("#addDialog").dialog("close");
										//清空原表格数据
										
										$("#a_bookTypeName").textbox('setValue', "");
										
										
										
										//重新刷新页面数据
										$('#dataList').datagrid("reload");
							  			
										
									} else{
										$.messager.alert("消息提醒","添加失败!","warning");
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
						
						$("#a_bookTypeName").textbox('setValue', "");
						
						
						
					}
				},
			]
	    });
	    
	  	//设置编辑学生窗口
	    $("#editDialog").dialog({
	    	title: "修改学生信息",
	    	width: 650,
	    	height: 460,
	    	iconCls: "icon-edit",
	    	modal: true,
	    	collapsible: false,
	    	minimizable: false,
	    	maximizable: false,
	    	draggable: true,
	    	closed: true,
	    	buttons: [
	    		{
					text:'提交',
					plain: true,
					iconCls:'icon-user_add',
					handler:function(){
						var validate = $("#editForm").form("validate");
						if(!validate){
							$.messager.alert("消息提醒","请检查你输入的数据!","warning");
							return;
						} else{
							var bookType = {	
								bookTypeId:$("#e_bookTypeId").val(),
  								bookTypeName:$("#e_bookTypeName").val()
  								
								
			  				};
							$.ajax({
								type: "post",
								url: "${pageContext.request.contextPath}/bookType/save.do",
								data: bookType,/* $("#addForm").serialize(), */
								dataType:"json",
								//contentType:"application/json",
								success: function(msg){
									if(msg.msg == "success"){
										$.messager.alert("消息提醒","更新成功!","info");
										//关闭窗口
										$("#editDialog").dialog("close");
										//刷新表格
										$("#dataList").datagrid("reload");
										$("#dataList").datagrid("uncheckAll");
										
										/* $("#gradeList").combobox('setValue', gradeid);
							  			 */
							  			
									} else{
										$.messager.alert("消息提醒","更新失败!","warning");
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
						//清空表单
						$("#e_bookName").textbox('setValue', "");
						$("#e_bookBorrowDays").textbox('setValue', "");
						$("#e_bookWriter").textbox('setValue', "");
						$("#e_bookIsborrow").textbox('setValue', "");
						$("#e_type").combobox("clear");
						$("#e_bookPrice").textbox('setValue', "");
						$("#e_bookNum").textbox('setValue', "");
						$("#e_bookBorrowPrice").textbox('setValue', "");
						$("#e_bookTrans").textbox('setValue', "");
						$("#e_bookPublicDate").textbox('setValue', "");
						$("#e_bookPublicHouse").textbox('setValue', "");

					}
				}
			],
			onBeforeOpen: function(){
				var selectRow = $("#dataList").datagrid("getSelected");
				//设置值<!-- e_bookPublicDate e_bookBorrowPrice e_bookTrans-->
				$("#e_bookTypeId").textbox('setValue', selectRow.bookTypeId);
				$("#e_bookTypeName").textbox('setValue', selectRow.bookTypeName);
			}
	    });
	   
	});
	
	 function searchStudent(){
		$('#dataList').datagrid('reload',{
		    str:$('#str').textbox("getValue"),
		});
	} 
	</script>
</head>
<body>
	<!-- 学生列表 -->
	<table id="dataList" cellspacing="0" cellpadding="0"> 
	    
	</table> 
	<!-- 工具栏 -->
	<div id="toolbar">
		<div style="float: left;"><a id="add" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a></div>
			<div style="float: left;" class="datagrid-btn-separator"></div>
		<div style="float: left;"><a id="edit" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a></div>
			<div style="float: left;" class="datagrid-btn-separator"></div>
		<div style="float: left;"><a id="delete" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-some-delete',plain:true">删除</a></div>
		
		<div style="float: left; margin: 0px 10px 0 10px">类型搜索：<input style="height: 25px" class="easyui-textbox" data-options="multiline:true,prompt:'请输入图书类型'"  id="str" name="str" /></div>
		<a href="javascript:searchStudent()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
	</div>
	
	<!-- 添加图书窗口 -->
	<div id="addDialog" style="padding: 10px">  
		<div style="float: right; margin: 20px 20px 0 0; width: 200px; border: 1px solid #EBF3FF" id="photo">
	    	<img alt="照片" style="max-width: 200px; max-height: 400px;" title="照片" src="../photo/student.jpg" />
	    </div> 
    	<form id="addForm" method="post">
	    	<table cellpadding="8" >
	    		
	    		<tr>
	    			<td>图书类型名称:</td><!-- add_name -->
	    			<td>
	    			<input id="a_bookTypeName" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="name" data-options="required:true, missingMessage:'请填写名称'" />
	    			</td>
	    		</tr>
	    		
	    		
	    		
	    		<tr>
	    		</tr>
	    	</table>
	    </form>
	</div>
	
	<!-- 修改学生窗口 -->
	<div id="editDialog" style="padding: 10px">
		<div style="float: right; margin: 20px 20px 0 0; width: 200px; border: 1px solid #EBF3FF">
	    	<img id="edit_photo" alt="照片" style="max-width: 200px; max-height: 400px;" title="照片" src="../photo/student.jpg" />
	    </div>   
    	<form id="editForm" method="post">
	    	<table cellpadding="8" >
	    		<tr>
	    			<!--
	    			a_type a_bookName a_bookWriter a_bookTrans a_bookPublicDate
	    			a_bookPublicHouse a_bookNum a_bookPrice
	    			-->
	    			<td>图书类型编号:</td>
	    			<td><input id="e_bookTypeId" style="width: 200px; height: 25px;" class="easyui-textbox" type="text" name="name" data-options="readonly: true" /></td>
	    		
	    			
	    		</tr>
	    		<tr>
	    			<td>图书名称</td>
	    			<td>
	    				<input id="e_bookTypeName" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="name" data-options="required:true, missingMessage:'请填写名称'" />
	    			</td>	
	    		</tr>
	    		<tr></tr>
	    	</table>
	    </form>
	</div>
	
</body>
</html>
