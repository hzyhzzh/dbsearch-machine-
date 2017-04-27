<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="dbsearch.domain.PaperField"%>
<%@ page language="java" import="dbsearch.domain.FieldKeyword"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	<title>Insert title here</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
<style type="text/css">
.tb_tjfx{
	width:100%;
	border:1px solid rgb(200,200,200);
}
.tb_tjfx tr th {
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
.tb_tjfx tr td {
    line-height: 35px;
    border-top: 1px solid #e9edf3;
    padding-left: 10px;
    padding-right: 10px;
}
</style>

</head>
<body>
	<table class="tb_tjfx">
		<tr>
			<th width="20%">字段名</th>
			<th width="20%">关键词</th>
			<th width="60%">改进措施</th>
		</tr>
		<%!
			List<PaperField> fieldList;
			List<FieldKeyword> keywordList;
			Map fieldMap=new HashMap();
			PaperField paperField;
			FieldKeyword fieldKeyword;
		%>
		<%
			fieldList=(List<PaperField>)request.getAttribute("fieldList");
			fieldMap=(Map)request.getAttribute("fieldMap");
			if(!fieldList.isEmpty()){
				for(int i=0;i<fieldList.size();i++){
					paperField=(PaperField)fieldList.get(i);
		%>
		<tr>
			<td align="center" width="20%">
				<input id="" name="chk_field" type="checkbox" value="<%=paperField.getId() %>"
					style="padding-left:5px;float:left;" onclick="setSelectedSingle(this)"/>
				<%=paperField.getTitle() %>
			</td>
			<td align="left" width="80%" colspan="2">
			<%
				keywordList=(List<FieldKeyword>)fieldMap.get(paperField.getName());
				if(!keywordList.isEmpty()){
					for(int k=0;k<keywordList.size();k++){
						fieldKeyword=(FieldKeyword)keywordList.get(k);
			%>
				<table width="100%" border="0">
					<tr><td width="25%">
						<input id="" name="chk_keyword" type="checkbox" value="<%=fieldKeyword.getId() %>"
							style="padding-left:15px;padding-right:5px;" onclick="setSelectedSingle(this)"/>
							<%=fieldKeyword.getKeyWord() %>
					</td><td width="75%">
						<%=fieldKeyword.getImprovement() %>
					</td></tr>		
				</table>
			<%}} %>	
			</td>
		</tr>
		
		<%}} %>
	</table>
	<div style="width:100%;padding-top:20px;">
	<table width="100%">
		<tr><td width="35%" align="right">
		关键词：
		</td><td width="65%" align="left" >
		<input id="txtKeyWord" style="width:250px;height:30px;line-height:30px;font-size:120%;">
		</td></tr>
	</table></div>
	<div style="width:100%;padding-top:20px;">
	<table width="100%">
		<tr><td width="35%" align="right">
		改进措施：
		</td><td width="65%" align="left" >
		<textarea id="txtImprovement" rows="6" cols="50"></textarea>
		</td></tr>
	</table>
	</div>
	<div style="width:100%;padding-top:20px;padding-bottom:15px;">
		<button type="button" onclick="doKeyWordsInsert()" class="s_btn" style="width:80px;height:30px;margin-right:50px;">添加</button>
		<button type="button" onclick="doKeyWordsAlter()" class="s_btn" style="width:80px;height:30px;margin-right:50px;">修改</button>
		<button type="button" onclick="doKeyWordsDelete()" class="s_btn" style="width:80px;height:30px;">删除</button>
	</div>
</body>
<script type="text/javascript">
var inputs = document.getElementsByTagName("input");//获取所有的input标签对象
var chk = [];//初始化空数组，用来存放checkbox对象。
for(var i=0;i<inputs.length;i++){
  var obj1 = inputs[i];
  if(obj1.type=='checkbox'){
	  chk.push(obj1);
  }
}
function setSelectedSingle(obj){//设置复选框只能选中一个
 	for (var i = 0; i < chk.length; i++) {
	 	if(chk[i]!=obj)
 			chk[i].checked = false;
 	}
}
function doKeyWordsInsert(){
	var chkName=null;
	var fieldId;
	for (var i = 0; i < chk.length; i++) {
		if(chk[i].checked == true){
			chkName = chk[i].name;
			fieldId=chk[i].value;
	 		break;
	 	}
 	}
	if(chkName==null||chkName!="chk_field"){
		alert("请选择需要添加关键词的字段名！");
		return;
	}
	var txtKeyWord=$("#txtKeyWord").val();
	var improvement=$("#txtImprovement").val().trim();
	if(txtKeyWord==null||txtKeyWord.trim()==""){
		alert("请填写需要添加的关键词！");
		return;
	}
	var url =  "/dbsearch/TJFXKeyWordsInsert";
	var data = {
		fieldId:fieldId,
		keyWord:txtKeyWord,
		improvement:improvement
	};
	$.ajax({
		type : "post",
		async : false, //同步请求
		url : url,
		data : data,
		success : function(datas) {
			$("#gly_main_tjfx").html(datas);
		},
		error : function() {
			
		}
	});
}
function doKeyWordsAlter(){
	var chkName=null;
	var keyWordId;
	for (var i = 0; i < chk.length; i++) {
		if(chk[i].checked == true){
			chkName = chk[i].name;
			keyWordId=chk[i].value;
	 		break;
	 	}
 	}
	if(chkName==null||chkName!="chk_keyword"){
		alert("请选择需要修改的关键词！");
		return;
	}
	var txtKeyWord=$("#txtKeyWord").val().trim();
	var improvement=$("#txtImprovement").val().trim();
	if(txtKeyWord==""&&improvement==""){
		alert("请填写需要修改的内容！");
		return;
	}
	var url =  "/dbsearch/TJFXKeyWordsAlter";
	var data = {
		keyWordId:keyWordId,
		keyWord:txtKeyWord,
		improvement:improvement
	};
	$.ajax({
		type : "post",
		async : false, //同步请求
		url : url,
		data : data,
		success : function(datas) {
			$("#gly_main_tjfx").html(datas);
		},
		error : function() {
			
		}
	});
}
function doKeyWordsDelete(){
	var chkName=null;
	var keyWordId;
	for (var i = 0; i < chk.length; i++) {
		if(chk[i].checked == true){
			chkName = chk[i].name;
			keyWordId=chk[i].value;
	 		break;
	 	}
 	}
	if(chkName==null||chkName!="chk_keyword"){
		alert("请选择需要删除的关键词！");
		return;
	}
	if (!confirm("确定要删除吗？")) return false;
	var url =  "/dbsearch/TJFXKeyWordsDelete";
	var data = {
		keyWordId:keyWordId
	};
	$.ajax({
		type : "post",
		async : false, //同步请求
		url : url,
		data : data,
		success : function(datas) {
			$("#gly_main_tjfx").html(datas);
		},
		error : function() {
			
		}
	});
}
</script>
</html>