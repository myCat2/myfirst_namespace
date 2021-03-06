<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head id="Head1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>图书管理系统管理员界面</title>
    <link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/themes/icon.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.1.2.2.js"></script>
	<script type="text/javascript" src='${pageContext.request.contextPath}/js/outlook2.js'> </script>
    
    <script type="text/javascript">
    var _menus = {"menus":[
		{"menuid":"1","icon":"icon-sys","menuname":"图书管理",
		  "menus":[
				{"menuid":"11","menuname":"图书列表","icon":"icon-role","url":"${pageContext.request.contextPath}/book/bookList.jsp"},
				{"menuid":"12","menuname":"图书类型","icon":"icon-role","url":"${pageContext.request.contextPath}/book/bookTypeList.jsp"}
				]
		},{"menuid":"2","icon":"icon-sys","menuname":"借阅管理",
			"menus":[
				{"menuid":"21","menuname":"借阅列表","icon":"icon-users","url":"${pageContext.request.contextPath}/view/borrow/borrowManage.jsp"}
				]
		},{"menuid":"5","icon":"icon-sys","menuname":" 读者管理",
			"menus":[
				{"menuid":"51","menuname":"读者列表","icon":"icon-users","url":"${pageContext.request.contextPath}/view/reader/readerInfoMgr.jsp"}
				]
		}
		
]};
        //设置登录窗口
        function openPwd() {
            $('#w').window({
                title: '修改密码',
                width: 300,
                modal: true,
                shadow: true,
                closed: true,
                height: 160,
                resizable:false
            });
        }
        //关闭登录窗口
        function closePwd() {
            $('#w').window('close');
        }
        //修改密码
        function serverLogin() {
            var $newpass = $('#txtNewPass');
            var $rePass = $('#txtRePass');
            
            if ($newpass.val() == '') {
                msgShow('系统提示', '请输入密码！', 'warning');
                return false;
            }
            if ($rePass.val() == '') {
                msgShow('系统提示', '请在一次输入密码！', 'warning');
                return false;
            }
            if ($newpass.val() != $rePass.val()) {
                msgShow('系统提示', '两次密码不一至！请重新输入', 'warning');
                return false;
            }
          
            	 $.post('${pageContext.request.contextPath}/emp/newPwd.do?id=${user.empId }&password=' + $newpass.val(), function(msg) {
                     $newpass.val('');
                     $rePass.val('');
                     $("#w").dialog("close");
                     msgShow('系统提示', '恭喜，密码修改成功！<br>您的新密码为：' + $newpass.val(), 'info');
                 })
        
        }
				
        $(function() {
            openPwd();
            $('#editpass').click(function() {
                $('#w').window('open');
            });
            $('#btnEp').click(function() {
                serverLogin();
            })
			$('#btnCancel').click(function(){closePwd();})
            $('#loginOut').click(function() {
                $.messager.confirm('系统提示', '您确定要退出本次登录吗?', function(r) {
                    if (r) {
                        location.href = '${pageContext.request.contextPath}/emp/loginOut.do';
                    }
                });
            })
        });
    </script>
</head>
<body class="easyui-layout" style="overflow-y: hidden"  scroll="no">
<noscript>
<div style=" position:absolute; z-index:100000; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;">
    <img src="${pageContext.request.contextPath}/images/noscript.gif" alt='抱歉，请开启脚本支持！' />
</div></noscript><!-- url(images/layout-browser-hd-bg.gif) #7f99be repeat-x center 50%; -->
    <div region="north" split="true" border="false" style="overflow: hidden; height: 75px;
        background: url(images/layout-browser-hd-bg.gif) #7f99be repeat-x center 50%;; 
        line-height: 20px;color: #fff; font-family: Verdana, 微软雅黑,黑体">
        <span style="float:right; padding-right:20px;" class="head">欢迎 ${user.empName } <a href="#" id="editpass">修改密码</a> <a href="#" id="loginOut">安全退出</a></span>
        <br/>
        
       <center><img src="${pageContext.request.contextPath}/photo/tomcat1.png" style="float: left;padding-left: 5px;padding-top: 5px;padding-top: 5px;" width="50" height="50" align="absmiddle" > <span style="padding-left:10px; font-size: 24px; "><img src="${pageContext.request.contextPath}/images/blocks.gif" width="30" height="30" align="absmiddle" /> 图书管理系统管理员界面</span></center>
    </div>
    
    <!-- 页尾 -->
    <div region="south" split="true" style="height: 30px; background: #D2E0F2; ">
        <div class="footer">By Happy Wang 技术交流群:帅哥靓女交友群(QQ:810597080) </div>
    </div>
    <!--  导航内容 -->
    <div region="west" hide="true" split="true" title="导航菜单" style="width:180px;" id="west">
		<div id="nav" class="easyui-accordion" fit="true" border="false">
		
				
		</div>

    </div>
    <!-- 主体部分 -->
    <div id="mainPanle" region="center" style="background: #eee; overflow-y:hidden">
        <div id="tabs" class="easyui-tabs"  fit="true" border="false" >
			<div title="欢迎使用" style="padding:20px;overflow:hidden; color:red; " >
				<br/><br/><br/><br/><br/>
				<center><h1 style="font-size:32px; ">欢迎来到图书管理系统</h1></center>
			</div>
		</div>
    </div>
    
    
    <!--修改密码窗口-->
    <div id="w" class="easyui-window" title="修改密码" collapsible="false" minimizable="false"
        maximizable="false" icon="icon-save"  style="width: 300px; height: 150px; padding: 5px;
        background: #fafafa;">
        <div class="easyui-layout" fit="true">
            <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
                <table cellpadding=3>
                    <tr>
                        <td>新密码：</td>
                        <td><input id="txtNewPass" type="Password" class="txt01" /></td>
                    </tr>
                    <tr>
                        <td>确认密码：</td>
                        <td><input id="txtRePass" type="Password" class="txt01" /></td>
                    </tr>
                </table>
            </div>
            <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
                <a id="btnEp" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" >
                    确定</a> <a id="btnCancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)">取消</a>
            </div>
        </div>
    </div>

	<div id="mm" class="easyui-menu" style="width:150px;">
		<div id="mm-tabupdate">刷新</div>
		<div class="menu-sep"></div>
		<div id="mm-tabclose">关闭</div>
		<div id="mm-tabcloseall">全部关闭</div>
		<div id="mm-tabcloseother">除此之外全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-tabcloseright">当前页右侧全部关闭</div>
		<div id="mm-tabcloseleft">当前页左侧全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-exit">退出</div>
	</div>


</body>
</html>