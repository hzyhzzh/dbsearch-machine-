<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@	taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@	taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" import="dbsearch.domain.Category"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
		<table width="100%" id="" border="0" class="t1" align="center" cellpadding="0"
	        cellspacing="0" align="left">
	        <tr>
	            <th width="100%" align="center">
	            	修改类别
	            </th>
	        </tr>
	        <tr>
				<td align="center" height="150px;" line-height="150px;">
				<%!
					Category category; 
				%>
				<%
					category=(Category)request.getAttribute("category");
				%>	
					<input type="hidden" id="str_update_id" value="<%=category.getId() %>">
					<input type="text" id="str_update_name" value="<%=category.getName() %>"
	        			style="height:30px;line-height:30px;width:200px;padding-left:15px;padding-right:15px;">
				</td>
			</tr>	
	    </table>
	    <div id="warningArea"></div>
	    <div style="padding:10px;">
			<input value="确认" type="button" class="s_btn" onclick="doUpCate()">
			<input value="返回" type="button" class="s_btn" style="margin-left:40px;" onclick="doReturn()">
		</div>	

<script type="text/javascript">
function doUpCate(){
	var strCate=$("#str_update_name").val();
	if(strCate==null||strCate.trim()==""){
		warning("请填写类别名称！");
		return;
	}
	var url = "/dbsearch/upCate";
	var data = {
		"cateId" : $("#str_update_id").val(),
		"cateName" : $("#str_update_name").val()
	};
	$.ajax({
		type : "post",
		async : false, //同步请求
		url : url,
		data : data,
		success : function(dates) {
			$("#gly_main_lbgl").html(dates);//要刷新的div
		},
		error : function() {
			
		}
	});
	
}
function doReturn(){
	var url = "/dbsearch/YH/leibie01";
	var data = {
		
	};
	$.ajax({
		type : "post",
		async : false, //同步请求
		url : url,
		data : data,
		success : function(dates) {
			$("#gly_main_lbgl").html(dates);//要刷新的div
		},
		error : function() {
			
		}
	});
}

function warning(str){
	document.getElementById("warningArea").innerHTML="Warning: "+str;
	document.getElementById("warningArea").style.display="block";
}
$("#warningArea").click( function() { 
	document.getElementById("warningArea").style.display="none";
}); 
</script>
</body>
</html>