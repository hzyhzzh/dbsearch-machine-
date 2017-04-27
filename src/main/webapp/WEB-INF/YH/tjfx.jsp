<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ page language="java" import="dbsearch.domain.PaperField"%>
<%@ page language="java" import="dbsearch.domain.FieldKeyword"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<title>Insert title here</title>

<style type="text/css">
.tb_gjc{
	width:100%;
}
.tb_gjc tr th {
    line-height: 40px;
    border-bottom: 1px solid rgb(200,200,200);
    border-top: 1px solid rgb(200,200,200);
    font-weight: normal;
}
.tb_gjc tr td {
    line-height: 30px;
    border-top: 1px solid #e9edf3;
    padding-left: 10px;
    padding-right: 10px;
}
</style>
</head>
<body>
	<div id="fileSearch" style="">
	<table style="width:100%;border:none;padding-top:10px;padding-bottom:10px;">
		<tr style="width:100%;height:40px;">
			<td width="25%" height="40px" align="right">失效设备：</td>
			<td width="25%" height="40px" align="left">
				<input id="failureEquipment" style="width:250px;height:30px;line-height:30px;font-size:120%;"><br>
			</td>
			
			<td width="25%" height="40px" align="right">失效形式：</td>
			<td width="25%" height="40px" align="left">
				<select id="slt_parent" onChange="Change_Select()" class="up_select">
					<option value="0">--请选择--</option>
					
					<c:forEach var="parentCate" items="${parentCateList}" varStatus="status">
				    	<option value="${parentCate.id }">${parentCate.name }</option>
				    </c:forEach>
				    
				</select>
				<!--通过隐藏标签存失效形式的类别id -->
			    <input id="category" name="category" type="hidden" value=""/>
			</td>
		</tr>
		<tr style="width:100%;height:40px;">
			<td width="25%" height="40px" align="right">失效部件：</td>
			<td width="25%" height="40px" align="left">
				<input id="failureComponent" style="width:250px;height:30px;line-height:30px;font-size:120%;"><br>
			</td>
			
			<td width="25%" height="40px" align="right">失效机理：</td>
			<td width="25%" height="40px" align="left">
			    <select id="slt_child" onChange="Change_Select2()" class="up_select"> 
			        <option value="0">--请选择--</option>
			    </select>
			</td>
		</tr>
		<tr style="width:100%;height:40px;">
			<td width="25%" height="40px" align="right">失效材料类型：</td>
			<td width="25%" height="40px" align="left" colspan="3">
				<input id="failureMaterial" style="width:250px;height:30px;line-height:30px;font-size:120%;"><br>
			</td>
		</tr>
		<tr>
			<td colspan="4" height="60px" align="center">
				<button type="button" onclick="doTJFXSearch()" class="s_btn" style="width:100px;height:30px;">查询</button>
			</td>
		</tr>
	</table>
	</div>
	
	<div>
		
		<table class="tb_gjc">
			<tr>
				<th width="20%" style="border-right: 1px solid #e9edf3;">字段名</th>
				<th width="80%" colspan="2">关键词</th>
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
				<td align="center" width="20%" style="border-right: 1px solid #e9edf3;">
					<%=paperField.getTitle() %>
				</td>
				<td align="left" width="80%">
				<%
					keywordList=(List<FieldKeyword>)fieldMap.get(paperField.getName());
					if(!keywordList.isEmpty()){
						for(int k=0;k<keywordList.size();k++){
							fieldKeyword=(FieldKeyword)keywordList.get(k);
				%>
					<input name="chk_keyword" type="checkbox" value="<%=fieldKeyword.getId() %>" checked
						style="padding-left:15px;padding-right:5px;" onclick=""/><%=fieldKeyword.getKeyWord() %>
				<%}} %>
				</td>
			</tr>
			
			<%}} %>
		</table>
		<table style="width:100%;border-top:1px solid rgb(200,200,200);border-bottom:1px solid rgb(200,200,200);padding-top:5px;padding-bottom:30px;">
			<tr>
				<td><span style="float:right;color:rgb(150,150,150)">
					<a onclick="setAllChecked()"><font style="color:#0a80da;font-size:14;cursor:pointer;">全选</font></a>
					/
					<a onclick="setAllUnchecked()"><font style="color:#0a80da;font-size:14;cursor:pointer;">全不选</font></a>
				</span></td>
			</tr>
			<tr>
				<td width="100%" height="40px" align="center">
					<button type="button" onclick="doDraw()" class="s_btn" style="width:100px;height:30px;margin-right:50px;">绘图</button>
					<button type="button" class="s_btn" style="width:100px;height:30px;" onclick="doGetKeyWordsPage()">关键词管理</button>
				</td>
			</tr>
		</table>
	</div>

	<div id="TJFXContent"></div>
	<!-- 			分页设置                        -->
