<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>失效案例搜索</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script src="js/jquery.js"></script>
<script src="js/jquery.min.js"></script>
<link href="css/mricode.pagination.css" rel="stylesheet" />
<link href="css/index.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="images/tablogo.ico" type="image/x-icon" />
<link href="css/css.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.clearfix {
	width: 1400px;
	height: auto;
	padding: 0px;
	margin: 0px;
	text-align:center;
}

</style>

</head>

<body>
	<div class="div_head_container">
		<jsp:include page="../YH/pagehead.jsp" flush="true" />
	</div>
	<div class="clearfix">
		<div id="wrapper">
			<div id="search_wrap">
				<jsp:include page="wenxian_search.jsp" flush="true" />
			</div>
	
		</div>
		<div style="margin-bottom:15px;"></div>
		<div id="menu_wrap">
			<jsp:include page="wenxian_menu.jsp" flush="true" />
		</div>
		<div id="list_wrap">
			<div id="paperContent"><jsp:include page="wenxian_list.jsp"
					flush="true" /></div>

			<!-- 			分页设置                        -->
			<div id="pageBar" class="m-pagination" style="margin: 0 auto;"></div>
		</div>
	</div>
	<div style="clear: both;"></div>
	<div class="div_foot_container">
		<jsp:include page="../YH/pagefoot.jsp" flush="true" />
	</div>
</body>
<script src="js/mricode.pagination.js"></script>
<script type="text/javascript">
var accidentName=$("#accidentName").val();
var accidentTime=$("#accidentTime").val();
var accidentLocation=$("#accidentLocation").val();
var productor=$("#productor").val();
var failureEquipment= $("#failureEquipment").val();
var failureComponent= $("#failureComponent").val();
var applyEnv=$("#applyEnv").val();
var category= $("#category").val();
// var failureBehave=$("#failureBehave").text();
// var failureCause=$("#failureCause").text();
var failureCause= $("#failureCause").val();
var failureMaterial= $("#failureMaterial").val();
var materialInfo= $("#materialInfo").val();
var accidentDescription= $("#accidentDescription").val();
var analyseConclusion= $("#analyseConclusion").val();
var con="and";

currentPageIndex = 0;
function loadPageBar(forceReload, startIndex) {
	var searchData = {
			accidentName: accidentName,
			accidentTime: accidentTime,
			accidentLocation: accidentLocation,
			productor: productor,
			failureEquipment: failureEquipment,
			failureComponent: failureComponent,
			applyEnv: applyEnv,
			category: category,
// 			failureBehave:failureBehave,
// 			failureCause:failureCause,
			failureCause: failureCause,
			failureMaterial: failureMaterial,
			materialInfo: materialInfo,
			accidentDescription: accidentDescription,
			analyseConclusion: analyseConclusion,
			con: con
		};
	startIndex = startIndex || 0;
	currentPageIndex = startIndex;
	if ($("#pageBar").pagination()) {
		if (forceReload){
			$("#pageBar").pagination('destroy');
		}
		else
			return;
	}
	$.ajax({
		type : "post",
		async : false, //同步请求
		url : "/dbsearch/searchCount",
		data : searchData,
		success : function(data, status) {
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
	 			loadPaperList(currentPageIndex + 1);
			});
	 		loadPaperList(startIndex + 1);
		}
	});
}
loadPageBar(false,0);


function loadPaperList(pageIndex){
	var searchData = {
			accidentName: accidentName,
			accidentTime: accidentTime,
			accidentLocation: accidentLocation,
			productor: productor,
			failureEquipment: failureEquipment,
			failureComponent: failureComponent,
			applyEnv: applyEnv,
			category: category,
// 			failureBehave:failureBehave,
// 			failureCause:failureCause,
			failureCause: failureCause,
			failureMaterial: failureMaterial,
			materialInfo: materialInfo,
			accidentDescription: accidentDescription,
			analyseConclusion: analyseConclusion,
			con: con,
			pageIndex: pageIndex
		};
	var _url =  "/dbsearch/search";
	$.ajax({
		type : "post",
		async : false, //同步请求
		url : _url,
		data : searchData,
		success : function(datas) {
			$("#paperContent").html(datas);//要刷新的div
		},
		error : function() {
			
		}
	});
}	

</script>
</html>
