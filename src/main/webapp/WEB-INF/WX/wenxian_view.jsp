<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@	taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@	taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" import="dbsearch.domain.Paper"%>
<%@ page language="java" import="dbsearch.service.impl.UserService"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>文档预览</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8 ">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script src="js/jquery.js"></script>
<script src="js/jquery.min.js"></script>
<link rel="shortcut icon" href="images/tablogo.ico" type="image/x-icon" />
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/index.css" rel="stylesheet" type="text/css" />
<style type="text/css">
#up_adv {
	width: 100%;
	padding-top: 15px;
	background: #fff;
	font-size: 14px;
	border: 1px solid rgb(200, 200, 200);
}
.hfont{
    color:#000;
    font-weight:bold;
}
.up_adv_hatr {
	margin-bottom: 20px;
}

.up_adv_label {
	width: 30%;
	text-align: right;
	display: inline-block;
	padding-right: 15px;
	font-size: 16px;
}

.up_input {
	background: #fff;
	width: 500px;
	height: 28px;
}

.up_textarea {
	background: #fff;
	width: 500px;
	height: 120px;
}

.up_select {
	background: #fff;
	width: 200px;
	height: 28px;
	margin-right: 30px;
}

.cjsx {
	height: 50px;
	line-height: 50px;
	color: #0269b4;
	font-weight: bold;
	margin-top: 15px;
	font-size: 25px;
	font-family: "Lucida Console", Monaco, monospace, "微软雅黑";
	text-align: center;
}

.file-box {
	position: relative;
	width: 340px
}

.txt {
	height: 22px;
	border: 1px solid rgb(200, 200, 200);
	width: 180px;
}

.btn {
	background-color: #FFF;
	border: 1px solid rgb(200, 200, 200);
	height: 24px;
	width: 70px;
}

.file {
	position: absolute;
	top: 0;
	right: 80px;
	height: 24px;
	filter: alpha(opacity : 0);
	opacity: 0;
	width: 260px
}

.btn_submit {
	width: 150px;
	height: 34px;
	color: white;
	padding-top: 2px \9;
	font-size: 15px;
	letter-spacing: 1px;
	background-color: #38f;
	border: none;
	outline: medium;
	cursor: pointer;
}

td {
	padding-top: 30px;
	padding-bottom: 30px;
	border-bottom: solid 1px #EEE;
	line-height: 30px;
}

.warn {
	width: 100%;
	height: 30px;
	color: #F00;
	text-align: left;
	line-height: 30px;
	padding-left: 20px;
}


</style>
</head>

