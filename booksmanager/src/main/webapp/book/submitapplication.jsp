<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>提交申请信息</title>
	<link rel="stylesheet" type="text/css" href="../easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="../easyui/css/demo.css">
	<script type="text/javascript" src="../easyui/jquery.min.js"></script>
	<script type="text/javascript" src="../easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../easyui/js/validateExtends.js"></script>
	<script type="text/javascript">
$(function() {	
	$("#BookIds").combobox({
  		width: "70",
  		height: "25", 
  		valueField: "bookName",
  		textField: "bookId",
  		multiple: false, //可多选
  		editable: false, //不可编辑
  		method: "post",
  		url: "${pageContext.request.contextPath}/bookType/bookIdandName.do",
  		onChange: function(newValue, oldValue){
  			
  			
  			 /* 给下文本框赋值 */ 
  			 $("#BookName").textbox('setValue', newValue);
  			
  			}
  	});
	//设置编辑学生窗口
    $("#editDialog").dialog({
    	title: "修改密码",
    	width: 500,
    	height: 400,
    	fit: true,
    	modal: false,
    	noheader: true,
    	collapsible: false,
    	minimizable: false,
    	maximizable: false,
    	draggable: true,
    	closed: false,
    	toolbar: [
    		{
				text:'提交下架书籍',
				plain: true,
				iconCls:'icon-user_add',
				handler:function(){
					var validate = $("#editForm").form("validate");
					if(!validate){
						$.messager.alert("消息提醒","请检查你输入的数据!","warning");
						return;
					} else{
						/* 
								
						
						整合时需要修改
						
		
						*/
						 var purchase = {
								bookId:$("#BookIds").combobox("getText"),
								purchaseReason:$("#reason").val(),
								purchaseState:1,
								purchaseRemark:'未通过',
								empId: $("#empId").val()
								
						};
						$.ajax({
							type: "post",
							url: "${pageContext.request.contextPath}/bookType/addapplacation.do",
							data: purchase,
							success: function(msg){
								if(msg.msg == "success"){
									$.messager.alert("消息提醒","提交成功!","info");
									//$("#BookIds").textbox('setValue', "");
									$("#BookName").textbox('setValue', "");
									$("#reason").textbox('setValue', "");
									//重新加载图书ID
									$("#BookIds").combobox("clear");
									$("#BookIds").combobox("reload");
									
								} else{
									$.messager.alert("消息提醒","提交失败!","warning");
									return;
								}
							}
						});
					}
				}
			},'-',
			{
				text:'重置',
				plain: true,
				iconCls:'icon-reload',
				handler:function(){
					//清空表单
					$("#BookIds").textbox('setValue', "");
					$("#BookName").textbox('setValue', "");
					$("#reason").textbox('setValue', "");
				}
			},
			
		],
		
    });
})
</script>
</head>
<body>
	
	<!-- 修改学生窗口 -->
<div id="editDialog" style="padding: 20px">
   	<form id="editForm">
    	<table cellpadding="8" >
    		<tr>
    			<td>图书编号:</td>
    			<td>
    				<input id="BookIds" class="easyui-textbox"  />
    			</td>
    		</tr>
    		<tr>
    			<td>图书名称:</td>
    			<td>
    				<input id="BookName"  data-options="readonly: true" class="easyui-textbox" style="width: 200px; height: 30px;" type="text"  />
    			</td>
    		</tr>
    		<tr>
    			<td>申请原因:</td>
    			<td><input id="reason" style="width: 200px; height: 30px;" class="easyui-textbox" type="text"  data-options="required:true, missingMessage:'请填写申请原因'" /></td>
    		</tr>
    		<tr>
    			<td></td>
    			<td><input id="empId" value="${user.empId}" style="width: 200px; height: 30px;display:none;" type="text"   /></td>
    		</tr>
    		
    		
    	</table>
    </form>
</div>	
</body>
</html>