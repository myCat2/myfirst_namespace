<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	String path=request.getContextPath();
%>
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
	//获得session
	var user="<%=session.getAttribute("user")%>";
	var realEmpId=user.split(",")[0].substring(11);
	$(function() {	
		//datagrid初始化 
	    $('#dataList').datagrid({ 
	        title:'图书列表', 
	        iconCls:'icon-more',//图标 
	        border: true, 
	        collapsible:false,//是否可折叠的 
	        fit: true,//自动大小 
	        method: "post",/* ${pageContext.request.contextPath} */
	        url: "${pageContext.request.contextPath}/book/booklist.do",
	        idField:'bookId', 
	        singleSelect:false,//是否单选 
	        pagination:true,//分页控件 
	        rownumbers:true,//行号 
	        sortName:'bookId',
	        sortOrder:'DESC', 
	        remoteSort: false,
	        columns: [[  
				{field:'chk',checkbox: true,width:50},
 		        {field:'bookId',title:'图书编号',width:70, sortable: true},    
 		        {field:'bookName',title:'图书名称',width:120, sortable: true},   
 		       {field:'bookType',title:'图书类型',width:120, 
 		        	formatter: function(value,row,index){
 						if (row.bookType){
 							return row.bookType.bookTypeName;
 						} else {
 							return value;
 						}
 					}
				},
 		        {field:'bookWriter',title:'图书作者',width:120},
 		        {field:'bookNum',title:'图书数量',width:120},
 		        {field:'bookPrice',title:'图书价格',width:120},       
     			 {field:'bookIsborrow',title:'图书是否可借',width:120},
     			{field:'bookBorrowDays',title:'图书可借天数',width:120},
 		        
				{field:'field',title:'',width:90,formatter:aaa},
				{field:'949',title:'',width:120,formatter:bbb}
				
	 		]], 
	        toolbar: "#toolbar",
	        onLoadSuccess:function(){
	        	$('.btnBorrow').linkbutton({plain:true,iconCls:'icon-reload'});
	        	$('.btnLookUp').linkbutton({plain:true,iconCls:'icon-search'});
	        	$('#dataList').datagrid('fixRowHeight');
	        }
	    }); 
		//格式化借阅栏 
	    function aaa(val, rowdata, rowIndex)
        {
       		return "<a class='btnBorrow' href='javascript:;' id='borrow'>借阅</a>";
        }
	    function bbb(val, rowdata, rowIndex)
        {
       		return "<a class='btnLookUp' href='javascript:;' id='bookinfo'>查看详情</a>";
        }
	    //打开详情窗口
	     $("#bookinfo").live("click",function(){
	    	$("#bookinfoDialog").dialog("open");
	    });
	   	//设置详情窗口
	   	 $("#bookinfoDialog").dialog({
	    	title: "图书详情窗口",
	    	width: 650,
	    	height: 460,
	    	iconCls: "icon-add",
	    	modal: true,
	    	collapsible: false,
	    	minimizable: false,
	    	maximizable: false,
	    	draggable: true,
	    	closed: true,
			onBeforeOpen:function(){
				var selectRow=$("#dataList").datagrid("getSelected");
				$("#book_borrow_price").textbox('setValue', selectRow.bookBorrowPrice);
				$("#book_trans").textbox('setValue', selectRow.bookTranslator);
				 $("#book_public_date").textbox('setValue', selectRow.bookPublicDate);
				 
				 $("#book_id").textbox('setValue', selectRow.bookId);
				$("#book_name").textbox('setValue', selectRow.bookName);
				$("#book_writer").textbox('setValue', selectRow.bookWriter);
				$("#book_isborrow").textbox('setValue', selectRow.bookIsborrow);
				$("#book_borrow_days").textbox('setValue', selectRow.bookBorrowDays);
			
				 $("#book_num").textbox('setValue', selectRow.bookNum);
				 $("#book_price").textbox('setValue', selectRow.bookPrice);
				 $("#book_public_house").textbox('setValue', selectRow.bookPublicHouse);
				 var bookTypeName = selectRow.bookType.bookTypeName;
				 var bookTypeId = selectRow.bookType.bookTypeId;
				 $("#book_type").combobox('setValue', bookTypeId);
		    },
		    onClose:function(){
					$('#dataList').datagrid('clearSelections');
		    }
	    });
	   	//打开借阅窗口
	    $("#borrow").live("click",function(){
	    	$("#borrowDialog").dialog("open");
	    });
	  	//设置借阅图书窗口
	    $("#borrowDialog").dialog({
	    	
	    	title: "图书借阅",
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
					text:'确认',
					plain: true,
					iconCls:'icon-user_add',
					handler:function(){
						
						var validate = $("#borrowForm").form("validate");
						if(!validate){
							$.messager.alert("消息提醒","请检查你输入的数据!","warning");
							return;
							
						} else{
							var borrow = {
								booktypeId:$("#b_type").val(),
								bookId:$("#b_bookId").val(),
								readerId:$("#b_readerId").val(),
								empId:realEmpId
  							};  
							
							$.ajax({
								type: "post",
								url: "${pageContext.request.contextPath}/borrow/insertBorrow.do",
								data: JSON.stringify(borrow),
								dataType:"json",
								contentType:"application/json",
								success: function(msg){
									if(msg.flag == 1){
										$.messager.alert("消息提醒","借阅成功!","info");
										//关闭窗口
										$("#borrowDialog").dialog("close");
										//清空原表格数据
										
										$("#b_bookId").textbox('setValue', "");
										$("#b_type").textbox('setValue', "");
										$("#b_readerId").textbox('setValue', "");
										$("#b_empId").textbox('setValue', "");
										
										//重新刷新页面数据
										$('#dataList').datagrid("reload","<%=path%>/book/booklist.do");
										$('#dataList').datagrid('clearSelections');
									}else if(msg.flag == -1){
										$.messager.alert("消息提醒","当前读者存在未归还图书,请归还后再借阅!","warning");
										return;
									}else if(msg.flag == -2){
										$.messager.alert("消息提醒","当前读者编号不存在,请重新核对!","warning");
										return;
									}else{
										$.messager.alert("消息提醒","借阅失败,请再次尝试!","warning");
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
						$("#b_bookId").textbox('setValue',selectRow.bookId);
						$("#b_type").textbox('setValue', selectRow.bookTypeId);
						$("#b_readerId").textbox('setValue', "");
					}
				}
			],
			onBeforeOpen:function(){
				var selectRow=$("#dataList").datagrid("getSelected");
				$("#b_bookId").textbox('setValue',selectRow.bookId);
				$("#b_type").textbox('setValue', selectRow.bookTypeId);
				$("#b_readerId").textbox('setValue', "");
				$("#b_empId").textbox('setValue',realEmpId);
		    },
		    onClose:function(){
				$('#dataList').datagrid('clearSelections');
		    }
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
    				strIds.push(selectRows[i].bookId);
    			}
    			var ids=strIds.join(",");
            	
            	$.messager.confirm("消息提醒", "将删除该图书相关的所有数据，确认继续？", function(r){
            		if(r){
            			$.ajax({
							type: "post",
							url: "${pageContext.request.contextPath}/book/delete.do",
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
	    
	  	//年级下拉框
	  	 $("#gradeList").combobox({
	  		width: "70",
	  		height: "25", 
	  		valueField: "bookTypeId",
	  		textField: "bookTypeName",
	  		multiple: false, //可多选
	  		editable: false, //不可编辑
	  		panelHeight:"auto",
	  		method: "post",
	  		url: "booktypelist.do",
	  		onChange: function(newValue, oldValue){
	  			//加载该年级下的学生
	  			$('#dataList').datagrid("options").queryParams = {bookTypeId: newValue};
	  			$('#dataList').datagrid("reload");
	  			//加载该年级下的班级
	  			}
	  	}); 
	  	//班级下拉框

	  	//下拉框通用属性
	  	  $("#a_type, #e_type").combobox({
	  		width: "200",
	  		height: "26",
	  		valueField: "bookTypeId",
	  		textField: "bookTypeName",
	  		multiple: false, //可多选
	  		editable: false, //不可编辑
	  

	  		method: "post",
	  	});  
	  /*  	$("#a_type").combobox({
	  		url: "GradeServlet?method=GradeList&t="+new Date().getTime(),
			onLoadSuccess: function(){
				//默认选择第一条数据
				var data = $(this).combobox("getData");
				$(this).combobox("setValue", data[0].id);
	  		}
	  	}); */
	  	//设置添加图书窗口
	    $("#addDialog").dialog({
	    	title: "添加图书",
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
							/* a_type a_bookName a_bookWriter a_bookTrans a_bookPublicDate
			    			a_bookPublicHouse a_bookNum a_bookPrice */
			    			
							var book = {
									
  								bookName:$("#a_bookName").val(),
  								bookWriter:$("#a_bookWriter").val(),
  								bookTranslator:$("#a_bookTrans").val(),
  								bookPublicDate:$("#a_bookPublicDate").datebox("getValue"),
  								
  								
  								bookPublicHouse:$("#a_bookPublicHouse").val(),
  								bookNum:$("#a_bookNum").val(),
  								bookPrice:$("#a_bookPrice").val(),
  								bookBorrowPrice:1,
								bookTypeId:$("#a_type").combobox("getValue"),
								bookIsborrow:1,
								bookBorrowDays:30,
								bookState:1
								
  							};
							
							
							$.ajax({
								type: "post",
								url: "${pageContext.request.contextPath}/book/save.do",
								data: book,//JSON.stringify(book),/* $("#addForm").serialize(), */
								dataType:"json",
								//contentType:"application/json",
								success: function(msg){
									if(msg.msg == "success"){
										$.messager.alert("消息提醒","添加成功!","info");
										//关闭窗口
										$("#addDialog").dialog("close");
										//清空原表格数据
										
										$("#a_bookName").textbox('setValue', "");
										$("#a_bookWriter").textbox('setValue', "");
										$("#a_bookTrans").textbox('setValue', "");
										$("#a_bookPublicDate").textbox('setValue', "");
										$("#a_bookPublicHouse").textbox('setValue', "");
										$("#a_bookNum").textbox('setValue', "");
										$("#a_bookPrice").textbox('setValue', "");
										
										
										//重新刷新页面数据
										$('#dataList').datagrid("reload");
							  			/* $("#gradeList").combobox('setValue', gradeid);
							  			 */
										
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
						
						$("#a_bookName").textbox('setValue', "");
						$("#a_bookWriter").textbox('setValue', "");
						$("#a_bookTrans").textbox('setValue', "");
						$("#a_bookPublicDate").textbox('setValue', "");
						$("#a_bookPublicHouse").textbox('setValue', "");
						$("#a_bookNum").textbox('setValue', "");
						$("#a_bookPrice").textbox('setValue', "");
						
						//重新加载年级
						$("#a_type").combobox("clear");
						$("#a_type").combobox("reload");
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
						var gradeid = $("#e_type").combobox("getValue");
					
						if(!validate){
							$.messager.alert("消息提醒","请检查你输入的数据!","warning");
							return;
						} else{
							var book = {	
								bookId:$("#e_bookId").val(),
  								bookName:$("#e_bookName").val(),
  								bookWriter:$("#e_bookWriter").val(),
  								bookTranslator:$("#e_bookTrans").val(),
  								bookPublicDate:$("#e_bookPublicDate").datebox("getValue"),
  								bookPublicHouse:$("#e_bookPublicHouse").val(),
  								bookNum:$("#e_bookNum").val(),
  								bookPrice:$("#e_bookPrice").val(),
  								bookBorrowPrice:$("#e_bookBorrowPrice").val(),
								bookBorrowDays:	$("#e_bookBorrowDays").val(),
								bookTypeId:$("#e_type").combobox("getValue"),
								bookIsborrow:$("#e_bookIsborrow").val()
								
			  				};
							$.ajax({
								type: "post",
								url: "${pageContext.request.contextPath}/book/update.do",
								data: book,/* $("#addForm").serialize(), */
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
				$("#e_bookBorrowPrice").textbox('setValue', selectRow.bookBorrowPrice);
				$("#e_bookTrans").textbox('setValue', selectRow.bookTranslator);
				 $("#e_bookPublicDate").textbox('setValue', selectRow.bookPublicDate);
				 
				 $("#e_bookId").textbox('setValue', selectRow.bookId);
				$("#e_bookName").textbox('setValue', selectRow.bookName);
				$("#e_bookWriter").textbox('setValue', selectRow.bookWriter);
				$("#e_bookIsborrow").textbox('setValue', selectRow.bookIsborrow);
				$("#e_bookBorrowDays").textbox('setValue', selectRow.bookBorrowDays);
				/* $("#edit_photo").attr("src", "PhotoServlet?method=GetPhoto&type=2&number="+selectRow.number);
				 */
				 $("#e_bookNum").textbox('setValue', selectRow.bookNum);
				 $("#e_bookPrice").textbox('setValue', selectRow.bookPrice);
				 $("#e_bookPublicHouse").textbox('setValue', selectRow.bookPublicHouse);
				 
				
				 var bookTypeName = selectRow.bookType.bookTypeName;
				 var bookTypeId = selectRow.bookType.bookTypeId;
				
				 $("#e_type").combobox('setValue', bookTypeId);
				
				
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
		<div style="float: left; margin: 0 10px 0 10px">图书类型：<input id="gradeList" class="easyui-textbox" name="grade" /></div>
		<div style="float: left; margin: 0px 10px 0 10px">搜索：<input style="height: 25px ;width: 180px;" class="easyui-textbox" data-options="multiline:true,prompt:'请输入书名/作者/出版社'"  id="str" name="str" /></div>
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
	    			<td>图书类型:</td>
	    			<td>
	    				<input id="a_type"  class="easyui-combobox" id="bookType" name="bookType"  data-options="required:true, missingMessage:'请选择图书类型'  ,panelHeight:'auto',editable:false,valueField:'bookTypeId',textField:'bookTypeName',url:'${pageContext.request.contextPath}/book/booktypelist.do'"/>
					</td>
	    		</tr>
	    		<tr>
	    			<td>名称:</td><!-- add_name -->
	    			<td>
	    			<input id="a_bookName" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="name" data-options="required:true, missingMessage:'请填写名称'" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>作者:</td>
	    			<td><input id="a_bookWriter" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="name" data-options="required:true, missingMessage:'请填写作者'" /></td>
	    	</tr>
	    		<tr>
	    			<td>翻译:</td>
	    			<td><input id="a_bookTrans" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="phone"  /></td>
	    		</tr>
	    		<tr>
	    			<td>出版日期:</td>
	    			<td><input id="a_bookPublicDate" style="width: 200px; height: 26px;" class="easyui-datebox" type="text" name="bookPublicDate" /></td>
	    		</tr>
	    		<tr>
	    			<td>出版社:</td>
	    			<td><input id="a_bookPublicHouse" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="name" data-options="required:true, missingMessage:'请填写出版社'" /></td>
	    		</tr>
	    		<tr>
	    			<td>数量:</td>
	    			<td><input id="a_bookNum" style="width: 200px; height: 26px;" class="easyui-numberbox" type="text" name="name" data-options="required:true, missingMessage:'请输入数量'" /></td>
	   			</tr>
	    		<tr>
	    			<td>购买价格:</td>
	    			<td><input id="a_bookPrice" style="width: 200px; height: 26px;" class="easyui-numberbox" type="text" name="name" data-options="required:true, missingMessage:'请填写价格'" /></td>
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
	    			<td>图书编号:</td>
	    			<td><input id="e_bookId" style="width: 200px; height: 25px;" class="easyui-textbox" type="text" name="name" data-options="readonly: true" /></td>
	    		</tr>
	    		<tr>
	    			<td>图书名称</td>
	    			<td>
	    				<input id="e_bookName" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="name" data-options="required:true, missingMessage:'请填写名称'" />
	    			</td>	
	    		</tr>
	    		<tr>
	    			<td>图书类别:</td>
	    			<td>
	    			<input id="e_type"  class="easyui-combobox" id="bookType" name="bookType"  data-options="required:true, missingMessage:'请选择图书类型'  ,panelHeight:'auto',editable:false,valueField:'bookTypeId',textField:'bookTypeName',url:'${pageContext.request.contextPath}/book/booktypelist.do'"/>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>作者:</td>
	    			<td>
	    			<input id="e_bookWriter" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="name" data-options="required:true, missingMessage:'请填写作者'" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>翻译:</td>
	    			<td>
	    			<input id="e_bookTrans" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="name" data-options="required:true, missingMessage:'请填写翻译'" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>出版社:</td>
	    			<td>
	    			<input id="e_bookPublicHouse" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="name" data-options="required:true, missingMessage:'请填写出版社'" />
	    			</td>
	    		</tr>
	    		 
	    		<tr> 
	    			<td>图书出版日期:</td>
	    			<td>
	    			<input id="e_bookPublicDate" style="width: 200px; height: 26px;" class="easyui-datebox" type="text" name="name" data-options="required:true, missingMessage:'请填写出版日期'" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>图书是否可借(1.true 0.false)</td>
	    			<td>
	    			<input id="e_bookIsborrow" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="name" data-options="required:true, missingMessage:'请填写1或者0'" />
	    			</td>
	    		</tr>
	    		
	    		<tr>
	    			<td>图书可借天数</td>
	    			<td>
	    			<input id="e_bookBorrowDays" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="name" data-options="required:true, missingMessage:'请填写图书可借天数'" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>图书借阅单价(元/天):</td>
	    			<td>
	    			<input id="e_bookBorrowPrice" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="name" data-options="required:true, missingMessage:'请填写单价'" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>数量:</td>
	    			<td>
	    			<input id="e_bookNum" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="name" data-options="required:true, missingMessage:'请填写数量'" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>图书价格:</td>
	    			<td>
	    			<input id="e_bookPrice" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" name="name" data-options="required:true, missingMessage:'请填写图书价格'" />
	    			</td>
	    		</tr>
	    	</table>
	    </form>
	</div>
	<!-- 图书详情表格 -->
	<div id="bookinfoDialog" style="padding: 10px">
	<div style="float: right; margin: 20px 20px 0 0; width: 200px; border: 1px solid #EBF3FF" id="photo">
	    	<img alt="照片" style="max-width: 200px; max-height: 400px;" title="照片" src="../photo/student.jpg" />
	    </div> 
		<table cellpadding="8" >
			<tr>
	    			<!--
	    			a_type a_bookName a_bookWriter a_bookTrans a_bookPublicDate
	    			a_bookPublicHouse a_bookNum a_bookPrice
	    			-->
	    			<td>图书编号:</td>
	    			<td><input id="book_id" style="width: 200px; height: 25px;" class="easyui-textbox" type="text"  data-options="readonly: true" /></td>
	    		</tr>
	    		<tr>
	    			<td>图书名称</td>
	    			<td>
	    				<input id="book_name" style="width: 200px; height: 26px;" class="easyui-textbox" type="text"  data-options="readonly: true" />
	    			</td>	
	    		</tr>
	    		<tr>
	    			<td>图书类别:</td>
	    			<td>
	    			<input id="book_type"  class="easyui-combobox"   data-options="readonly: true"/>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>作者:</td>
	    			<td>
	    			<input id="book_writer" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" data-options="readonly: true" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>翻译:</td>
	    			<td>
	    			<input id="book_trans" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" data-options="readonly: true" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>出版社:</td>
	    			<td>
	    			<input id="book_public_house" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" data-options="readonly: true" />
	    			</td>
	    		</tr>
	    		 
	    		<tr> 
	    			<td>图书出版日期:</td>
	    			<td>
	    			<input id="book_public_date" style="width: 200px; height: 26px;" class="easyui-datebox" type="text"  data-options="readonly: true" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>图书是否可借(1.true 0.false)</td>
	    			<td>
	    			<input id="book_isborrow" style="width: 200px; height: 26px;" class="easyui-textbox" type="text"  data-options="readonly: true" />
	    			</td>
	    		</tr>
	    		
	    		<tr>
	    			<td>图书可借天数</td>
	    			<td>
	    			<input id="book_borrow_days" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" data-options="readonly: true" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>图书借阅单价(元/天):</td>
	    			<td>
	    			<input id="book_borrow_price" style="width: 200px; height: 26px;" class="easyui-textbox" type="text" data-options="readonly: true" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>数量:</td>
	    			<td>
	    			<input id="book_num" style="width: 200px; height: 26px;" class="easyui-textbox" type="text"  data-options="readonly: true"/>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>图书价格:</td>
	    			<td>
	    			<input id="book_price" style="width: 200px; height: 26px;" class="easyui-textbox" type="text"  data-options="readonly: true" />
	    			</td>
	    		</tr>
	    	</table>
		</table>
	</div>
	<!-- 添加借阅窗口 -->
	<div id="borrowDialog" style="padding: 10px">
		<form id="borrowForm">
			<table cellpadding="8" >
		    		<tr>
		    			<td>图书编号:</td>
		    			<td><input id="b_bookId" style="width: 200px; height: 25px;" class="easyui-textbox" name="name" data-options="readonly: true" /></td>
		    		</tr>
		    		<tr>
		    			<td>图书类别编号:</td>
		    			<td>
		    			<input id="b_type"  class="easyui-textbox" name="name"  data-options="readonly: true"/>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td>读者编号:</td>
		    			<td>
		    			<input id="b_readerId" style="width: 200px; height: 26px;" class="easyui-textbox"  name="name" data-options="required:true, missingMessage:'请填写读者编号'" />
		    			</td>
		    		</tr>
		    		<tr>
		    			<td>管理员编号:</td>
		    			<td>
		    			<input id="b_empId" style="width: 200px; height: 26px;" class="easyui-textbox"  name="name" data-options="readonly: true" />
		    			</td>
		    		</tr>
		    	</table>
	    	</form>
	</div>
</body>
</html>
