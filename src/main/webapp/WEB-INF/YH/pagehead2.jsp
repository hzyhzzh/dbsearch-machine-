<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
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

<title>My JSP 'pageHead.jsp' starting page</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8 ">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script src="js/jquery.js"></script>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/index.css" rel="stylesheet" type="text/css" />
<link href="css/admin_login.css" rel="stylesheet" type="text/css" />
<link href="css/other.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.modDiv {
	width: 100%;
	position: fixed;
	top: 0;
	left: 0;
	
	filter:alpha(opacity=10);      /* IE */
    -moz-opacity:0.1;              /* 老版Mozilla */
    -khtml-opacity:0.1;            /* 老版Safari */
    opacity: 0.1;                  /* 支持 opacity的浏览器*/
	
	z-index: 12002;
	background-color: rgb(0, 0, 0);
	font: 20px "微软雅黑", Arial, Helvetica;
}

#denglukuang {
	z-index: 12003;
	width: 400px;
	border: 1px solid rgb(200, 200, 200);
	/* height: 245px; */
	font-size: 14px;
	background-color: rgb(255, 255, 255);
	position: fixed;
	font-size: 12;
}

#login_close {
	position: absolute;
	top: 4px;
	right: 4px;
}

.txtLog {
	border: 1px solid #d3d3d3;
	width: 225px;
	height: 30px;
	line-height:30px;
	border-radius: 4px;
	padding-left: 35px;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	-webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow
		ease-in-out .15s;
	-o-transition: border-color ease-in-out .15s, box-shadow ease-in-out
		.15s;
	transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s
}

.txtLog:focus {
	border-color: #66afe9;
	outline: 0;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075), 0 0 8px
		rgba(102, 175, 233, .6);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075), 0 0 8px
		rgba(102, 175, 233, .6)
}
.clear {
	clear: both;
	height: 1px;
}
.jump-link {
	color: #777;
	text-decoration: none;
	float: left;
	display: inline;
	margin-top: 5px;
}

.submit-btn {
	border: 0 none;
	width: 150px;
	height: 30px;
	line-height: 30px;
	font-size: 16px;
	color: #fff;
	text-align: center;
	background: #4ba0d7;
	border-radius: 3px;
	cursor: pointer;
	vertical-align: middle;
}
</style>
</head>

<body>
	<div class="h_top">
		<div style="width: 1200px; margin: 0 auto;">
			<div style="float: left; font-size: 12;">
				<span>欢迎使用失效案例分析系统</span>
			</div>
			<div style="float: right; font-size: 12;">
				<span id="userEmail"></span> <span id="up2vip" onclick="applyForVip();">充值 &nbsp;|&nbsp; </span><span
					id="a_gerenzhongxin">个人中心</span> &nbsp;|&nbsp; <span
					id="a_guanliyuan" style="display: none;">管理员中心&nbsp;|&nbsp;</span> <span id="a_shangchuan">上传文档</span>
				&nbsp;|&nbsp; <span id="loginLabel" onclick="showLog()">登录</span> <span
					id="logoutLabel">退出登录</span>
			</div>
		</div>
	</div>
	<div class="modDiv" id="mod_toumingceng" style="display: none;"></div>
	
	<div id="denglukuang" style="display: none;">
		<div id="LogDiv"
			style="margin-left: 50px; margin-right: 50px; background: rgb(255, 255, 255)">
			<form id="loginForm"
				action="<spring:url value="/YH/login"></spring:url>" method="post"
				class="form-horizontal">
				<table style="width: 100%; margin-top: 20px;">
					<tr id="loginErrorMsg">
						<td colspan="2" align="center"><span id="password.errors"
							style="color: red;">用户名或密码错误</span></td>
					</tr>
					<tr style="height: 50px;">
						<td width="70%" height="35"><label> <input
								type="text" id="email" name="email" class="txtLog"
								placeholder="请输入邮箱"></input></label></td>
						<td width="30%" height="35" align="right"><a
							class="jump-link" target="_blank" tabindex="3" href="YH/register">立即注册</a>
						</td>
					</tr>
					<tr style="height: 50px;">
						<td width="70%" height="35"><label><input
								type="password" id="password" name="password" class="txtLog"
								placeholder="请输入密码"></input> </label></td>
						<td width="30%" height="35" align="right"><a
							class="jump-link" target="_blank" tabindex="3" href="YH/forgetPass">忘记密码</a></td>
					</tr>
					<tr style="height: 50px;">
						<td colspan="2" align="center"><input class="submit-btn"
							value="登录" type="submit"></td>
					</tr>
				</table>
			</form>
			<div id="login_close">
				<img src="images/delete.png" width="16" height="16" border="0"
					onclick="hideLog()">
			</div>
		</div>
		</div>
		





