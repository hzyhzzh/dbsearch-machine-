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
    
    <title>My JSP 'wenxian_search.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link href="css/index.css" rel="stylesheet" type="text/css" />

  </head>
  
  <body>
    <div id="wrapper" >
		<div style="width:70%;height:100px;margin:15px;float:right;">
			<div style="width:735px;height:40px;line-height:40px;margin-top:40px;border:1px solid #2975e5;">
				<div style="border-radius:8px;width:505px;height:40px;float:left;border:0px;">
					<input id="txtSearch" style="border-radius:8px;width:500px;height:38px;line-height:38px;font-size:80%;font: 16px arial;padding-left:15px;padding-right:15px;placeholder='多个关键词请用空格隔开';"
					value="<%=request.getParameter("q")==null?"":request.getParameter("q")%>">
				</div>
				<div id="btn_gjss" style="width:115px;height:40px;float:left;background:#f5f5f5;border:0px;" onclick="gaojisousuo()" 
				onmouseover="this.style.cursor='hand';javascript:void(isOut=0)"  onmouseout="javascript:void(isOut=1)">
					<span>&nbsp;高级搜索</span>
					<span id="down_up">﹀</span>
				</div>
				<div  style="cursor: pointer;width:115px;_width:113px;height:40px;float:left;background:#38f;text-align:center;border:0px;" 
					onclick="search()">
					<span style="color:rgb(255,255,255);">搜&nbsp;索</span>
				</div>
			</div>
			<div id="sc_adv" style="display: none;" onmouseover="javascript:void(isOut=0)" onmouseout="javascript:void(isOut=1)">
				<form id="advSearchForm" action="<spring:url value='searchAdv'></spring:url>" method="post"
					class="form-horizontal">
					<table style="width:100%;border:none;">
						<tr>
							<td style="width:30%;text-align:right">事故名称</td>
							<td style="padding-left:20px;">
								<input type="text" id="accidentName" name="accidentName" class="sc-input" maxlength="100" value="" placeholder='多个关键词请用空格隔开'>
								<span id="accidentName_And_OR" style="cursor: pointer;font: normal 12px simsun;color: #999;" onclick="span_AdvSearch_And_Or(this)">与</span>
							</td>
						</tr>
						<tr>
							<td style="width:30%;text-align:right">事故时间</td>
							<td style="padding-left:20px;"><input type="date" id="accidentTime" name="accidentTime" style="background: #fff;width:263px;height:28px;"></td>
						</tr>
						<tr>
							<td style="width:30%;text-align:right">事故地点</td>
							<td style="padding-left:20px;">
								<input type="text" id="accidentLocation" name="accidentLocation" class="sc-input" maxlength="100" value="">
								<span id="accidentLocation_And_OR" style="cursor: pointer;font: normal 12px simsun;color: #999;" onclick="span_AdvSearch_And_Or(this)">与</span>
							</td>
						</tr>
						<tr>
							<td style="width:30%;text-align:right">产品制造商信息</td>
							<td style="padding-left:20px;">
								<input type="text" id="productor" name="productor" class="sc-input" maxlength="100" placeholder="包括名称、地址等" value="">
								<span id="productor_And_OR" style="cursor: pointer;font: normal 12px simsun;color: #999;" onclick="span_AdvSearch_And_Or(this)">与</span>
							</td>
						</tr>
						<tr>
							<td style="width:30%;text-align:right">失效设备</td>
							<td style="padding-left:20px;">
								<input type="text" id="failureEquipment" name="failureEquipment" class="sc-input" maxlength="100" value="">
								<span id="failureEquipment_And_OR" style="cursor: pointer;font: normal 12px simsun;color: #999;" onclick="span_AdvSearch_And_Or(this)">与</span>
							</td>
						</tr>
						<tr>
							<td style="width:30%;text-align:right">失效部件</td>
							<td style="padding-left:20px;">
								<input type="text" id="failureComponent" name="failureComponent" class="sc-input" maxlength="100" value="">
								<span id="failureComponent_And_OR" style="cursor: pointer;font: normal 12px simsun;color: #999;" onclick="span_AdvSearch_And_Or(this)">与</span>
							</td>
						</tr>
						<tr>
							<td style="width:30%;text-align:right">应用环境</td>
							<td style="padding-left:20px;">
								<input type="text" id="applyEnv" name="applyEnv" class="sc-input" maxlength="100" value="">
								<span id="applyEnv_And_OR" style="cursor: pointer;font: normal 12px simsun;color: #999;" onclick="span_AdvSearch_And_Or(this)">与</span>
							</td>
						</tr>
						<tr>
							<td style="width:30%;text-align:right">失效形式</td>
							<td style="padding-left:20px;">
								<select id="failureBehave" onChange="Change_Select()" class="up_select">
									<option value="0">--请选择--</option>
									
									<c:forEach var="parentCate" items="${parentCateList}" varStatus="status">
								    	<option value="${parentCate.id }">${parentCate.name }</option>
								    </c:forEach>
								    
								</select>
							   
								<!--通过隐藏标签存失效形式的类别id -->
							    <input id="category" name="category" type="hidden" value=""/>
							</td>
						</tr>
						<tr>
							<td style="width:30%;text-align:right">失效机理</td>
							<td style="padding-left:20px;">
