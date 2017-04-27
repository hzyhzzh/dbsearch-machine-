<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@	taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@	taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ page language="java" import="dbsearch.service.impl.CategoryService"%>
<%@ page language="java" import="dbsearch.domain.Category"%>
<%@ page language="java" import="dbsearch.service.impl.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>管理员中心</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="shortcut icon" href="images/tablogo.ico" type="image/x-icon" />
<link href="css/css.css" rel="stylesheet" type="text/css" />

<link href="css/mricode.pagination.css" rel="stylesheet" />
<style type="text/css">
.bar {
    height: 18px;
    background: green;
}
.menu_gly {
	font-family: 综艺体;
	font-size: 16px;
	width: 20%;
	float: left;
	margin-right: 10px;
	margin-bottom: 50px;
}

.menu_sub {
	height: 50px;
	width: auto;
	line-height: 50px;
	border: solid 1px rgb(200, 200, 200);
	background-color: rgb(255, 255, 255);
	cursor: pointer;
	margin-bottom: 30px;
}

.gly_main {
	font-family: 综艺体;
	font-size: 16px;
	width: 75%;
	float: right;
	background-color: rgb(255, 255, 255);
	border: solid 1px rgb(200, 200, 200);
	margin-bottom: 50px;
}

.t1 {
	clear: both;
	border: 1px solid #c9dae4;
}

.t1 tr {
	height: 50px;
}

