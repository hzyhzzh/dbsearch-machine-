<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="dbsearch.service.impl.*"%>
<%@ page language="java" import="dbsearch.domain.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>个人中心</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="shortcut icon" href="images/tablogo.ico" type="image/x-icon" />
<script src="js/jquery.js"></script>
<script src="js/jquery.min.js"></script>
<link href="css/center.css" rel="stylesheet" type="text/css" />
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/index.css" rel="stylesheet" type="text/css" />

<style type="text/css">
body{
text-align:center;
}
.span_title{
color:#fff;
font-size:14px;
font-weight:bold;
}
.menu_grzx {
	font-family: 综艺体;
	font-size: 16px;
	width: 20%;
	float: left;
	height:800px;
	margin-right: 50px;
	margin-bottom: 50px;
	background:#fff;
}

.tab {
	cursor:pointer;
}
.current{
	color: #333;
	font-weight: 700
}
.hide{display:none}
.tab-sp {
	width: 1px;
	height: 14px;
	overflow: hidden;
	vertical-align: bottom;
	background: #dbdcde;
	position: absolute;
	top: 1px;
	*top: 7px;
	left: 82px
}


H1, h2, h3, h4 {
	font-size: 18px;
	font-weight: bold;
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

.jc_line {
	width: 100%;
	border-bottom: 1px solid #ccc;
	margin-bottom: 10px;
}

.menu_sub {
	height: 50px;
	width: auto;
	line-height: 50px;
	border: solid 1px rgb(200, 200, 200);
	background:url(images/doc_ico.png) no-repeat  20% 50% ;
	cursor: pointer;
}
.menu_sub_pass {
	height: 50px;
	width: auto;
	line-height: 50px;
	border: solid 1px rgb(200, 200, 200);
	background:url(images/pass_ico.png) no-repeat 20% 50% ;
	cursor: pointer;
}

.grxx_main {
	font-family: 微软雅黑;
	font-size: 16px;
	width: 75%;
	float: right;
	background-color: rgb(255, 255, 255);
	border: solid 1px rgb(200, 200, 200);
	margin-bottom: 20px;
}

.tab {
	background-color: #FFF;
	padding: 4px;
	width: 100%;
	text-align:left;
	margin-left:5px;
}

.tab tr th {
	padding: 5px;
	line-height: 30px;
	background-color: #e4ecf8;
	font-weight: normal;
	color: #1a87bb;
	text-align: left;
	text-indent: 10px;
	border: 1px solid #e4ecf8;
}

.tab tr td {
	padding: 5px;
	text-align: left;
	text-indent: 10px;
	line-height: 30px;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #ececec;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #ececec;
}

.t1 {
	clear: both;
	border: 1px solid #c9dae4;
}

.t1 tr {
	height: 50px;
}

.t1 tr th {
	
	line-height: 50px;
	border-bottom: 1px solid #9cb6cf;
	border-top: 1px solid #e9edf3;
	font-weight: normal;
	text-shadow: #e6ecf3 1px 1px 0px;
	padding-left: 10px;
	padding-right: 10px;
}

.t1 tr td {
	border-bottom: 1px solid #e9e9e9;
	padding-bottom: 5px;
	padding-top: 5px;
	color: #444;
	border-top: 1px solid #FFFFFF;
	padding-left: 10px;
	padding-right: 10px;
	word-break: break-all;
}

.textfield {
	color: #333333;
	background-color: #FFF;
	height: 33px;
	width: 318px;
	border: 1px solid #dddada;
	padding-left: 15px;
}
</style>
</head>

<body>
	<div class="div_head_container">
		<jsp:include page="./pagehead.jsp" flush="true" />
	</div>
	<div class="clear"></div>
	<div
		style="width: 1200px; height: auto; margin: 0 auto; min-height: 800px;">
		<div id="wrapper">
			<div class="menu_grzx">
				<div id="menu_sub_sc" class="menu_sub" onclick="sc()">
					<span class="menu_sub_span">我的文档</span>
				</div>
			<!--  <div id="menu_sub_tjfx" class="menu_sub">
					<span class="menu_sub_span">统计分析</span>
				</div>-->	
				<div id="menu_sub_reset" class="menu_sub_pass">
					<span class="menu_sub_span">密码修改</span>
				</div>
			</div>
			<!-- 个人信息 -->
			<div class="grxx_main">
				<div id="estates"
					style="width: 47%; float: left; padding-left: 10px; margin-right: 10px; text-align: left; border-right: 1px solid #C9C9C9">
					<div style="width:100%;height:40px;text-align:center;float:center;margin-top:5px;">
						<div style="background:url(images/duandai.png) no-repeat;width:30%;height:40px;margin:0 auto;">
						<span class="span_title">我的资产</span>
						</div>
					</div>
					<div id="left_block" style="width: 45%; float: left;">
						<p style="color: #EE3B3B">0</p>
						<p>文档数</p>
					</div>
					<div id="right_block" style="width: 45%; float: right;">
						<%
							User user= (User)request.getAttribute("user");
						%>
						<p style="color: #EE3B3B">${user.getScore()}</p>
						<p>财富值</p>
					</div>
				</div>
				<div style="width:50%;float: left;text-align: left;">
				<div style="width:100%;height:40px;text-align:center;float:center;margin-top:5px;">
						<div style="background:url(images/duandai.png) no-repeat;width:30%;height:40px;margin:0 auto;">
						<span class="span_title">最近下载</span>
						</div>
					</div>
				
				<span>无</span>
				</div>
				</div>
				<!--个人信息结束-->
			</div>
			<div class="grxx_main">
				<div id="grxx_main_reset" style="display: none;">
					<form id="loginForm" action="YH/resetPassword" method="post"
						class="form-horizontal">
						<table class="t1" style="width: 100%;">
							<tr>
								<th colspan="2">修改密码</th>
							</tr>
							<tr>
								<td width="35%" align="right">输入新密码：</td>
								<td width="65%"><label> <input id="upassword"
										name="password" type="password" class="textfield"
										required="required"></input>
								</label></td>
							</tr>
							<tr>
								<td width="35%" align="right">确认密码：</td>
								<td width="65%"><label><input id="password2"
										type="password" class="textfield" placeholder="两次输入的密码需一致"></input>
								</label></td>
							</tr>
						</table>
						<div style="padding: 15px;">
							<input type="submit" value="确定" class="submit-btn"
								onclick="checkPasswords()">
						</div>
					</form>
				</div>

				<div id="grxx_main_sc" style=""></div>
				<div id="grxx_main_success" style="display: none;">
					<label>密码修改成功</label>
				</div>
			</div>
		</div>
	</div>
	<div style="clear: both;"></div>
	<div class="div_foot_container">
		<jsp:include page="./pagefoot.jsp" flush="true" />
	</div>
</body>
<script type="text/javascript">
	var urlSection = "<%=request.getParameter("section")%>";
	if(urlSection == "null")
		urlSection = "grxx_main_sc";
	function checkPasswords() {
		var pass1 = document.getElementById("upassword");
		var pass2 = document.getElementById("password2");
		if (pass1.value != pass2.value)
			pass2.setCustomValidity("两次输入的密码不匹配");
		else
			pass2.setCustomValidity("");
	}
	var sectionList = new Array("grxx_main_reset","grxx_main_sc","grxx_main_success")
	function showSection(sectionName){
		for(var index in sectionList){
			document.getElementById(sectionList[index]).style.display = "none";
		}
		document.getElementById(sectionName).style.display = "block";
	}
	$("#menu_sub_reset").click(function() {
		showSection("grxx_main_reset");
	});
	$(document).ready(function (){
		if(urlSection == "grxx_main_success")
		showSection(urlSection);
		else if(urlSection == "grxx_main_reset")
			$("#menu_sub_reset").click();
		else if(urlSection == "grxx_main_sc")
			$("#menu_sub_sc").click();
	})
	function sc(){//查看我的上传记录
		showSection("grxx_main_sc");
		var url = "/dbsearch/YH/wenxian_list_gr";
		var data = {
			operRole:"",
			strSearch:"",
			cateId:"",
			pageIndex:1
		};
		$.ajax({
			type : "post",
			async : false, //同步请求
			url : url,
			data : data,
			success : function(dates) {
				$("#grxx_main_sc").html(dates);//要刷新的div
			},
			error : function() {
				alert("失败，请稍后再试！");
			}
		});
	}
	function tjfx(){//查看我的上传记录
		showSection("grxx_main_sc");
		var url = "/dbsearch/YH/grtjfx";
		var data = {
			
		};
		$.ajax({
			type : "post",
			async : false, //同步请求
			url : url,
			data : data,
			success : function(dates) {
				$("#grxx_main_sc").html(dates);//要刷新的div
			},
			error : function() {
				alert("失败，请稍后再试！");
			}
		});
	}
	$("#menu_sub_sc").click(function() {
		$("#menu_sub_sc").css("backgroundColor","rgb(80,80,80)");
		$("#menu_sub_sc").css("color","rgb(255,255,255)");
		$("#menu_sub_reset").css("backgroundColor","rgb(255,255,255)");
		$("#menu_sub_reset").css("color","rgb(0,0,0)");
		$("#menu_sub_tjfx").css("backgroundColor","rgb(255,255,255)");
		$("#menu_sub_tjfx").css("color","rgb(0,0,0)");
	});
	$("#menu_sub_reset").click(function() {
		$("#menu_sub_reset").css("backgroundColor","rgb(80,80,80)");
		$("#menu_sub_reset").css("color","rgb(255,255,255)");
		$("#menu_sub_sc").css("backgroundColor","rgb(255,255,255)");
		$("#menu_sub_sc").css("color","rgb(0,0,0)");
		$("#menu_sub_tjfx").css("backgroundColor","rgb(255,255,255)");
		$("#menu_sub_tjfx").css("color","rgb(0,0,0)");
		
	});
	$("#menu_sub_tjfx").click(function() {

		var userRole = "<%=session.getAttribute("userRole")%>";
		if(userRole=="0"){
			alert("该功能仅限会员用户使用！");
		}else{
			$("#menu_sub_tjfx").css("backgroundColor","rgb(80,80,80)");
			$("#menu_sub_tjfx").css("color","rgb(255,255,255)");
			$("#menu_sub_reset").css("backgroundColor","rgb(255,255,255)");
			$("#menu_sub_reset").css("color","rgb(0,0,0)");
			$("#menu_sub_sc").css("backgroundColor","rgb(255,255,255)");
			$("#menu_sub_sc").css("color","rgb(0,0,0)");
			tjfx();
		}
	});

</script>
</html>
