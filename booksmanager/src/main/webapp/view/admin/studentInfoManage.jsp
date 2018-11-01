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
	        title:'学生列表', 
	        iconCls:'icon-more',//图标 
	        border: true, 
	        collapsible:false,//是否可折叠的 
	        fit: true,//自动大小 
	        method: "post",
	        url:"../../studentList?method=StudentList&t="+new Date().getTime(),
	        idField:'id', 
	        singleSelect:false,//是否单选 
	        pagination:true,//分页控件 
	        rownumbers:true,//行号 
	        sortName:'id',
	        sortOrder:'DESC', 
	        remoteSort: false,
	        columns: [[  
				{field:'chk',checkbox: true,width:50},
			        {field:'id',title:'ID',width:50, sortable: true},    
			        {field:'number',title:'学号',width:200, sortable: true},    
			        {field:'name',title:'姓名',width:200},
			        {field:'sex',title:'性别',width:100},
			        {field:'phone',title:'电话',width:150},
			        {field:'qq',title:'QQ',width:150},
			        {field:'clazz',title:'班级',width:150, 
			        	formatter: function(value,row,index){
							if (row.clazz){
								return row.clazz.name;
							} else {
								return value;
							}
						}
				},
			        {field:'grade',title:'年级',width:150, 
					formatter: function(value,row,index){
							if (row.grade){
								return row.grade.name;
							} else {
								return value;
							}
						}	
			       	},
	 		]], 
	        toolbar: "#tb"
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
	})
			
		
		var url;
		function deleteStudent(){
			var selectedRows=$("#dataList").datagrid('getSelections');
			if(selectedRows.length==0){
				$.messager.alert("系统提示","请选择要删除的数据！");
				return;
			}
			var strIds=[];
			for(var i=0;i<selectedRows.length;i++){
				strIds.push(selectedRows[i].id);
			}
			var ids=strIds.join(",");
			
			 $.messager.confirm("系统提示","您确认要删掉这<font color=red>"+selectedRows.length+"</font>条数据吗？",
					 
			function(r){
				if(r){
					$.post("../../studentList?method=studentDelete",{delIds:ids},function(result){
						//ids = 0;
						if(result.success){
							$.messager.alert("系统提示","您已成功删除<font color=red>"+result.delNums+"</font>条数据！"); 
							$("#dataList").datagrid("reload");
							$("#dataList").datagrid("uncheckAll");
						}else{
							$.messager.alert('系统提示',result.errorMsg);
						}
					},"json");
				}
			});
		}

		function searchStudent(){
			$('#dataList').datagrid('load',{
				
			    gradeId:$('#s_gradeId').combobox("getValue"),
				clazzId:$('#s_classId').combobox("getValue")
			});
		}
		
		function openStudentModifyDialog(){
			var selectedRows=$("#dataList").datagrid('getSelections');
			if(selectedRows.length!=1){
				$.messager.alert("系统提示","请选择一条要编辑的数据！");
				return;
			}
			var row=selectedRows[0];
			$("#dlg").dialog("open").dialog("setTitle","编辑学生信息");
			$("#fm").form("load",row);
			url="../../studentList?method=studentupdate&sid="+row.id;
		}
		
		function openStudentAddDialog(){
			$("#dlg").dialog("open").dialog("setTitle","添加学生信息");
			url="../../studentList?method=studentadd";
		}

		
		function saveStudent(){
			$("#fm").form("submit",{
				url:url,
				onSubmit:function(){
					if($('#sex').combobox("getValue")==""){
						$.messager.alert("系统提示","请选择性别");
						return false;
					}
					if($('#gradeId').combobox("getValue")==""){
						$.messager.alert("系统提示","请选择所属年级");
						return false;
					}
					if($('#clazzId').combobox("getValue")==""){
						$.messager.alert("系统提示","请选择所属班级");
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
						$("#dataList").datagrid("reload");
					}
				}
			});
		}
		
		function resetValue(){
			$("#number").val("");
			$("#name").val("");
			$("#sex").combobox("setValue","");
			$("#qq").val("");
			$("#phone").val("");
			$("#clazzId").combobox("setValue","");
			$("#gradeId").combobox("setValue","");
			
			$("#sdesc").val("");
		}
		
		function closeStudentDialog(){
			$("#dlg").dialog("close");
			resetValue();
		}
		
		
	</script>
</head>
<body style="margin: 5px;">	
	<div id="tb">
		<div>
			<a onclick="openStudentAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
			<a onclick="openStudentModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
			<a onclick="deleteStudent()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		</div>
	       &nbsp;所属班级：&nbsp;<input class="easyui-combobox" id="s_classId" name="s_classId" size="10" data-options="panelHeight:'auto',editable:false,valueField:'id',textField:'name',url:'${pageContext.request.contextPath}/classComboList'"/> 
 	       &nbsp;所属年级：&nbsp;<input class="easyui-combobox" id="s_gradeId" name="s_gradeId" size="10" data-options="panelHeight:'auto',editable:false,valueField:'id',textField:'name',url:'${pageContext.request.contextPath}/gradeComboList'"/> 
		    
		<a href="javascript:searchStudent()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
		</div>	
	</div>
	<!-- 主体表格 -->
	<table id="dataList" cellspacing="0" cellpadding="0"> 
			    
	</table> 
	<!-- 弹出框添加和修改公用 -->
	<div id="dlg" class="easyui-dialog" style=" width: 570px;height: 350px;padding: 10px 20px"
		closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post">
			<table cellspacing="5px;">
				<tr>
					<td>学号：</td>
					<td><input type="text" name="number" id="number" class="easyui-validatebox" required="true"/></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>姓名：</td>
					<td><input type="text" name="name" id="name" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
					<td>性别：</td>
					<td><select class="easyui-combobox" id="sex" name="sex" editable="false" panelHeight="auto" style="width:148px;">
					    <option value="">请选择...</option>
						<option value="男">男</option>
						<option value="女">女</option>
					</select></td>
					<td></td>
					<td>电话：</td><!-- 时间easyui-datebox -->
					<td><input id="phone" name="phone" class="easyui-validatebox" data-options="required:true,validType:'length[6,11]'" /> </td>
				</tr>
				<tr>
					<td>班级名称：</td>
					<td><input class="easyui-combobox" id="clazzId" name="clazzid"  data-options="panelHeight:'auto',editable:false,valueField:'id',textField:'name',url:'${pageContext.request.contextPath}/classComboList'"/></td>
					<td></td>
					<td>QQ：</td>
					<td><input type="text" name="qq" id="qq" class="easyui-validatebox" required="true" validType="length[6,11]"/></td>
				</tr>
				 <tr>
					<td >年级名称：</td>
					
					<td><input class="easyui-combobox" id="gradeId" name="gradeid"  data-options="panelHeight:'auto',editable:false,valueField:'id',textField:'name',url:'${pageContext.request.contextPath}/gradeComboList'"/></td>
					<td></td>
					<td></td>
					<td></td>
				</tr> 
				<br/>
				<tr>
					<td valign="top">学生备注：</td>
					<td colspan="4"><textarea rows="3" cols="50" name="sdesc" id="sdesc"></textarea></td>
				</tr> 
			</table>
		</form>
		<br/><br/>
		<div id="dlg-buttons">
			<center>
			    <a href="javascript:saveStudent()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
				<a href="javascript:closeStudentDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
			</center>
		</div>  
	</div>
	
     <!-- <div id="dlg-buttons">
		<a href="javascript:saveStudent()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeStudentDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>  -->
</body>
</html>