.t1 tr th {
	color: #0d487b;
	background: #f2f4f8 left bottom;
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
<script src="js/jquery.js"></script>
<script type="text/javascript">
	var searchEmail="";
	var searchRole = "null";
	function searchUser() {
		searchEmail = $("#searchEmail").val();
		searchRole = $("#searchRole").val();
		loadUserPage(true, 0);
	}
	var urlSection = "<%=request.getParameter("section")%>"
	if (urlSection == "null")
		urlSection = "gly_main_yhgl";
	var sectionList = new Array("gly_main_yhgl", "gly_main_wdgl",
			"gly_main_reset", "gly_main_success", "gly_main_lbgl",
			"gly_main_upload","gly_main_tjfx");
	function checkPasswords() {
		var pass1 = document.getElementById("upassword");
		var pass2 = document.getElementById("password2");
		if (pass1.value != pass2.value)
			pass2.setCustomValidity("两次输入的密码不匹配");
		else
			pass2.setCustomValidity("");
	}
	function showSection(sectionName) {
		for ( var index in sectionList) {
			document.getElementById(sectionList[index]).style.display = "none";
		}
		document.getElementById(sectionName).style.display = "block";
	}

	function loadUsers(pageIndex) {
		var emailPara = searchEmail != "" ? "&searchEmail=" + searchEmail : "";
		$("#userContent").load(
				"ajax/getUsers?pageIndex=" + pageIndex + emailPara
						+ "&searchRole=" + searchRole);
	}
	function initFileUpload(){
		$('#fileupload').fileupload(
				{
					dataType : 'json',
					done : function(e, data) {
						$("tr:has(td)").remove();
						$.each(
					data.result,
					function(index, file) {
						$("#uploaded-files").append(
						$('<tr/>').append($('<td/>').text(file.fileName))
								.append($('<td/>').text(file.fileSize))
								.append($('<td/>').text(file.fileType)))
					});
					},
					progressall : function(e, data) {
						var progress = parseInt(data.loaded / data.total
								* 100, 10);
						$('#progress .bar').css('width', progress + '%');
					}
				});
	}

	$(document).ready(function() {
		$("#menu_sub_yhgl").click(function() {
			showSection("gly_main_yhgl");
			loadUserPage(false);
		});
		$("#menu_sub_wdgl").click(function() {//文档管理
			showSection("gly_main_wdgl");
			var url = "/dbsearch/YH/wenxian_list_am";
			var data = {
				operRole:"adm",
				strSearch:"",
				cateId:"",
				pageIndex:1
			};
			$.ajax({
				type : "post",
				async : false, //同步请求
				url : url,
				data : data,
				success : function(datas) {
					$("#gly_main_wdgl").html(datas);//要刷新的div
				},
				error : function() {
					alert("失败，请稍后再试！");
				}
			});
		});
		$("#menu_sub_mmxg").click(function() {
			showSection("gly_main_reset");
		});
		$("#menu_sub_upload").click(function() {
			showSection("gly_main_upload");
			initFileUpload();
		});
		$("#menu_sub_tjfx").click(function() {
			showSection("gly_main_tjfx");
			var url = "/dbsearch/YH/tjfx";
			var data = {

			};
			$.ajax({
				type : "post",
				async : false, //同步请求
				url : url,
				data : data,
				success : function(datas) {
					$("#gly_main_tjfx").html(datas);//要刷新的div
				},
				error : function() {
					alert("失败，请稍后再试！");
				}
			});
		});
		$("#menu_sub_lbgl").click(function() {
			showSection("gly_main_lbgl");
			var url = "/dbsearch/YH/leibie01";
			var data = {

			};
			$.ajax({
				type : "post",
				async : false, //同步请求
				url : url,
				data : data,
				success : function(datas) {
					$("#gly_main_lbgl").html(datas);//要刷新的div
				},
				error : function() {
					alert("失败，请稍后再试！");
				}
			});
		});
		$("#menu_sub_yhgl").click();
	})


	
</script>

</head>

<body>
	<div class="div_head_container">
		<jsp:include page="./pagehead.jsp" flush="true" />
	</div>
	<div
		style="width: 1200px; height: auto; margin: 0 auto; min-height: 800px;">
		<div id="wrapper">
			<div class="menu_gly">
				<div id="menu_sub_yhgl" class="menu_sub">
					<span class="menu_sub_span">用户管理</span>
				</div>
				<div id="menu_sub_wdgl" class="menu_sub">
					<span class="menu_sub_span">文档管理</span>
				</div>
				<div id="menu_sub_lbgl" class="menu_sub">
					<span class="menu_sub_span">类别管理</span>
				</div>
				<div id="menu_sub_upload" class="menu_sub">
					<span class="menu_sub_span">上传文章</span>
				</div>
				<div id="menu_sub_tjfx" class="menu_sub">
					<span class="menu_sub_span">统计分析</span>
				</div>
				<div id="menu_sub_mmxg" class="menu_sub">
					<span class="menu_sub_span">密码修改</span>
				</div>
			</div>
			<div class="gly_main">
				<div id="gly_main_yhgl">
					<div id="userSearch" style="height: 80px; line-height: 80px;">
						<label>Email:</label> <input type="text" id="searchEmail"
							style="height: 25px; width: 200px; padding-left: 2px; padding-right: 2px; padding-top: 0px; padding-bottom: 0px;"></input>
						<label style="padding-left: 20px;">用户权限:</label> <select
							id="searchRole"
							style="height: 27px; padding-left: 2px; padding-right: 2px; padding-top: 0px; padding-bottom: 0px;">
							<option value="null">所有</option>
							<%
								for (Integer key : UserService.RCode2Name.keySet()) {
							%>
							<option value="<%=key%>"><%=UserService.RCode2Name.get(key)%></option>
							<%
								}
							%>
						</select>

						<button type="button" onclick="searchUser()" class="s_btn"
							style="width: 80px; height: 30px; margin-left: 40px;">查询</button>
					</div>
					<div id="userContent"></div>
					<div id="userPage" class="m-pagination" style="margin: 0 auto;"></div>
				</div>

				<div id="gly_main_wdgl" style="display: none;"></div>
				<div id="gly_main_tjfx" style="display: none;"></div>
				<div id="gly_main_reset" style="display: none;">
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
								<td width="25%" align="right">确认密码：</td>
								<td width="75%"><label><input id="password2"
										type="password" class="textfield" placeholder="两次输入的密码需一致"></input>
								</label></td>
							</tr>
						</table>

						<div style="width: 100%; margin-top: 25px; margin-bottom: 25px;">
							<input type="submit" value="确定" class="s_btn"
								onclick="checkPasswords()">
						</div>

					</form>
				</div>
				<div id="gly_main_upload" style="display: none;padding-bottom:20px;">
					<div style="width:100%;padding-top:20px;padding-bottom:20px;">
						文件批量上传：<input id="fileupload" type="file" name="files[]"
							data-url="ajax/pure_upload" accept=".doc,.docx,.pdf" multiple>
					</div>
					<div id="progress">
						<div style="width: 0%;"></div>
					</div>
					<table id="uploaded-files" class="t1" style="width:100%">
						<tr>
							<th>文件名</th>
							<th>文件大小</th>
							<th>上传时长</th>
							<th>上传结果</th>
						</tr>
						
					</table>
				</div>
				<div id="gly_main_success" style="display: none;">
					<label>密码修改成功</label>
				</div>
				<div id="gly_main_lbgl" style="display: none;"></div>
				
			</div>
		</div>
	</div>
	<div style="clear: both;"></div>
	<div class="div_foot_container">
		<jsp:include page="./pagefoot.jsp" flush="true" />
	</div>
</body>
<!-- <script src="js/jquery.pagination-1.2.7.min.js"></script> -->

<script src="js/jquery.ui.widget.js"></script>
<script src="js/jquery.iframe-transport.js"></script>
<script src="js/jquery.fileupload.js"></script>
<script type="text/javascript">
	currentPageIndex = 0;
	function loadUserPage(forceReload, startIndex) {
		startIndex = startIndex || 0;
		currentPageIndex = startIndex;
		if ($("#userPage").pagination()) {
			if (forceReload)
				$("#userPage").pagination('destroy');
			else
				return;
		}
		var emailPara = searchEmail != "" ? "searchEmail=" + searchEmail + "&"
				: "";
		$.get("ajax/getUserCount?" + emailPara + "searchRole=" + searchRole,
				function(data, status) {
					$("#userPage").pagination({
						pageSize : 10,
						total : data,
						firstBtnText : '首页',
						lastBtnText : '尾页',
						prevBtnText : '上一页',
						nextBtnText : '下一页',
						pageIndex : startIndex
					}).on("pageClicked", function(event, pageObj) {
						currentPageIndex = pageObj.pageIndex;
						loadUsers(pageObj.pageIndex + 1);
					});
					loadUsers(startIndex + 1);
				});
	}
	
	function initFileUpload(){
		$('#fileupload').fileupload(
				{
					dataType : 'json',
					done : function(e, data) {
						$.each(data.result,
					function(index, file) {
						$("#uploaded-files").append(
						$('<tr/>').append($('<td/>').text(file.fileName))
								.append($('<td/>').text(file.fileSize))
								.append($('<td/>').text(file.timeCost))
								.append($('<td/>').text(file.result)))
					});
					},
					progressall : function(e, data) {
						var progress = parseInt(data.loaded / data.total
								* 100, 10);
						$('#progress .bar').css('width', progress + '%');
					}
				});
	}
	var sectionArr = new Array("menu_sub_yhgl", "menu_sub_wdgl","menu_sub_lbgl", "menu_sub_mmxg", "menu_sub_upload", "menu_sub_tjfx");
	function setMenuCCS(menu) {
		for ( var index in sectionArr) {
			document.getElementById(sectionArr[index]).style.backgroundColor = "rgb(255,255,255)";
			document.getElementById(sectionArr[index]).style.color = "rgb(0,0,0)";
		}
		document.getElementById(menu).style.backgroundColor = "rgb(80,80,80)";
		document.getElementById(menu).style.color = "rgb(255,255,255)";
	}
	$("#menu_sub_yhgl").click(function() {
		setMenuCCS("menu_sub_yhgl");
	});
	$("#menu_sub_wdgl").click(function() {
		setMenuCCS("menu_sub_wdgl");
	});
	$("#menu_sub_lbgl").click(function() {
		setMenuCCS("menu_sub_lbgl");
	});
	$("#menu_sub_upload").click(function() {
		setMenuCCS("menu_sub_upload");
	});
	$("#menu_sub_tjfx").click(function() {
		setMenuCCS("menu_sub_tjfx");
	});
	$("#menu_sub_mmxg").click(function() {
		setMenuCCS("menu_sub_mmxg");
	});
</script>
<script src="js/mricode.pagination.js"></script>
</html>