<!-- 	<div id="TJFXPageBar" class="m-pagination" style="margin: 0 auto;"></div> -->
	<div id="pageDir" align="right" style="padding-top:20px;"></div>

	<div id="diagram" style="margin-top:20px;border-top:solid 1px rgb(200, 200, 200);"></div>
</body>
<!-- <link href="css/mricode.pagination.css" rel="stylesheet" /> -->
<!-- <script src="js/mricode.pagination.js"></script> -->
<script type="text/javascript">
var inputs = document.getElementsByTagName("input");//获取所有的input标签对象
var chk = [];//初始化空数组，用来存放checkbox对象。
for(var i=0;i<inputs.length;i++){
  var obj1 = inputs[i];
  if(obj1.type=='checkbox'){
	  chk.push(obj1);
  }
}
function setAllChecked(){
	for (var i = 0; i < chk.length; i++)
	 	chk[i].checked = true;
}
function setAllUnchecked(){
	for (var i = 0; i < chk.length; i++)
	 	chk[i].checked = false;
}

currentPageIndex = 0;
function loadTJFXPageBar(forceReload, startIndex) {
	startIndex = startIndex || 0;
	currentPageIndex = startIndex;
/*  	if ($("#TJFXPageBar").pagination()) {
		if (forceReload)
			$("#TJFXPageBar").pagination('destroy');
		else
			return;
	}  */
	var data = {
		failureEquipment:$("#failureEquipment").val(),//失效形式
		failureComponent:$("#failureComponent").val(),//失效部件
		failureMaterial:$("#failureMaterial").val(),//失效材质
		cateId:$("#category").val()//失效机理
	};
	$.ajax({
		type : "post",
		async : false, //同步请求
		url : "ajax/getTJFXCount",
		data : data,
		success : function(dt) {
			/* $("#TJFXPageBar").pagination({
				pageSize : 10,
				total : dt,
				firstBtnText : '首页',
				lastBtnText : '尾页',
				prevBtnText : '上一页',
				nextBtnText : '下一页',
				pageIndex : startIndex
			}).on("pageClicked", function(event, pageObj) {
				currentPageIndex = pageObj.pageIndex;
	 			loadPaperList(pageObj.pageIndex + 1);
			}); */
// 			loadPaperList(startIndex + 1);
			initializePageNav(startIndex+1,dt);
	 		
		},
		error : function() {
			
		}
	});
}
loadTJFXPageBar(false);

function loadPaperList(pageIndex){
	var url =  "/dbsearch/searchTJFX";
	var data = {
		failureEquipment:$("#failureEquipment").val(),
		failureComponent:$("#failureComponent").val(),
		failureMaterial:$("#failureMaterial").val(),
		cateId:$("#category").val(),
		pageIndex:pageIndex
	};
	$.ajax({
		type : "post",
		async : false, //同步请求
		url : url,
		data : data,
		success : function(datas) {
			$("#TJFXContent").html(datas);//要刷新的div
		},
		error : function() {
			
		}
	});
}

function doTJFXSearch(){
 	loadTJFXPageBar(true,0);
// 	loadPaperList(0);
}

