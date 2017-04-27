<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page language="java" import="dbsearch.service.impl.CategoryService"%>
<%@ page language="java" import="dbsearch.domain.Paper"%>
<%@ page language="java" import="dbsearch.domain.User"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<title>Insert title here</title>
<link href="css/mricode.pagination.css" rel="stylesheet" />
<script src="js/mricode.pagination.js"></script>
<style type="text/css">
.td{
font-size:13px;
}
.submit-btn {
	border: 0 none;
	width: 70px;
	height: 25px;
	line-height: 30px;
	font-size: 13px;
	color: #1C86EE;
	text-align: center;
	background: #fff;
	border-radius: 12px;
	cursor: pointer;
	text-align:center; 
	padding:0px; 
	vertical-align: middle;
	border:1px solid #1C86EE;
	font-weight:bold
	
}
</style>
</head>
<body id="wx_am">
	<div id="fileSearch" style="">
	<table style="width:100%;boder:none;padding-top:10px;padding-bottom:10px;">
		<tr style="width:100%;height:40px;">
			<td width="20%" height="40px" align="right">关键词：</td>
			<td width="20%" height="40px" align="left">
				<input id="strSearch" style="width:250px;height:30px;line-height:30px;font-size:120%;"><br>
			</td>
			<td width="20%" height="40px" align="right">审核状态：</td>
			<td width="20%" height="40px" align="left">
				<select id="slt_status" onChange="" class="up_select" style="align:center">
					<option value="">--请选择--</option>
					<option value="0">待审核</option>
					<option value="1">已通过</option>
					<option value="2">未通过</option>
				</select>
			</td>
			
			<td width="20%" height="80px;" align="left" rowspan="2">
				<button type="button" onclick="doSearch()" class="submit-btn" style="width:80px;height:30px;margin-left:40px;">查询</button>
			</td>
		</tr>
		<tr style="width:100%;height:40px;">
			<td width="20%" height="40px" align="right">失效形式：</td>
			<td width="20%" height="40px" align="left">
				<select id="slt_parent" onChange="Change_Select()" class="up_select">
					<option value="0">--请选择--</option>
					
					<c:forEach var="parentCate" items="${parentCateList}" varStatus="status">
				    	<option value="${parentCate.id }">${parentCate.name }</option>
				    </c:forEach>
				    
				</select>
				<!--通过隐藏标签存失效形式的类别id -->
			    <input id="category" name="category" type="hidden" value=""/>
			</td>
			<td width="20%" height="40px" align="right">失效机理：</td>
			<td width="20%" height="40px" align="left">
			    <select id="slt_child" onChange="Change_Select2()" class="up_select"> 
			        <option value="0">--请选择--</option>
			    </select>
			</td>
		</tr>
	</table>
	</div>
	<div id="paperContent"></div>
	<!-- 			分页设置                        -->
	<div id="pageBar" class="m-pagination" style="margin: 0 auto;"></div>
	
	<div id="warningArea"></div>
	
	<div style="padding:10px;">
		<input value="通过" type="button" class="s_btn" style="margin-left:30px;width:80px;" onclick="doFileAccept()">
		<input value="驳回" type="button" class="s_btn" style="margin-left:30px;width:80px;" onclick="doFileReject()">
		<input value="修改" type="button" class="s_btn" style="margin-left:30px;width:80px;" onclick="doFileUpdate()">
		<input value="删除" type="button" class="s_btn" style="margin-left:30px;width:80px;" onclick="doFileDelete()">
		<input value="撤销" type="button" class="s_btn" style="margin-left:30px;width:80px;" onclick="doFileReset()">
		<span id="helpTag" style="float:right;color:rgb(220,220,220)">[帮助]</span>
	</div>
	<div id="helpArea" style="text-align:left;padding:20px;color:rgb(120,120,120);display:none;">
		通过：设置选中项的审核状态为“通过”<br>
		驳回：设置选中项的审核状态为“未通过”<br>
		修改：修改选中记录信息<br>
		删除：删除选中记录<br>
		撤销：对于已审核过的记录，设置其审核状态为“已提交”
	</div>
	
</body>

<script type="text/javascript">
function showPaper(id){
	window.location.href = "/dbsearch/showPaper?paperId="+id;
}

