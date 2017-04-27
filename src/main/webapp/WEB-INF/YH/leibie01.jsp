<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@	taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@	taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ page language="java" import="dbsearch.service.impl.CategoryService"%>
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
<style type="text/css">
.t2 {
	border: 0px;
	width:100%;
	border:0;
	cellpadding:0;
	cellspacing:0;
}
.t2 tbody{
	width:100%;
}
.t2 tr {
	height: 50px;
	width:100%;
}
.t2 tr td {
	border-bottom: 1px solid #e9e9e9;
	padding-bottom: 5px;
	padding-top: 5px;
	color: #444;
	border-top: 1px solid #FFFFFF;
	padding-left: 10px;
	padding-right: 10px;
	word-break: break-all;
}
.div_sec{
	width:100%;
}
</style>
</head>
<body id="leibie01">
			
 		<table width="100%" id="" border="0" class="t1" align="center" cellpadding="0"
	        cellspacing="0">
	        <tr>
	            <th width="10%" align="center">
	            	选择
	            </th>
	            <th width="45%" align="center">
	            	失效形式
	            </th>
	            <th width="45%" align="center">
	            	失效机理
	            	<span style="font-size:10px;cursor:pointer;" onclick="hideAll()"> 【收】</span>
	            	<span style="font-size:10px;cursor:pointer;" onclick="showAll()"> 【展】 </span>
	            </th>
	        </tr>
	     </table>   
	        
	        
	    <%!
 			List<List<Category>> menuList;
 			CategoryService categoryService;
 			Category tempCategory;
 		%>
 		
 		<%
 			menuList=(List<List<Category>>)request.getAttribute("cateList");
 			List<Category> subList;
 			if(!menuList.isEmpty()){
	 			for(int i=0;i<menuList.size();i++){
	 				subList=menuList.get(i);
	 				tempCategory=subList.get(0);//一级标题
	 	%>
	 	<table id="tb_<%=tempCategory.getId() %>" class="t2">
	 		<tr>
	 			<td align="center">
	 				<input id="chkId_<%=tempCategory.getId() %>" name="chk" type="checkbox" value="<%=tempCategory.getId() %>" 
	 					onclick="setSelectedSingle(this)"/></td>
	            <td width="45%" align="center">
	            	<%=tempCategory.getName() %>
	            </td>
	            <td width="45%" align="center">
	            	<span id="s_<%=tempCategory.getId() %>" class="_spn" onclick="sub_show(<%=tempCategory.getId() %>)">︿</span>
	            </td>
	        </tr>
	    </table> 
	    <div id="div_<%=tempCategory.getId() %>" class="div_sec">
	    <table class="t2">
	 	<%			
	 				for(int k=1;k<subList.size();k++){
	 					tempCategory=subList.get(k);//二级标题
	 	%>
	 		<tr id="sub_tr_id_<%=tempCategory.getId() %>">
	 			<td  align="center">
	 				<input id="chkId_<%=tempCategory.getId() %>" name="chk" type="checkbox" value="<%=tempCategory.getId() %>" 
	 					onclick="setSelectedSingle(this)"/></td>
	            <td width="45%" align="center">
	            	
	            </td>
	            <td width="45%" align="center">
	            	<%=tempCategory.getName() %>
	            </td>
	        </tr>
	 	<%
	 				}
	 	%>
 		</table>
 		</div>
	 	<%
	 			}
 			}
 		%>
		<div id="warningArea"></div>
		<div style="padding:10px;">
			<input value="添加" type="button" class="s_btn" style="margin-left:40px;" onclick="doInsert()">
			<input value="修改" type="button" class="s_btn" style="margin-left:40px;" onclick="doUpdate()">
			<input value="删除" type="button" class="s_btn" style="margin-left:40px;" onclick="doDelete()">
		</div>	
<script type="text/javascript">
function doInsert(){
	var url = "/dbsearch/insertCate";
	var data = {
		type : 1
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
function doUpdate(){
	var chk = document.getElementsByName("chk");
	var cateId=null;
 	for (var i = 0; i < chk.length; i++) {
	 	if(chk[i].checked == true){
	 		cateId = chk[i].value;
	 		break;
	 	}
 	}
	if(cateId==null){
		warning("请选择要修改的类别！");
		return;
	}
	
	var url = "/dbsearch/updateCate";
	var data = {
		"cateId" : cateId
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
function doDelete(){
	var chk = document.getElementsByName("chk");
	var cateId=null;
 	for (var i = 0; i < chk.length; i++) {
	 	if(chk[i].checked == true){
	 		cateId = chk[i].value;
	 		break;
	 	}
 	}
	if(cateId==null){
		warning("请选择要删除的类别！");
		return;
	}
	
	if(confirm("确定要删除这条类别吗？")){
		var url = "/dbsearch/deleteCate";
		var data = {
			"cateId" : cateId
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
}
function setSelectedSingle(obj){
 	var chk = document.getElementsByName("chk");
 	for (var i = 0; i < chk.length; i++) {
	 	if(chk[i]!=obj)
 			chk[i].checked = false;
 	}
}
function ss(){
	
// 	var Id = $("#tcontent tr:last").attr("id");
	var id = $("#t_lb").find("tr:last").attr("id");
	alert(id);
	var ss=$("#t_lb").find("tr");
	alert(ss[1].attr("id"));
	for(var i=0;i<ss.length;i++){
		alert(ss[i].attr("id"));
	}
}
function sub_show(id){
	div_id="div_"+id;
	s_id="s_"+id;
	if(document.getElementById(div_id).style.display=="none"){
		document.getElementById(div_id).style.display = "block";
		$("#s_"+id).text("︿");
	}else{
		document.getElementById(div_id).style.display="none";
		$("#s_"+id).text("﹀");
	}
}
function showAll(){
	var div_a=$(".div_sec");
	for(var i=0;i<div_a.length;i++){
		div_a[i].style.display="block";
	}
	var _spn=$("._spn");
	for(var i=0;i<_spn.length;i++){
		_spn[i].innerHTML="︿";
	}
}
function hideAll(){
	var div_a=$(".div_sec");
	for(var i=0;i<div_a.length;i++){
		div_a[i].style.display="none";
	}
	var _spn=$("._spn");
	for(var i=0;i<_spn.length;i++){
		_spn[i].innerHTML="﹀";
	}
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