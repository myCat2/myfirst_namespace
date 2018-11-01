<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../../jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" t`ype="text/css" href="../../jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="../../jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="../../jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../../jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
var url;
function deleteStudent(){
	var selectedRows=$("#dg").datagrid('getSelections');
	if(selectedRows.length==0){
		$.messager.alert("系统提示","请选择要删除的数据！");
		return;
	}
	var strIds=[];
	for(var i=0;i<selectedRows.length;i++){
		strIds.push(selectedRows[i].id);
	}
	var ids=strIds.join(",");
	
	$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
		if(r){
			$.post("${pageContext.request.contextPath}/teacherServlet?method=teacherDelete",{delIds:ids},function(result){
				if(result.success){
					$.messager.alert("系统提示","您已成功删除<font color=red>"+result.delNums+"</font>条数据！");
					$("#dg").datagrid("reload");
				}else{
					$.messager.alert('系统提示',result.errorMsg);
				}
			},"json");
		}
	});
}

function searchStudent(){
	$('#dg').datagrid('load');
}


function openStudentAddDialog(){/* ..${pageContext.request.contextPath}/teacherServlet?method=teacherList */
	$("#dlg").dialog("open").dialog("setTitle","添加教师信息");
	url="${pageContext.request.contextPath}/teacherServlet?method=teacherAdd";
}

function saveStudent(){
	$("#fm").form("submit",{
		url:url,
		onSubmit:function(){
			if($('#sex').combobox("getValue")==""){
				$.messager.alert("系统提示","请选择性别");
				return false;
			}
			
			return $(this).form("validate");
		},
		success:function(result){
			if(result.errorMsg){
				$.messager.alert("系统提示",result.errorMsg);
				return;
			}else{
				$.messager.alert("系统提示","保存成功");
				resetValue();
				$("#dlg").dialog("close");
				$("#dg").datagrid("reload");
			}
		}
	});
}

function resetValue(){
	$("#number").val("");
	$("#name").val("");
	$("#sex").combobox("setValue","");
	$("#phone").val("");
	$("#qq").val("");
	$("#tdesc").val("");
}

function closeStudentDialog(){
	$("#dlg").dialog("close");
	resetValue();
}

function openStudentModifyDialog(){
	var selectedRows=$("#dg").datagrid('getSelections');
	if(selectedRows.length!=1){
		$.messager.alert("系统提示","请选择一条要编辑的数据！");
		return;
	}
	var row=selectedRows[0];
	$("#dlg").dialog("open").dialog("setTitle","编辑教师信息");
	$("#fm").form("load",row);
	url="../../teacherServlet?method=teacherUpdate&id="+row.id;
}
</script>
</head>
<body style="margin: 5px;">
<!-- 承载数据的表格,简称数据网格 -->
<table id="dg" title="教师信息" class="easyui-datagrid" fitColumns="true"
 pagination="true" rownumbers="true" url="${pageContext.request.contextPath}/teacherServlet?method=teacherList" fit="true" toolbar="#tb">
	<thead>
		<tr>
			<th field="cb" checkbox="true"></th>
			<th field="id" width="80" align="center">编号</th>
			<th field="number" width="100" align="center">工号</th>
			<th field="name" width="100" align="center">姓名</th>
			<th field="sex" width="80" align="center">性别</th>
			<!-- <th field="gradeId" width="100" align="center" hidden="true">班级ID</th> <th field="gradeName" width="100" align="center">班级名称</th> -->
	        <th field="phone" width="120" align="center">电话</th>
			<th field="qq" width="120" align="center">QQ</th>
			<th field="tdesc" width="220" align="center">备注</th>
		</tr>
	</thead>
</table>
<!-- 表格配套的工具栏 -->
<div id="tb">
	<div>
		<a href="javascript:openStudentAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
		<a href="javascript:openStudentModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
		<a href="javascript:deleteStudent()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
	</div>
</div>

<div id="dlg" class="easyui-dialog" style="width: 570px;height: 350px;padding: 10px 20px"
	closed="true" buttons="#dlg-buttons">
	<form id="fm" method="post">
		<table cellspacing="5px;">
			<tr>
				<td>工号：</td>
				<td><input  name="number" id="number" class="easyui-validatebox" required="true"/></td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>姓名：</td>
				<td><input  name="name" id="name" class="easyui-validatebox" required="true"/></td>
			</tr>
			<tr>
				<td>性别：</td>
				<td><select class="easyui-combobox" id="sex" name="sex" editable="false" panelHeight="auto" style="width: 150px">
				    <option value="">请选择...</option>
					<option value="男">男</option>
					<option value="女">女</option>
				</select></td>
				<td></td>
				<td>电话：</td>
				<td><input class="easyui-validatebox" name="phone" id="phone" required="true"/></td>
			</tr>
			<tr>
				<td>QQ：</td>
				<td><input  name="qq" id="qq" class="easyui-validatebox" required="true"/></td>
				<td></td>
				<td></td>
				<td><</td>
			</tr>
			<tr>
				<td valign="top">教师备注：</td>
				<td colspan="4"><textarea rows="7" cols="50" name="tdesc" id="tdesc"></textarea></td>
			</tr>
		</table>
	</form>
</div>
<div id="dlg-buttons">
	<a href="javascript:saveStudent()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeStudentDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
</body>
</html>