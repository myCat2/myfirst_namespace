<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"//"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/echarts.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.4.min.js"></script>
</head>
<body>
<div id="dy"  style="height: 600px;width: 1100px;margin-top: 50px;margin-left:20px;">
    <div id="mainChart" style="border: 1px solid #438FB9; width:100%; height:45%;"></div>
</div>
</body>
<script type="text/javascript">
    //使用ajax加载数据 
    $.ajax({
        method:'post',
        url:'${pageContext.request.contextPath}/emp/EntryDate.do',
        dataType:'json',
        success:function(data){
            initChat(data);
        }
    }); 
    function initChat(data){
    var myChart = echarts.init(document.getElementById('mainChart'));
    option = {
    	    title : {
    	    	text: '员工入职时间统计',
                subtext: '内部数据',
    	    },
    	    tooltip : {
    	        trigger: 'axis'
    	    },
    	    legend: {
    	        data:data
    	    },
    	    toolbox: {
    	        show : true,
    	        feature : {
    	            mark : {show: true},
    	            dataView : {show: true, readOnly: false},
    	            magicType : {show: true, type: ['line', 'bar']},
    	            restore : {show: true},
    	            saveAsImage : {show: true}
    	        }
    	    },
    	    calculable : true,
    	    xAxis : [
    	        {
    	            type : 'category',
    	            data : ['7月','8月','9月','11月']
    	        }
    	    ],
    	    yAxis : [
    	        {
    	            type : 'value'
    	        }
    	    ],
    	    series : [
    	        {
    	            name:'入职员工人数',
    	            type:'bar',
    	            data:data,
    	            markPoint : {
    	                data : [
    	                    {type : 'max', name: '入职高峰期'},
    	                ]
    	            },
    	        }
    	    ]
            },
                    myChart.setOption(option);
    };
</script>
</html>