<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@	taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@	taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>分析</title>
<link rel="shortcut icon" href="images/tablogo.ico" type="image/x-icon" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script src="js/jquery.js"></script>
<script src="js/echarts.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var url =  "analysis";
		var data = {
			failureEquipment:$("#failureEquipment").val(),
			failureComponent:$("#failureComponent").val(),
			failureMaterial:$("#failureMaterial").val(),
			cateId:$("#category").val(),
			gjcStr:$("#gjcStr").val()
		};
		$.ajax({
			type : "post",
			async : false, //同步请求
			url : url,
			data : data,
			success : function(fields) {
				for( var fieldIndex in fields) {
					var field = fields[fieldIndex];
					
					if(field["data"].length==1)//有一类字段都没选中
						continue;
						
					var newElement = $("<div>123</div>").attr({
						"id" : field["name"],
						"style" : "width: 600px;height:400px;"
					});
					$("#main_chart").append(newElement);
					var legendData = new Array();
					var seriesData = new Array();
					for ( var keywordIndex in field["data"]) {//一类中的关键词
						keyword = field["data"][keywordIndex];
						legendData.push(keyword["keyword"]);	
						seriesData.push({
							"name" : keyword["keyword"],
							"value" : keyword["amount"]
						});
					}
					var myChart = echarts.init(document.getElementById(field["name"]));
					option = {
						title : {
							text : field["title"],
							field : field["name"],
// 	 						subtext : '纯属虚构',
							x : 'center'
						},
						tooltip : {
							trigger : 'item',
							formatter : "{a} <br/>{b} : {c} ({d}%)"
						},
						legend : {
							orient : 'vertical',
							left : 'left',
							data : legendData
						},
						series : [ {
							name : '',
							type : 'pie',
							radius : '55%',
							center : [ '50%', '60%' ],
							data : seriesData,
							itemStyle : {
								emphasis : {
									shadowBlur : 10,
									shadowOffsetX : 0,
									shadowColor : 'rgba(0, 0, 0, 0.5)'
								}
							}
						} ]
					};
					myChart.setOption(option);
					myChart.on("click",function (param){
						var fName = option.title.field;
						var keyw = param.name;
// 	 					window.open("search");
					})
				}
			},
			error : function() {
				
			}
		});
	})
</script>
</head>

<body>
	<div style="display:none;">
		<input id="failureEquipment" value="<%=request.getParameter("failureEquipment")%>">
		<input id="cateId" value="<%=request.getParameter("cateId")%>">
		<input id="failureComponent" value="<%=request.getParameter("failureComponent")%>">
		<input id="failureMaterial" value="<%=request.getParameter("failureMaterial")%>">
		<input id="gjcStr" value="<%=request.getParameter("gjcStr")%>">
	</div>
	<div id="main_chart"></div>
</body>
</html>