currentPageIndex = 0;
function loadPageBar(forceReload, startIndex) {
	startIndex = startIndex || 0;
	currentPageIndex = startIndex;
	if ($("#pageBar").pagination()) {
		if (forceReload)
			$("#pageBar").pagination('destroy');
		else
			return;
	}

	var url =  "ajax/getWDGLCount";
	var data = {
		operRole:"adm",
		strSearch:$("#strSearch").val(),
		cateId:$("#category").val(),
		fileStatus:$("#slt_status").val()
	};
	$.ajax({
			type : "post",
			async : false, //同步请求
			url : url,
			data : data,
			success :function(data, status) {
		$("#pageBar").pagination({
			pageSize : 10,
			total : data,
			firstBtnText : '首页',
			lastBtnText : '尾页',
			prevBtnText : '上一页',
			nextBtnText : '下一页',
			pageIndex : startIndex
		}).on("pageClicked", function(event, pageObj) {
			currentPageIndex = pageObj.pageIndex;
 			loadPaperList(pageObj.pageIndex + 1);
		});
 		loadPaperList(startIndex + 1);
	}});
}
loadPageBar(false);

function loadPaperList(pageIndex){
	var strSearch=$("#strSearch").val();
	var cateId=$("#category").val();
	var fileStatus=$("#slt_status").val();
	var url =  "/dbsearch/searchWDGL";
	var data = {
		operRole:"adm",
		strSearch:strSearch,
		cateId:cateId,
		fileStatus:fileStatus,
		pageIndex:pageIndex
	};
	$.ajax({
		type : "post",
		async : false, //同步请求
		url : url,
		data : data,
		success : function(dates) {
			$("#paperContent").html(dates);//要刷新的div
		},
		error : function() {
			
		}
	});
}
function doSearch(){
	loadPageBar(true,0);
}

function doFileAccept(){
	var chk = document.getElementsByName("chk");
	var paperId=null;
 	for (var i = 0; i < chk.length; i++) {
	 	if(chk[i].checked == true){
	 		paperId = chk[i].value;
	 		break;
	 	}
 	}
	if(paperId==null){
		warning("请选择一条内容！");
		return;
	}
	var fileStatus_id="fileStatus_"+paperId;
	var fileStatus=document.getElementById(fileStatus_id).value;
	if(fileStatus==1||fileStatus=="1"){
		warning("该文档已审核通过，不可重复操作！");
		return;
	}
	doShenhe("wenxian_shenhe",paperId,1,"adm");
}

function doFileReject(){
	var chk = document.getElementsByName("chk");
	var paperId=null;
 	for (var i = 0; i < chk.length; i++) {
	 	if(chk[i].checked == true){
	 		paperId = chk[i].value;
	 		break;
	 	}
 	}
	if(paperId==null){
		warning("请选择一条内容！");
		return;
	}
	var fileStatus_id="fileStatus_"+paperId;
	var fileStatus=document.getElementById(fileStatus_id).value;
	if(fileStatus==2||fileStatus=="2"){
		warning("该文档已审核驳回，不可重复操作！");
		return;
	}
	doShenhe("wenxian_shenhe",paperId,2,"adm");
}

function doFileReset(){
	var chk = document.getElementsByName("chk");
	var paperId=null;
 	for (var i = 0; i < chk.length; i++) {
	 	if(chk[i].checked == true){
	 		paperId = chk[i].value;
	 		break;
	 	}
 	}
	if(paperId==null){
		warning("请选择一条内容！");
		return;
	}
	var fileStatus_id="fileStatus_"+paperId;
	var fileStatus=document.getElementById(fileStatus_id).value;
	if(fileStatus==0||fileStatus=="0"){
		warning("该文档尚未审核，无法执行撤销！");
		return;
	}
	doShenhe("wenxian_shenhe",paperId,0,"adm");
}

function doFileUpdate(){
	var chk = document.getElementsByName("chk");
	var paperId=null;
 	for (var i = 0; i < chk.length; i++) {
	 	if(chk[i].checked == true){
	 		paperId = chk[i].value;
	 		break;
	 	}
 	}
	if(paperId==null){
		warning("请选择修改项！");
		return;
	}
	var fileStatus_id="fileStatus_"+paperId;
	var fileStatus=document.getElementById(fileStatus_id).value;
	if(fileStatus==1||fileStatus=="1"){
		warning("该文档已审核通过，不可修改！");
		return;
	}
// 	doShenhe("wenxian_update",paperId,"","adm");
	window.open("/dbsearch/WX/wenxian_update?paperId="+paperId);
}

