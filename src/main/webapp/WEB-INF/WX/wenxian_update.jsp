<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@	taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@	taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" import="dbsearch.domain.Paper"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'wenxian_upload.jsp' starting page</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8 ">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script src="js/jquery.js"></script>
<script src="js/jquery.min.js"></script>
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

.up_select {
	background: #fff;
	width: 200px;
	height: 28px;
	margin-right: 30px;
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
	width: 100px;
	height: 34px;
	color: white;
	padding-top: 2px \9;
	margin-left: 550px;
	font-size: 15px;
	letter-spacing: 1px;
	background-color: #38f;
	border: none;
	outline: medium;
	cursor: pointer;
}

tr td {
	padding-bottom: 20px;
}
</style>
</head>

<body>
	<div class="div_head_container">
		<jsp:include page="../YH/pagehead.jsp" flush="true" />
	</div>
	<div class="clear"></div>
	<!--导航栏-->
		<div class="e_top" id="bar">
			<div class="e_topnav">
				<ul>
					<li><a id="shouye">网站首页</a></li>
					<li><a id="search">高级搜索</a></li>
					<li><a id="selfanalysis">失效自诊</a></li>
					<li><a id="commoncase">常见案例</a></li>
					<li><a id="upload">上传文档</a></li>
					<li><a id="contactus">联系我们</a></li>
				</ul>
			</div>
		</div>
		<!-- 栏目选择结束 -->
	<div
		style="width: 1200px; height: auto; min-height: 800px;; margin: 0 auto;">
		<div id="wrapper">
			<div class="cjsx">文档预览</div>
			<div id="up_adv">
				<%-- 				<form action="/upload" id="up_adv_frm"> --%>
				<form:form modelAttribute="editPaper" id="update_frm"
					class="form-horizontal" enctype="multipart/form-data">
					<table style="width: 100%; border: none;">

						<form:hidden id="id" path="id" class="up_input"></form:hidden>

						<tr style="margin-bottom: 20px;">
							<td style="font-weight: bold; width: 30%; text-align: right">事故名称</td>
							<td style="padding-left: 20px;"><label> <form:input
										id="accidentName" path="accidentName" class="up_input"></form:input>
									<form:errors path="accidentName" cssClass="text-danger" />
							</label> <span id="accidentNameError" class="text-danger"></span> <!-- 								<input type="text" data-type="all" data-name="" class="up_input" maxlength="100" value=""> -->
							</td>
						</tr>
						<tr style="margin-bottom: 20px;">
							<td style="font-weight: bold; width: 30%; text-align: right">事故时间</td>
							<td style="padding-left: 20px;"><label> <form:input
										type="date" id="accidentTime" path="accidentTime"
										class="up_input" style="width:200px;"></form:input> <form:errors
										path="accidentTime" cssClass="text-danger" />
							</label> <!-- 							<input type="date" data-type="all" data-name="" class="up_input" value="" style="width:200px;"></td> -->
						</tr>
						<tr style="margin-bottom: 20px;">
							<td style="font-weight: bold; width: 30%; text-align: right">事故地点</td>
							<td style="padding-left: 20px;"><label> <form:input
										id="accidentLocation" path="accidentLocation" class="up_input"></form:input>
									<form:errors path="accidentLocation" cssClass="text-danger" />
							</label> <!-- 							<input type="text" data-type="all" data-name="" class="up_input" maxlength="100" value=""></td> -->
						</tr>
						<tr style="margin-bottom: 20px;">
							<td style="font-weight: bold; width: 30%; text-align: right">产品制造商信息</td>
							<td style="padding-left: 20px;"><label> <form:textarea
										id="productor" path="productor" class="up_textarea"
										placeholder="包括名称、地址等" /> <form:errors path="productor"
										cssClass="text-danger" />
							</label> <!-- 							<textarea  class="up_textarea" maxlength="3000" placeholder="包括名称、地址等"></textarea></td> -->
						</tr>
						<tr style="margin-bottom: 20px;">
							<td style="font-weight: bold; width: 30%; text-align: right">失效设备</td>
							<td style="padding-left: 20px;"><label> <form:input
										id="failureEquipment" path="failureEquipment" class="up_input"></form:input>
									<form:errors path="failureEquipment" cssClass="text-danger" />
							</label> <span id="failureEquipmentError" class="text-danger"></span> <!-- 							<input type="text" data-type="all" data-name="" class="up_input" maxlength="100" value=""></td> -->
						</tr>
						<tr style="margin-bottom: 20px;">
							<td style="font-weight: bold; width: 30%; text-align: right">失效部件</td>
							<td style="padding-left: 20px;"><label> <form:input
										id="failureComponent" path="failureComponent" class="up_input"></form:input>
									<form:errors path="failureComponent" cssClass="text-danger" />
							</label> <span id="failureEquipmentError" class="text-danger"></span> <!-- 							<input type="text" data-type="all" data-name="" class="up_input" maxlength="100" value=""></td> -->
						</tr>
						<tr style="margin-bottom: 20px;">
							<td style="font-weight: bold; width: 30%; text-align: right">应用环境</td>
							<td style="padding-left: 20px;"><label> <form:input
										id="applyEnv" path="applyEnv" class="up_input"></form:input> <form:errors
										path="applyEnv" cssClass="text-danger" />
							</label> <span id="applyEnvError" class="text-danger"></span> <!-- 							<input type="text" data-type="all" data-name="" class="up_input" maxlength="100" value=""></td> -->
						</tr>
						<tr style="margin-bottom: 20px;">
							<td style="font-weight: bold; width: 30%; text-align: right">失效形式</td>
							<td style="padding-left: 20px;"><select id="failureBehave"
								onChange="Change_Select()" class="up_select">
									<option value="0">--请选择--</option>

									<c:forEach var="parentCate" items="${parentCateList}"
										varStatus="status">
										<option value="${parentCate.id }">${parentCate.name }</option>
									</c:forEach>

							</select> <span id="failureBehaveError" class="text-danger"></span> <!--通过隐藏标签存失效形式的类别id -->
								<form:hidden id="category" path="category" /></td>
						</tr>
						<tr style="margin-bottom: 20px;">
							<td style="font-weight: bold; width: 30%; text-align: right">失效机理</td>
							<td style="padding-left: 20px;"><label> <select
									id="failureCause" onChange="Change_Select2()" class="up_select">
										<option value="0">--请选择--</option>
								</select> <%-- <form:input id="failureCause" path="failureCause" class="up_input"></form:input> 
									<form:errors path="failureCause" cssClass="text-danger" /> --%>
							</label> <span id="failureCauseError" class="text-danger"></span> <!-- 							<input type="text" data-type="all" data-name="" class="up_input" maxlength="100" value=""></td> -->
						</tr>
						<tr style="margin-bottom: 20px;">
							<td style="font-weight: bold; width: 30%; text-align: right">失效材料类型</td>
							<td style="padding-left: 20px;"><label> <form:input
										id="failureMaterial" path="failureMaterial" class="up_input"></form:input>
									<form:errors path="failureMaterial" cssClass="text-danger" />
							</label> <span id="failureMaterialError" class="text-danger"></span> <!-- 							<input type="text" data-type="all" data-name="" class="up_input" maxlength="100" value=""></td> -->
						</tr>
						<tr style="margin-bottom: 20px;">
							<td style="font-weight: bold; width: 30%; text-align: right">失效材料信息</td>
							<td style="padding-left: 20px;"><label> <form:textarea
										id="materialInfo" path="materialInfo" class="up_textarea"
										placeholder="包括成分、力学性能等" /> <form:errors path="materialInfo"
										cssClass="text-danger" />
							</label> <span id="materialInfoError" class="text-danger"></span> <!-- 							<textarea  class="up_textarea" maxlength="3000" placeholder="包括成分、力学性能等"></textarea></td> -->
						</tr>
						<tr style="margin-bottom: 20px;">
							<td style="font-weight: bold; width: 30%; text-align: right">事故概览</td>
							<td style="padding-left: 20px;"><label> <form:textarea
										id="accidentDescription" path="accidentDescription"
										class="up_textarea" placeholder="" /> <form:errors
										path="accidentDescription" cssClass="text-danger" />
							</label> <span id="accidentDescriptionError" class="text-danger"></span>
								<!-- 							<textarea  class="up_textarea" maxlength="3000"></textarea></td> -->
						</tr>
						<tr style="margin-bottom: 20px;">
							<td style="font-weight: bold; width: 30%; text-align: right">分析总结</td>
							<td style="padding-left: 20px;"><label> <form:textarea
										id="analyseConclusion" path="analyseConclusion"
										class="up_textarea" placeholder="" /> <form:errors
										path="analyseConclusion" cssClass="text-danger" />
							</label> <span id="analyseConclusionError" class="text-danger"></span> <!-- 							<textarea  class="up_textarea" maxlength="3000"></textarea></td> -->
						</tr>
						<tr style="margin-bottom: 20px;">
							<td style="font-weight: bold; width: 30%; text-align: right">上传文档</td>
							<td style="padding-left: 20px;"><span
								style="padding-right: 20px; cursor: pointer; color: #38f;"
								onclick="chakanquanwen()">查看原文</span> <span>替换文件： <input
									id="fileInput" type='file' accept=".doc,.docx,.pdf" name="file"
									class='txt' /> <span id="fileError" class="text-danger"></span>
							</span></td>
						</tr>
						<tr style="margin-bottom: 20px;">
							<td colspan="2"><input type="button" class="btn_submit"
								value="提交" onclick="doUpload()" /></td>
						</tr>
					</table>
				</form:form>
			</div>
		</div>
	</div>
	<div style="clear: both;"></div>
	<div class="div_foot_container">
		<jsp:include page="../YH/pagefoot.jsp" flush="true" />
	</div>

	<script type="text/javascript">
	var req; 
	function Change_Select(){//当第一个下拉框的选项发生改变时调用该函数 
		var url = "/dbsearch/selectCate?parentId="+$("#failureBehave").val(); 
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
		
		document.getElementById("category").value=$("#failureBehave").val();
	} 
	function Change_Select2(){
		if($("#failureCause").val()=="0"){
			document.getElementById("category").value=$("#failureBehave").val();
		}else{
			document.getElementById("category").value=$("#failureCause").val();
		}
	}
	//回调函数 
	function callback(){ 
		if(req.readyState ==4){ 
			if(req.status ==200){ 
				parseMessage();//解析XML文档 
				
				setSlt2Selected();
				Change_Select2();
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
        var select_root = document.getElementById('failureCause'); 
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
	
	/**
	 * 设置select选中
	*/
	<%Paper paper=(Paper)request.getAttribute("editPaper"); %>
	$(window).load(function() {
		<%if(paper.getCategory()!=null){%>
		 	var cate_F = "<%=paper.getCategory().getParent().getId() %>"; 
	    	var cate_S = "<%=paper.getCategory().getId() %>";
		    var select1 = document.getElementById("failureBehave"); 
			for(var i=0; i<select1.options.length; i++){  
			    if(select1.options[i].value == cate_F){  
			        select1.options[i].selected = true; 
			        break;  
			    }  
			} 
			Change_Select();
		<%}%>
    });
	function setSlt2Selected(){
		<%if(paper.getCategory()!=null){%>
			var cate_S = "<%=paper.getCategory().getId() %>";
			var select2 = document.getElementById("failureCause"); 
			for(var i=0; i<select2.options.length; i++){  
			    if(select2.options[i].value == cate_S){  
			        select2.options[i].selected = true;  
			        break;  
			    }  
			} 
		<%}%>
	}
	function doUpload(){
		if(checkInfo()==0)
			return;
		document.getElementById("update_frm").submit();
	}
	function checkInfo(){
		var chk=1;
		var accidentName=$("#accidentName").val();
		if(accidentName.trim()==""){
			document.getElementById("accidentNameError").innerHTML="请填写事故名称";
			chk=0;
		}else{
			document.getElementById("accidentNameError").innerHTML="";
		}
		
		var failureEquipment=$("#failureEquipment").val();
		if(failureEquipment.trim()==""){
			document.getElementById("failureEquipmentError").innerHTML="请填写失效设备";
			chk=0;
		}else{
			document.getElementById("failureEquipmentError").innerHTML="";
		}
		
		var applyEnv=$("#applyEnv").val();
		if(applyEnv.trim()==""){
			document.getElementById("applyEnvError").innerHTML="请填写应用环境";
			chk=0;
		}else{
			document.getElementById("applyEnvError").innerHTML="";
		}
		
		if($("#failureBehave").val()==0){
			document.getElementById("failureBehaveError").innerHTML="请选择失效形式";
			chk=0;
		}else{
			document.getElementById("failureBehaveError").innerHTML="";
		}
		
		if($("#failureCause").val()==0){
			document.getElementById("failureCauseError").innerHTML="请选择失效机理";
			chk=0;
		}else{
			document.getElementById("failureCauseError").innerHTML="";
		}
		
		var failureMaterial=$("#failureMaterial").val();
		if(failureMaterial.trim()==""){
			document.getElementById("failureMaterialError").innerHTML="请填写失效材料类型";
			chk=0;
		}else{
			document.getElementById("failureMaterialError").innerHTML="";
		}
		
		var materialInfo=$("#materialInfo").val();
		if(materialInfo.trim()==""){
			document.getElementById("materialInfoError").innerHTML="请填写失效材料信息";
			chk=0;
		}else{
			document.getElementById("materialInfoError").innerHTML="";
		}
		
		var accidentDescription=$("#accidentDescription").val();
		if(accidentDescription.trim()==""){
			document.getElementById("accidentDescriptionError").innerHTML="请填写事故概览";
			chk=0;
		}else{
			document.getElementById("accidentDescriptionError").innerHTML="";
		}
		
		var analyseConclusion=$("#analyseConclusion").val();
		if(analyseConclusion.trim()==""){
			document.getElementById("analyseConclusionError").innerHTML="请填写分析总结";
			chk=0;
		}else{
			document.getElementById("analyseConclusionError").innerHTML="";
		}
		
		return chk;
	}
	function chakanquanwen(){
		var user = "<%=session.getAttribute("user")%>";
			if (user == null || user == "null") {
				showLog();
			} else {
				window.location.href = "showPdf?paperId=" + $("#id").val();
			}
		}
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
	/*$("#contactus").click(function() {
	window.location.href = "/dbsearch/selfanalysis";
	});*/
	</script>
</body>
</html>