<!-- 								<input type="text" id="failureCause" name="failureCause" class="sc-input" maxlength="100" value=""> -->
 								<select id="failureCause" onChange="Change_Select2()" class="up_select"> 
							        <option value="0">--请选择--</option>
							    </select>
							</td>
						</tr>
						<tr>
							<td style="width:30%;text-align:right">失效材料类型</td>
							<td style="padding-left:20px;">
								<input type="text" id="failureMaterial" name="failureMaterial" class="sc-input" maxlength="100" value="">
								<span id="failureMaterial_And_OR" style="cursor: pointer;font: normal 12px simsun;color: #999;" onclick="span_AdvSearch_And_Or(this)">与</span>
							</td>
						</tr>
						<tr>
							<td style="width:30%;text-align:right">失效材料信息</td>
							<td style="padding-left:20px;">
								<input type="text" id="materialInfo" name="materialInfo" class="sc-input" maxlength="100"  placeholder="包括成分、力学性能等" value="">
								<span id="materialInfo_And_OR" style="cursor: pointer;font: normal 12px simsun;color: #999;" onclick="span_AdvSearch_And_Or(this)">与</span>
							</td>
						</tr>
						<tr>
							<td style="width:30%;text-align:right">事故概览</td>
							<td style="padding-left:20px;">
								<input type="text" id="accidentDescription" name="accidentDescription" class="sc-input" maxlength="100" value="">
								<span id="accidentDescription_And_OR" style="cursor: pointer;font: normal 12px simsun;color: #999;" onclick="span_AdvSearch_And_Or(this)">与</span>
							</td>
						</tr>
						<tr>
							<td style="width:30%;text-align:right">分析结论</td>
							<td style="padding-left:20px;">
								<input type="text" id="analyseConclusion" name="analyseConclusion" class="sc-input" maxlength="100" value="">
								<span id="analyseConclusion_And_OR" style="cursor: pointer;font: normal 12px simsun;color: #999;" onclick="span_AdvSearch_And_Or(this)">与</span>
							</td>
						</tr>
						
						<tr style="margin-bottom: 20px;" align="center">
							<td colspan="2"><input value="搜索" class="s_btn" type="button" onclick="searchAdv()"></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		
	</div>
  </body>
  <script type="text/javascript">
	function span_AdvSearch_And_Or(obj){
// 		var val=$("#"+obj.id).attr("value");
		var txt_An_or=obj.innerHTML;
		if(txt_An_or=="与"){
			obj.innerHTML="或";
		}else{
			obj.innerHTML="与";
		}
	}
	
    var isOut=1;
	function gaojisousuo(){//点击高级搜索后显示更多选项
		var v_display=document.getElementById("sc_adv").style.display;
		if(v_display=="none"){
			document.getElementById("sc_adv").style.display="block";
			$("#down_up").text("︿");
		}else{
			document.getElementById("sc_adv").style.display="none";
			$("#down_up").text("﹀");
		}
	} 
	function search(){
		var strSearch=document.getElementById("txtSearch").value;
		
		accidentName=strSearch;
		accidentTime=strSearch;
		accidentLocation=strSearch;
		productor=strSearch;
		failureEquipment=strSearch;
		failureComponent=strSearch;
		applyEnv=strSearch;
		category="";
// 		failureBehave=strSearch,
 		failureCause=strSearch;
		failureMaterial=strSearch;
		materialInfo=strSearch;
		accidentDescription=strSearch;
		analyseConclusion=strSearch;
// 		con="or";
		con="0";
		loadPageBar(true, 0);
	}
	
	function searchAdv(){
		var and_or="";
		$("#accidentName_And_OR").text()=="与"?and_or=and_or+"1":and_or=and_or+"0";
		and_or=and_or+"1";
		$("#accidentLocation_And_OR").text()=="与"?and_or=and_or+"1":and_or=and_or+"0";
		$("#productor_And_OR").text()=="与"?and_or=and_or+"1":and_or=and_or+"0";
		$("#failureEquipment_And_OR").text()=="与"?and_or=and_or+"1":and_or=and_or+"0";
		$("#failureComponent_And_OR").text()=="与"?and_or=and_or+"1":and_or=and_or+"0";
		$("#applyEnv_And_OR").text()=="与"?and_or=and_or+"1":and_or=and_or+"0";
		and_or=and_or+"11";
		$("#failureMaterial_And_OR").text()=="与"?and_or=and_or+"1":and_or=and_or+"0";
		$("#materialInfo_And_OR").text()=="与"?and_or=and_or+"1":and_or=and_or+"0";
		$("#accidentDescription_And_OR").text()=="与"?and_or=and_or+"1":and_or=and_or+"0";
		$("#analyseConclusion_And_OR").text()=="与"?and_or=and_or+"1":and_or=and_or+"0";
		
		accidentName=$("#accidentName").val();
		accidentTime=$("#accidentTime").val();
		accidentLocation=$("#accidentLocation").val();
		productor=$("#productor").val();
		failureEquipment= $("#failureEquipment").val();
		failureComponent= $("#failureComponent").val();
		applyEnv=$("#applyEnv").val();
		category= $("#category").val();
// 		failureBehave=$("#failureBehave").text();
 		failureCause= $("#failureCause").text();
		failureMaterial= $("#failureMaterial").val();
		materialInfo= $("#materialInfo").val();
		accidentDescription= $("#accidentDescription").val();
		analyseConclusion= $("#analyseConclusion").val();
// 		con="and";
		con=and_or;
		loadPageBar(true, 0);
		$("#sc_adv").hide();
		$("#down_up").text("﹀");
	}

	document.onclick = function(e){//点击页面空白处时将高级搜索层隐藏
		if(isOut==1 && document.getElementById("sc_adv").style.display == "block") {
			document.getElementById("sc_adv").style.display = "none";
			$("#down_up").text("﹀");
		}
     };
     
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
  </script>
</html>