<body>
	<div class="div_head_container">
		<jsp:include page="../YH/pagehead.jsp" flush="true" />
	</div>
	<div style=" padding-top:20px; margin:0 auto 20px auto;">
		<div style="background:url(images/commoncase_title.png)no-repeat;width:319px;height:75px;margin:0 auto;">
			<span style="color:white;font-size:37px;font-weight:bold;line-height:55px">文档预览</span>
		</div>
	</div>
	<div
		style="width: 1200px; height: auto; min-height: 800px; margin: 0 auto;">
		<div id="wrapper">
			<div id="up_adv">
				<%
					Paper paper = (Paper) request.getAttribute("paper");
				%>
				<table
					style="border-collapse:separate;border-spacing:10px; width: 80%;pxborder: none; margin: auto; table-layout: fixed; word-wrap: break-word;">
					<tr >
						<td style="padding-bottom:5px;padding-top:5px;font-weight: bold; width: 30%; text-align: right">事故名称：</td>
						<td style="padding-bottom:5px;padding-top:5px;padding-left: 20px;padding-right: 10px;text-align: left;">
							${paper.accidentName }</td>
						
					</tr>
					<!--  <tr style="margin-bottom: 20px;">
						<td style="font-weight: bold; width: 30%; text-align: right">事故时间：</td>
						<td style="padding-left: 20px; padding-right: 50px;">
							${paper.accidentTime }</td>
					</tr>
					<tr style="margin-bottom: 20px;">
						<td style="font-weight: bold; width: 30%; text-align: right">事故地点：</td>
						<td style="padding-left: 20px; padding-right: 50px;">
							${paper.accidentLocation }</td>
					</tr>
					<tr style="margin-bottom: 20px;">
						<td style="font-weight: bold; width: 30%; text-align: right">产品制造商信息：</td>
						<td style="padding-left: 20px; padding-right: 50px;">
							${paper.productor }</td>
					</tr>-->
					<tr >
						<td style="padding-bottom:5px;padding-top:5px;font-weight: bold; width: 30%; text-align: right">失效设备：</td>
						<td style="padding-bottom:5px;padding-top:5px;padding-left: 20px; padding-right: 50px;">
							${paper.failureEquipment }</td>
					</tr>
					<tr >
						<td style="padding-bottom:5px;padding-top:5px;font-weight: bold; width: 30%; text-align: right">失效部件：</td>
						<td style="padding-bottom:5px;padding-top:5px;padding-left: 20px; padding-right: 50px;">
							${paper.failureComponent }</td>
					</tr>
				<!-- 	<tr style="margin-bottom: 20px;">
						<td style="font-weight: bold; width: 30%; text-align: right">应用环境：</td>
						<td style="padding-left: 20px; padding-right: 50px;">
							${paper.applyEnv }</td> 
					</tr> -->
					<tr>
						<td style="padding-bottom:5px;padding-top:5px;font-weight: bold; width: 30%; text-align: right">失效形式：</td>
						<td style="padding-bottom:5px;padding-top:5px;padding-left: 20px; padding-right: 50px;">
							${paper.failureBehave }</td>
					</tr>
					<tr >
						<td style="padding-bottom:5px;padding-top:5px;font-weight: bold; width: 30%; text-align: right">失效机理：</td>
						<td style="padding-bottom:5px;padding-top:5px;padding-left: 20px; padding-right: 50px;">
							<%-- 							${paper.failureCause } --%> ${paper.failureCause }
						</td>
					</tr>
					<!--<tr style="margin-bottom: 20px;">
						<td style="font-weight: bold; width: 30%; text-align: right">失效材料类型：</td>
						<td style="padding-left: 20px; padding-right: 50px;">
							${paper.failureMaterial }</td>
					</tr>
					<tr style="margin-bottom: 20px;">
						<td style="font-weight: bold; width: 30%; text-align: right">失效材料信息：</td>
						<td style="padding-left: 20px; padding-right: 50px;">
							${paper.materialInfo }</td>
					</tr>-->
					<tr >
						<td style="padding-bottom:5px;padding-top:5px;font-weight: bold; width: 30%; text-align: right">事故概览：</td>
						<td style="padding-bottom:5px;padding-top:5px;padding-left: 20px; padding-right: 50px;">
							${paper.accidentDescription }</td>
					</tr>
					<!--  <tr style="margin-bottom: 20px;">
						<td style="font-weight: bold; width: 30%; text-align: right">分析总结：</td>
						<td style="padding-left: 20px; padding-right: 50px;">
							${paper.analyseConclusion }</td>
					</tr>  -->
				</table>
				<span style="color:grey;font-weight:bold;">如果想了解案例更多内容，请下载全文</span>
				<div
					style="width: 100%; margin: 0 auto; padding-top: 20px; padding-bottom: 30px;">
					<input type="hidden" id="filePath" value="${paper.id }"> <input
						type="button" name="submit" class="submit-btn" value="下载全文"
						onclick="chakanquanwen()" />
				</div>
				<div id="errorInfo" class="warn">${errorInfo }</div>
			</div>
		</div>
	</div>
	<div style="clear: both;"></div>
	<div class="div_foot_container">
		<jsp:include page="../YH/pagefoot.jsp" flush="true" />
	</div>
</body>
<script type="text/javascript">
function chakanquanwen(){
	var user = "<%=session.getAttribute("user")%>";
		if (user == null || user == "null") {
			showLog();
		} else {
			window.open("showPdf?paperId=" + $("#filePath").val());
		}
	}
</script>
</html>