function doDraw(){
	var gjcStr="";
	for (var i = 0; i < chk.length; i++) {
		if(chk[i].checked == true){
			gjcStr=gjcStr+chk[i].value+"&";
	 	}
 	}
	
	var url =  "/dbsearch/Jump2Analysis";
	var data = {
		failureEquipment:$("#failureEquipment").val(),
		failureComponent:$("#failureComponent").val(),
		failureMaterial:$("#failureMaterial").val(),
		cateId:$("#category").val(),
		gjcStr:gjcStr
	};
	$.ajax({
		type : "post",
		async : false, //同步请求
		url : url,
		data : data,
		success : function(datas) {
			$("#diagram").html(datas);//要刷新的div
		},
		error : function() {
			
		}
	});
}

function doGetKeyWordsPage(){
	var url =  "/dbsearch/TJFX_GetKeyWords";
	var data = {
		
	};
	$.ajax({
		type : "get",
		async : false, //同步请求
		url : url,
		data : data,
		success : function(datas) {
			$("#gly_main_tjfx").html(datas);//要刷新的div
		},
		error : function() {
			
		}
	});
}

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


function initializePageNav(iCurrPage,iProCount){
	loadPaperList(iCurrPage);
	var iPageSize =10;
	var b = ((iProCount%iPageSize)!=0);
	var iPageCount = parseInt(iProCount/iPageSize)+(b?1:0);
	
	if (iCurrPage > iPageCount) return false;
		iCurrPage = parseInt(iCurrPage);
	var sTemp = "";
	var sTemp1 = "每页:"+ iPageSize +"/<span style='color:red'>"+ iProCount +"</span>条  页数:<span style='color:blue'>"+ iCurrPage +"</span>/"+ iPageCount +"页";
	var sTemp2 = "<input type=\"text\" id=\"goPageNo\" value=\""+iCurrPage+"\" size=\"3\" /><a onclick=\"goPage("+iProCount+");\" >GO</a>";
	if (iProCount==0){
		sTemp = "<font color='#cccccc'>首页 上一页 下一页 末页</font>";
	}else if (iPageCount==1){
		sTemp = "<font color='#cccccc'>首页 上一页 下一页 末页</font>";
	}else if (iPageCount==iCurrPage){
	  	sTemp = "<a href='Javascript:initializePageNav(1,"+iProCount+")'>首页</a> <a href='Javascript:initializePageNav("+(iPageCount-1)+","+iProCount+")'>上一页</a> <font color='#cccccc'>下一页 末页</font>";
	}else if (iCurrPage==1){
	  	sTemp = "<font color='#cccccc'>首页 上一页 </font><a href='Javascript:initializePageNav("+(iCurrPage+1)+","+iProCount+")'>下一页</a> <a href='Javascript:initializePageNav("+iPageCount+","+iProCount+")'>末页</a>";
	}else{
	  	sTemp = "<a href='Javascript:initializePageNav(1,"+iProCount+")'>首页</a> <a href='Javascript:initializePageNav("+(iCurrPage-1)+","+iProCount+")'>上一页</a> <a href='Javascript:initializePageNav("+(iCurrPage+1)+","+iProCount+")'>下一页</a> <a href='Javascript:initializePageNav("+(iPageCount)+","+iProCount+")'>末页</a>";
	}
	document.getElementById("pageDir").innerHTML = sTemp +"  "+ sTemp2 + "  " + sTemp1 ;
}
function goPage(iProCount){
	var pageNum=$("#goPageNo").val();
	var iPageSize =10;
	var b = ((iProCount%iPageSize)!=0);
	var iPageCount = parseInt(iProCount/iPageSize)+(b?1:0);
	if(parseInt(pageNum)>parseInt(iPageCount)){
		initializePageNav(iPageCount,iProCount);
	}else{
		initializePageNav($("#goPageNo").val(),iProCount);
	}
}
$("input[id='goPageNo']").keyup(function(){      
    var tmptxt=$(this).val();
  $(this).val(tmptxt.replace(/\D|^0/g,''));      
}).bind("paste",function(){
    var tmptxt=$(this).val();      
    $(this).val(tmptxt.replace(/\D|^0/g,''));      
}).css("ime-mode", "disabled");
</script>
</html>