function doFileDelete(){
	var chk = document.getElementsByName("chk");
	var paperId=null;
 	for (var i = 0; i < chk.length; i++) {
	 	if(chk[i].checked == true){
	 		paperId = chk[i].value;
	 		break;
	 	}
 	}
	if(paperId==null){
		warning("请选择删除项！");
		return;
	}
	var fileStatus_id="fileStatus_"+paperId;
	var fileStatus=document.getElementById(fileStatus_id).value;
	if(fileStatus==1||fileStatus=="1"){
		warning("该文档已审核通过，不可删除！");
		return;
	}
	if(confirm("确定要删除这条内容吗？")){
		doShenhe("wenxian_delete",paperId,"","adm");
// 		window.location.href = "/dbsearch/WX/wenxian_delete?paperId="+paperId;
	}
}

function doShenhe(oper,paperId,status,operRole){
	var url =  "/dbsearch/WX/"+oper;
	var data = {
		paperId:paperId,
		status:status,
		operRole:operRole
	};
	$.ajax({
		type : "get",
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
}

$("#helpTag").click( function() { 
	if(document.getElementById("helpArea").style.display=="none"){
		document.getElementById("helpArea").style.display="block";
	}else{
		document.getElementById("helpArea").style.display="none";
	}
}); 

function warning(str){
	document.getElementById("warningArea").innerHTML="Warning: "+str;
	document.getElementById("warningArea").style.display="block";
}
$("#warningArea").click( function() { 
	document.getElementById("warningArea").style.display="none";
}); 
</script>
<script type="text/javascript">
function setSelectedSingle(obj){
 	var chk = document.getElementsByName("chk");
 	for (var i = 0; i < chk.length; i++) {
	 	if(chk[i]!=obj)
 			chk[i].checked = false;
 	}
}
//下拉框二级及联
var req; 
function Change_Select(){//当第一个下拉框的选项发生改变时调用该函数 
	var url = "/dbsearch/selectCate?parentId="+$("#slt_parent").val(); 
	if(window.XMLHttpRequest){ 
		req = new XMLHttpRequest(); 
	}else if(window.ActiveXObject){ 
       	req = new ActiveXObject("Microsoft.XMLHTTP"); 
	} 
	if(req){ 
		req.open("GET",url,true); 
		//指定回调函数为callback 
		req.onreadystatechange = callback; 
		req.send(null); 
	} 
	
	document.getElementById("category").value=$("#slt_parent").val();
} 
function Change_Select2(){
	if($("#slt_child").val()=="0"){
		document.getElementById("category").value=$("#slt_parent").val();
	}else{
		document.getElementById("category").value=$("#slt_child").val();
	}
}
//回调函数 
function callback(){ 
	if(req.readyState ==4){ 
		if(req.status ==200){ 
			parseMessage();//解析XML文档 
		}else{ 
			alert("不能得到描述信息:" + req.statusText); 
		} 
	} 
} 
//解析返回xml的方法 
function parseMessage(){ 
	var xmlDoc = req.responseXML.documentElement;//获得返回的XML文档 
	var xSel = xmlDoc.getElementsByTagName('select'); 
    //获得XML文档中的所有<select>标记 
    var select_root = document.getElementById('slt_child'); 
    //获得网页中的第二个下拉框 
    select_root.options.length=1; 
    //每次获得新的数据的时候先把每二个下拉框架的长度清0 

    for(var i=0;i<xSel.length;i++){ 
        var xValue = xSel[i].childNodes[0].firstChild.nodeValue; 
        //获得每个<select>标记中的第一个标记的值,也就是<value>标记的值 
        var xText = xSel[i].childNodes[1].firstChild.nodeValue; 
        //获得每个<select>标记中的第二个标记的值,也就是<text>标记的值 

        var option = new Option(xText, xValue); 
        //根据每组value和text标记的值创建一个option对象 

        try{ 
			select_root.add(option);//将option对象添加到第二个下拉框中 
        }catch(e){ 
        } 
	} 
}  
</script>
</html>