</body>
<script type="text/javascript">
	/*$("#a_shouye").click(function() {
		window.location.href = "/dbsearch/index";
	});
	$("#a_zhuce").click(function() {
		window.location.href = "/dbsearch/YH/register";
	});*/
	$("#a_gerenzhongxin").click(function() {
		window.location.href = "/dbsearch/YH/gerenzhongxin";
	});
	$("#a_guanliyuan").click(function() {
		window.location.href = "/dbsearch/YH/guanliyuan";
	});
	$("#a_shangchuan").click(function() {
		var user = "<%=session.getAttribute("user")%>";
		if(user==null||user=="null"){
			showLog();
		}else{
			window.location.href = "/dbsearch/WX/wenxian_upload";
		}
	});
	$("#logoutLabel").click(function() {
		if(confirm("确定要退出登录吗？"))	{
			window.location.href = "/dbsearch/YH/logout";
		}else{
			return;
		}
	});

	$(document).ready(function () {
		var winWidth;// 获取窗口宽度
		var winHeight;// 获取窗口高度
		// 获取窗口宽度
		if (window.innerWidth)
			winWidth = window.innerWidth;
		else if ((document.body) && (document.body.clientWidth))
			winWidth = document.body.clientWidth;
		// 获取窗口高度
		if (window.innerHeight)
			winHeight = window.innerHeight;
		else if ((document.body) && (document.body.clientHeight))
			winHeight = document.body.clientHeight;
		// 通过深入 Document 内部对 body 进行检测，获取窗口大小
		if (document.documentElement && document.documentElement.clientHeight
				&& document.documentElement.clientWidth) {
			winHeight = document.documentElement.clientHeight;
			winWidth = document.documentElement.clientWidth;
		}
		document.getElementById("mod_toumingceng").style.height = winHeight;//透明层高度控制
		document.getElementById("denglukuang").style.left = winWidth / 2 - 200;//弹出登录框位置控制
		document.getElementById("denglukuang").style.top = 150;
	});

	function showLog(isMsg) {
		document.getElementById("mod_toumingceng").style.display = "block";
		document.getElementById("denglukuang").style.display = "block";
		if(isMsg)
			$("#loginErrorMsg").show();
		else
			$("#loginErrorMsg").hide();
	}
	function hideLog() {
		document.getElementById("mod_toumingceng").style.display = "none";
		document.getElementById("denglukuang").style.display = "none";
	}
	function applyForVip(){
		$.get("ajax/getAdminEmail", function(data,status){
			alert('请联系管理员！'+data)
		})
	}
	$(document).ready(function (){
	var userEmail = "<%=session.getAttribute("user")%>";
	var userRole = "<%=session.getAttribute("userRole")%>";
	var loginStatus = "<%=request.getAttribute("loginStatus")%>";
		if (userEmail == "null") {
			$("#loginLabel").show();
			$("#logoutLabel").hide();
			$("#userEmail").text("");
			if (loginStatus == "fail") {
				showLog(true);
			} else if (loginStatus == "req"){
				showLog();
			}
		} else {
			$("#loginLabel").hide();
			$("#logoutLabel").show();
			$("#userEmail").text(userEmail + "  |  ");
			if (userRole == 10){
				$("#a_guanliyuan").show();
				$("#up2vip").hide();}
			else if(userRole == 1){
				$("#a_guanliyuan").hide();
				$("#up2vip").hide();
			}
			else{
				$("#a_guanliyuan").hide();
				$("#up2vip").show();
			}
		}
	});
	
	
</script>
</html>
