<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>员工职务管理</title>
<link rel="stylesheet" type="text/css" href="../../jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../../jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="../../jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="../../jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../../jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
 
 <script type="text/javascript">
	$(function(){
		//datagrid初始化 
	    $('#dataList').datagrid({ 
	        title:'员工列表', 
	        iconCls:'icon-more',//图标 
	        border: true, 
	        collapsible:false,//是否可折叠的 
	        fit: true,//自动大小 
	        method: "post",
	        url:"${pageContext.request.contextPath}/emp/list.do",
	        idField:'empId', 
	        singleSelect:false,//是否单选 
	        pagination:true,//分页控件 
	        rownumbers:true,//行号 
	        sortName:'empId',
	        sortOrder:'DESC', 
	        remoteSort: false,
	        columns: [[  
				{field:'chk',checkbox: true,width:50},
			        {field:'empId',title:'ID',width:50, sortable: true},    
			        {field:'empName',title:'姓名',width:100},
			        {field:'empSex',title:'性别',width:100},
			        {field:'empTel',title:'电话',width:150},
			        {field:'empEntryDate',title:'入职时间',width:150},
			        {field:'empAddress',title:'家庭住址',width:150},
			        {field:'empRemark',title:'备注',width:150}, 
			        	
			        {field:'role',title:'角色',width:150, 
					formatter: function(value,row,index){
							if (row.role){
								return row.role.roleName;
							} else {
								return value;
							}
						}	
			       	},
	 		]], 
	        toolbar: "#tb"
	    }); 
	    var url;
	    //设置分页控件 
	     var p = $('#dataList').datagrid('getPager'); 
	    
	    $(p).pagination({ 
	        pageSize: 10,//每页显示的记录条数，默认为10 
	        pageList: [5,10,20,30,50,100],//可以设置每页记录条数的列表 
	        beforePageText: '第',//页数文本框前显示的汉字 
	        afterPageText: '页    共 {pages} 页', 
	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
	    });   
	})
			
		    function edit(){
	    	//设置修改员工职务窗口
	        $("#editDialog").dialog({
	        	title: "修改员工职务",
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
	    				text:'修改',
	    				plain: true,
	    				iconCls:'icon-user_add',
	    				handler:function(){
	    					var validate = $("#editForm").form("validate");
	    					var selectRow=$("#dataList").datagrid("getSelected");
	    					if(!validate){
	    						$.messager.alert("消息提醒","请检查你输入的数据!","warning");
	    						return;
	    					} else{
	    						var emp1 = {
	    								empId:selectRow.empId,
	    								roleId:$("#roleId").combobox("getValue")
	    							};
	    						
	    						$.ajax({
	    							
	    							type: "post",
	    							url: "${pageContext.request.contextPath}/role/update.do",
	    							data: emp1,
	    							dataType:"json",
	    							success: function(msg){
	    								if(msg.msg == "success"){
	    									//重新刷新页面数据
	    									$('#dataList').datagrid("reload");
	    									$.messager.alert("消息提醒","修改成功!","info");
	    									//关闭窗口
	    									$("#editDialog").dialog("close");
	    								} else{
	    									$.messager.alert("消息提醒","修改失败!","warning");
	    									return;
	    								}
	    							}
	    						});
	    					}
	    				}
	    			}
	    			
	    		]
	        });
	        var selectRow=$("#dataList").datagrid("getSelections");
	    	if(selectRow.length==0){
	    		$.messager.alert("消息提醒", "请选择要修改职务的员工!", "warning");
	    	}else if(selectRow.length>1){
	    		$.messager.alert("消息提醒", "每次只能修改一名员工的职务，请重新选择!", "warning");
	    	}else{
	    		$("#editDialog").dialog("open");
	    	}
		    }
		    
		
	</script>
</head>
<body style="margin: 5px;">	
	<div id="tb">
		<div>
			<a onclick="edit()" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改职务</a>
    	</div>
   </div>	
	</div>
	<!-- 主体表格 -->
	<table id="dataList" cellspacing="0" cellpadding="0"> 
			    
	</table> 
	<div id="editDialog" class="easyui-dialog" style=" width: 570px;height: 350px;padding: 10px 20px"
		closed="true" >
		<form id="addForm" method="post">
	    	<table cellpadding="8" >
	    		
	    		<tr>
	    		<td>职务：</td>
					<td><select class="easyui-combobox" id="roleId" name="roleId" editable="false" panelHeight="auto" style="width:148px;">
						<option value="1">普通管理员</option>
						<option value="2">高级管理员</option>
						<option value="3">采购经理</option>
						<option value="4">馆长</option>
					</select></td>
					<td></td>
	    		</tr>
	    		
	    		
	    	</table>
	    </form>
		<br/><br/>
		
</body>
</html>