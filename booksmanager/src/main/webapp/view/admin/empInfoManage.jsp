<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>学生信息管理</title>
<link rel="stylesheet" type="text/css" href="../../jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" t`ype="text/css" href="../../jquery-easyui-1.3.3/themes/icon.css">
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
			

	    //删除
	    function delete1(){
	    
	    	var selectRows = $("#dataList").datagrid("getSelections");
        	var selectLength = selectRows.length;
        	if(selectLength == 0){
            	$.messager.alert("消息提醒", "请选择数据进行删除!", "warning");
            } else{
            	var strIds=[];
    			for(var i=0;i<selectRows.length;i++){
    				strIds.push(selectRows[i].empId);
    			}
    			var ids=strIds.join(",");
            	$.messager.confirm("消息提醒", "将删除选中员工相关的所有数据，确认继续？", function(r){
            		if(r){
            			$.ajax({
							type: "post",
							url: "${pageContext.request.contextPath}/emp/deleteByIds.do",
							data:{ids: ids},
							traditional: true,
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
	    
	    }
	  
		    function edit(){
	    	//设置修改员工窗口
	        $("#editDialog").dialog({
	        	title: "修改员工",
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
	    								empLoginName:$("#empLoginName1").val(),
	    								empLoginPwd:$("#empLoginPwd1").val(),
	    								empName:$("#empName1").val(),
	    								empSex:$("#empSex1").val(),
	    								empTel:$("#empTel1").val(),
	    								empAddress:$("#empAddress1").val(),
	    								empRemark:$("#empRemark1").val(),
	    							empState:1
	    							};
	    						
	    						$.ajax({
	    							
	    							type: "post",
	    							url: "${pageContext.request.contextPath}/emp/update.do",
	    							data: emp1,
	    							dataType:"json",
	    							success: function(msg){
	    								if(msg.msg == "success"){
	    									//重新刷新页面数据
	    									$('#dataList').datagrid("reload");
	    									$.messager.alert("消息提醒","修改成功!","info");
	    									//关闭窗口
	    									$("#editDialog").dialog("close");
	    									//清空原表格数据
	    									
	    									$("#empLoginName").val("");
	    									$("#empLoginPwd").val("");
	    									$("#empName").val("");
	    									$("#empTel").val("");
	    									$("#empAddress").val("");
	    									$("#empRemark").val("");
	    									
	    								} else{
	    									$.messager.alert("消息提醒","修改失败!","warning");
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
	    					$("#empLoginName").val("");
							$("#empLoginPwd").val("");
							$("#empName").val("");
							
							$("#empTel").val("");
							$("#empAddress").val("");
							$("#empRemark").val("");
	    					
	    				}
	    			}
	    		]
	        });
	        
				
	        var selectRow=$("#dataList").datagrid("getSelections");
	    	if(selectRow.length==0){
	    		$.messager.alert("消息提醒", "请选择要修改的员工!", "warning");
	    	}else if(selectRow.length>1){
	    		$.messager.alert("消息提醒", "一次只能修改一个员工，请重新选择!", "warning");
	    	}else{
	    		
	    		$("#editDialog").dialog("open");
	    	}
	}
					
		 //设置工具类按钮
	    function add(){
	    	
	    	//设置添加员工窗口
	        $("#addDialog").dialog({
	        	title: "添加员工",
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
	    						var emp = {
	    								
	    								empLoginName:$("#empLoginName").val(),
	    								empLoginPwd:$("#empLoginPwd").val(),
	    								empName:$("#empName").val(),
	    								empSex:$("#empSex").val(),
	    								empTel:$("#empTel").val(),
	    								empAddress:$("#empAddress").val(),
	    								empRemark:$("#empRemark").val(),
	    							empState:1
	    							};
	    						
	    						$.ajax({
	    							
	    							type: "post",
	    							url: "${pageContext.request.contextPath}/emp/save.do",
	    							data: JSON.stringify(emp),/* $("#addForm").serialize(), */
	    							dataType:"json",
	    							contentType:"application/json",
	    							success: function(msg){
	    								if(msg.msg == "success"){
	    									//重新刷新页面数据
	    									$('#dataList').datagrid("reload");
	    									$.messager.alert("消息提醒","添加成功!","info");
	    									//关闭窗口
	    									$("#addDialog").dialog("close");
	    									//清空原表格数据
	    									
	    									$("#empLoginName").val("");
	    									$("#empLoginPwd").val("");
	    									$("#empName").val("");
	    									$("#empSex").val("");
	    									$("#empTel").val("");
	    									$("#empAddress").val("");
	    									$("#empRemark").val("");
	    									
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
	    					
	    					$("#empLoginName").val("");
							$("#empLoginPwd").val("");
							$("#empName").val("");
							$("#empSex").val("");
							$("#empTel").val("");
							$("#empAddress").val("");
							$("#empRemark").val("");
	    					
	    				}
	    			}
	    		]
	        });
	        $("#addDialog").dialog("open");
	    }
	</script>
</head>
<body style="margin: 5px;">	
	<div id="tb">
		<div>
			<a onclick="add()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
			<a onclick="edit()" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a>
			<a onclick="delete1()" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
    	</div>
   </div>	
	</div>
	<!-- 主体表格 -->
	<table id="dataList" cellspacing="0" cellpadding="0"> 
			    
	</table> 
	<div id="addDialog" class="easyui-dialog" style=" width: 570px;height: 350px;padding: 10px 20px"
		closed="true" >
		<form id="addForm" method="post">
	    	<table cellpadding="8" >
	    		<tr>
	    			<td>登录名:</td>
	    			<td>
	    				<input id="empLoginName"  style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="empLoginName"  data-options="required:true, missingMessage:'请选择登录名' "/>
					</td>
	    		</tr>
	    		<tr>
	    			<td>密码:</td><!-- add_name -->
	    			<td>
	    			<input id="empLoginPwd" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="empLoginPwd" data-options="required:true, missingMessage:'请填写密码'" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>姓名:</td>
	    			<td><input id="empName" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="empName" data-options="required:true, missingMessage:'请填写姓名'" /></td>
	    	</tr>
	    		<tr>
	    		<td>性别：</td>
					<td><select class="easyui-combobox" id="empSex" name="sex" editable="false" panelHeight="auto" style="width:148px;">
						<option value="男">男</option>
						<option value="女">女</option>
					</select></td>
					<td></td>
	    		</tr>
	    		<tr>
	    			<td>联系电话:</td>
	    			<td><input id="empTel" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="empTel" /></td>
	    		</tr><!-- class="easyui-datebox" -->
	    		<tr>
	    			<td>家庭住址:</td>
	    			<td><input id="empAddress" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="empAddress" data-options="required:true, missingMessage:'请填写家庭住址'" /></td>
	    		</tr>
	    		<tr>
	    			<td>备注:</td>
	    			<td><input id="empRemark" style="width: 200px; height: 26px;" class="easyui-numberbox" type="text" name="empRemark" /></td>
	   			</tr>
	    		<tr>
	    		</tr>
	    	</table>
	    </form>
		<br/><br/>
		<div id="dlg-buttons">
		</div>  
	</div>
		<div id="editDialog" class="easyui-dialog" style=" width: 570px;height: 350px;padding: 10px 20px"
		closed="true" >
		<form id="editForm" method="post">
	    	<table cellpadding="8" >
	    		<tr>
	    			<td>登录名:</td>
	    			<td>
	    				<input id="empLoginName1"  style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="empLoginName"  data-options="required:true, missingMessage:'请选择登录名' "/>
					</td>
	    		</tr>
	    		<tr>
	    			<td>密码:</td><!-- add_name -->
	    			<td>
	    			<input id="empLoginPwd1" style="width: 200px; height: 26px;"  class="easyui-textbox" type="text" name="empLoginPwd" data-options="required:true, missingMessage:'请填写密码'" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>姓名:</td>
	    			<td><input id="empName1" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="empName" data-options="required:true, missingMessage:'请填写姓名'" /></td>
	    	</tr>
	    		<tr>
	    		<td>性别：</td>
					<td><select class="easyui-combobox" id="empSex1" name="sex"  editable="false" panelHeight="auto" style="width:148px;">
						<option value="男">男</option>
						<option value="女">女</option>
					</select></td>
					<td></td>
	    		</tr>
	    		<tr>
	    			<td>联系电话:</td>
	    			<td><input id="empTel1" style="width: 200px; height: 26px;"  class="easyui-textbox" type="text" name="empTel" /></td>
	    		</tr><!-- class="easyui-datebox" -->
	    		<tr>
	    			<td>家庭住址:</td>
	    			<td><input id="empAddress1" style="width: 200px; height: 26px;"  class="easyui-textbox" type="text" name="empAddress" data-options="required:true, missingMessage:'请填写家庭住址'" /></td>
	    		</tr>
	    		<tr>
	    			<td>备注:</td>
	    			<td><input id="empRemark1" style="width: 200px; height: 26px;" class="easyui-numberbox" type="text" name="empRemark" /></td>
	   			</tr>
	    		<tr>
	    		</tr>
	    	</table>
	    </form>
		<br/><br/>
		<div id="dlg-buttons">
		</div>  
	</div>
</body>
</html>