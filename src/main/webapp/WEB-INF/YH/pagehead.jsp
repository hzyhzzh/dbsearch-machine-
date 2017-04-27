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
	width: auto;
	height: 25px;
	line-height: 30px;
	font-size: 13px;
	color: #1C86EE;
	text-align: center;
	background: #fff;
	border-radius: 12px;
	cursor: pointer;
	text-align:center; 
	margin-left:4px; 
	margin-right:4px; 
	vertical-align: middle;
	border:1px solid #1C86EE;
	font-weight:bold
	
}
</style>
</head>

<body>
	<div class="e_top">
			
			<ul>
				<li style="list-type:none;margin:0px;margin-left:100px"><img src="images/logo.png"/></li>
				<li><a id="shouye">网站首页</a></li>
				<li><a id="search">高级搜索</a></li>
				<li><a id="selfanalysis">失效自诊</a></li>
				<li><a id="commoncase">常见案例</a></li>
				<li><a id="upload">上传文档</a></li>
				<li><a id="contactus">联系我们</a></li>
			</ul>
			
		<div class="search">
		<form method="post" action="<spring:url value="/index1"></spring:url>" >
			<input  name="q" title="Search" class="searchinput"
				id="searchinput" onkeydown="if (event.keyCode==13) {}"
				onblur="if(this.value=='')value='- 请输入关键字  -';"
				onfocus="if(this.value=='- 请输入关键字  -')value='';" value="- 请输入关键字  -"
				size="15" /> 
				<input type="image" width="21" height="20"
				class="searchaction" alt="Search"
				src="images/magglass.gif" type="submit" border="0" hspace="2" />
				
		</form>
		</div>
		<div class="e_topnav">
			<ul>
				<li><a id="register">注册</a></li>
				<li><a id="login">登录</a></li>
				<li><a id="vip">充值</a></li>
				<li><a id="userEmail"></a></li>
				<li><a id="gerenzhongxin">个人中心</a></li>
				<li><a id="guanliyuan">管理员中心</a></li>
				<li><a id="logout">退出登录</a></li>
			</ul>
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
			$("#login").show();
			$("#register").show();
			$("#logoutLabel").hide();
			$("#vip").hide();
			$("#gerenzhongxin").hide();
			$("#guanliyuan").hide();
			$("#logout").hide();
			$("#userEmail").hide();
			//*if (loginStatus == "fail") {
				//showLog(true);
			//} else if (loginStatus == "req"){
			//	showLog();
			//}
		} else {
			$("#login").hide();
			$("#register").hide();
			$("#gerenzhongxin").show();
			$("#userEmail").text(userEmail);
			if (userRole == 10){
				$("#guanliyuan").show();
				$("#vip").hide();
				}
			else if(userRole == 1){
				$("#guanliyuan").hide();
				$("#vip").hide();
			}
			else{
				$("#guanliyuan").hide();
				$("#vip").show();
			}
			$("#logout").show();
		}
	});
	$("#shouye").click(function() {
		window.location.href = "/dbsearch/index";
	});
	$("#search").click(function() {
		window.location.href = "/dbsearch/index1";
	});

	$("#selfanalysis").click(function() {
		window.location.href = "/dbsearch/YH/selfanalysis";
	});
	$("#commoncase").click(function() {
		window.location.href = "/dbsearch/wenxian_commoncase";
	});
	$("#upload").click(function() {
		var user = "<%=session.getAttribute("user")%>";
		if(user==null||user=="null"){
			alert("请先登录");
		}else{
			window.location.href = "/dbsearch/WX/wenxian_upload";
		}
	});
	$("#contactus").click(function() {
		alert("请发送邮件至邮箱：failure_analysis@163.com");
	});
	$("#vip").click(function() {
		alert("将在后续版本实现");
	});
	$("#login").click(function() {
		showLog();
	});
	$("#logout").click(function(){
		if(confirm("确定要退出登录吗？"))	{
			window.location.href = "/dbsearch/YH/logout";
		}else{
			return;
		}
	});
	$("#gerenzhongxin").click(function() {
		window.location.href = "/dbsearch/YH/gerenzhongxin";
	});
	$("#guanliyuan").click(function() {
		window.location.href = "/dbsearch/YH/guanliyuan";
	});
	
</script>
</html>
