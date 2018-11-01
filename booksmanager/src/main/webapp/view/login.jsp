<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="shortcut icon" href="favicon.ico"/>
<link rel="bookmark" href="favicon.ico"/>
<link href="h-ui/css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="h-ui/css/H-ui.login.css" rel="stylesheet" type="text/css" />
<link href="h-ui/lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
<link href="h-ui/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">

<script type="text/javascript" src="easyui/jquery.min.js"></script> 
<script type="text/javascript" src="h-ui/js/H-ui.js"></script> 
<script type="text/javascript" src="h-ui/lib/icheck/jquery.icheck.min.js"></script> 

<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>

<script type="text/javascript">
	$(function(){
		
		//登录
		$("#submitBtn").click(function(){
			
			var data = $("#form").serialize();
			$.ajax({
				type: "post",
				url: "${pageContext.request.contextPath}/emp/login.do",
				data: data, 
				success: function(msg){
					if(msg.msg=="loginError"){
						$.messager.alert("消息提醒", "用户名或密码错误!", "warning");
					} else if(msg.msg=="admin"){
						window.location.href = "${pageContext.request.contextPath}/emp/admin.do";
					} else if(msg.msg=="Sadmin"){
						window.location.href = "${pageContext.request.contextPath}/emp/Sadmin.do";
					} else if(msg.msg=="manager"){
						window.location.href = "${pageContext.request.contextPath}/emp/manager.do";
					} else if(msg.msg=="boss"){
						window.location.href = "${pageContext.request.contextPath}/emp/boss.do";
					}
				}
				
			});
		});
		
		//设置复选框
		$(".skin-minimal input").iCheck({
			radioClass: 'iradio-blue',
			increaseArea: '25%'
		});
	})
</script> 
<title>登录|图书成绩管理系统</title>
<meta name="keywords" content="图书成绩管理系统">
</head>
<body>

<div class="header" style="padding: 0;">
	<h2 style="color: white; width: 400px; height: 60px; line-height: 60px; margin: 0 0 0 30px; padding: 0;">图书管理系统</h2>
</div>
<div class="loginWraper">
  <div id="loginform" class="loginBox">
    <form id="form" action="url" class="form form-horizontal" method="post">
      <div class="row cl">
        <label class="form-label col-3"><i class="Hui-iconfont">&#xe60d;</i></label>
        <div class="formControls col-8">
          <input id="EmpLoginName" name="EmpLoginName" type="text" placeholder="账户" class="input-text size-L">
        </div>
      </div>
      <div class="row cl">
        <label class="form-label col-3"><i class="Hui-iconfont">&#xe60e;</i></label>
        <div class="formControls col-8">
          <input id="EmpLoginPwd" name="EmpLoginPwd" type="password" placeholder="密码" class="input-text size-L">
        </div>
      </div>
     
      
      <div class="mt-20 skin-minimal" style="text-align: center;">
		<div class="radio-box">
			<input type="radio" id="radio-1" name="type" checked value="1" />
			<label for="radio-1">普通管理员</label>
		</div>
		<div class="radio-box">
			<input type="radio" id="radio-2" name="type" value="2" />
			<label for="radio-2">高级管理员</label>
		</div>
		<div class="radio-box">
			<input type="radio" id="radio-3" name="type" value="3" />
			<label for="radio-3">采购经理</label>
		</div>
		<div class="radio-box">
			<input type="radio" id="radio-4" name="type" value="4" />
			<label for="radio-4">馆长</label>
		</div>
	</div>
      
      <div class="row">
        <div class="formControls col-8 col-offset-3">
          <input id="submitBtn" type="button" class="btn btn-success radius size-L" value="&nbsp;登&nbsp;&nbsp;&nbsp;&nbsp;录&nbsp;">
        </div>
      </div>
    </form>
  </div>
</div>
<div class="footer">Copyright &nbsp; Ambow @ FengHuang </div>


</body>
</html>