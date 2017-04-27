<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

<title>注册</title>
<link rel="shortcut icon" href="images/tablogo.ico" type="image/x-icon" />
<link href="css/index.css" rel="stylesheet" type="text/css" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<STYLE>
.top_h {
	height: 50px;
	line-height: 50px;
	color: #0269b4;
	font-weight: bold;
	margin-top: 15px;
	font-size: 25px;
	font-family: "Lucida Console", Monaco, monospace, "微软雅黑";
	text-align: center;
}

.body_div {
	background: rgb(255, 255, 255);
	margin: 0 auto auto;
	border: 1px solid rgb(231, 231, 231);
	border-image: none;
	width: 840px;
	height: 450px;
	text-align: center;
	padding-left: 60px;
	padding-right: 60px;
	margin-bottom: 50px;
}

.tab {
	margin-top: 20px;
	background-color: #FFF;
	border: 1px solid #cbcbcb;
	padding: 4px;
	width: 100%;
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
	font-size: 12px;
}

.textfield {
	color: #333333;
	background-color: #FFF;
	height: 33px;
	width: 318px;
	border: 1px solid #dddada;
	padding-left: 15px;
}

.redstar {
	color: red;
	position: relative;
	padding-left: 15px;
}
</STYLE>
</head>

<body>
	<div class="div_head_container">
		<jsp:include page="./pagehead.jsp" flush="true" />
	</div>
	<div id="wrapper">
		<DIV class="top_div"></DIV>
		<form:form modelAttribute="newUser" id="form1" class="form-horizontal">
			<DIV class="body_div">
				<h1 class="top_h">新用户注册</h1>
				<table class="tab">
					<tr>
						<td width="25%" align="right">邮箱：</td>
						<td width="75%"><label> <form:input id="uemail"
									path="email" class="textfield"></form:input><form:errors
									path="email" cssClass="text-danger" /><span class='redstar'>*</span></label></td>
					</tr>
					<tr>
						<td width="25%" align="right">密码：</td>
						<td width="75%"><label> <form:input id="upassword"
									path="password" type="password" class="textfield"></form:input><form:errors
									path="password" cssClass="text-danger" /><span
								class='redstar'>*</span>
						</label></td>
					</tr>
					<tr>
						<td width="25%" align="right">确认密码：</td>
						<td width="75%"><label><input id="password2"
								type="password" class="textfield" placeholder="两次输入的密码需一致"></input><span class='redstar'>*</span>
						</label></td>
					</tr>
				</table>
				<DIV
					style="height: 15px; line-height: 15px; margin-top: 30px; border-top-color: rgb(231, 231, 231); border-top-width: 1px; border-top-style: solid;">

				</DIV>
				<div>
					<input type="submit" value="注册" class="s_btn"
						onclick="checkPasswords()">
				</div>
			</DIV>
		</form:form>
	</div>
	<div style="clear: both;"></div>
	<div class="div_foot_container">
		<jsp:include page="./pagefoot.jsp" flush="true" />
	</div>
</body>
<script type="text/javascript">
	function checkPasswords() {
		var pass1 = document.getElementById("upassword");
		var pass2 = document.getElementById("password2");
		if (pass1.value != pass2.value)
			pass2.setCustomValidity("两次输入的密码不匹配");
		else
			pass2.setCustomValidity("");
	}
</script>
</html>
