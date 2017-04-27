<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="dbsearch.domain.Paper"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>常见案例</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="shortcut icon" href="images/tablogo.ico" type="image/x-icon" />
<link href='<c:url value="/css/css.css" />' rel="stylesheet"
	type="text/css" />
<link href='<c:url value="/css/other.css" />' rel="stylesheet"
	type="text/css" />
	<link href='<c:url value="/css/index.css" />' rel="stylesheet"
	type="text/css" />
<style>
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
	
	.jc_line {
		width: 100%;
		border-bottom: 1px solid #ccc;
		margin-bottom: 0px;
	}
	
	.clear {
		clear: both;
		height: 1px;
	}
	.failureExample{
		
		width:1000px;
		height:300px;
		margin:50px auto;
	}
	td{
		text-align:center;
		
	}
	a:link, a:visited {
	    color:blue;
	    text-decoration:underline;
	}    

	a:hover, a:active {
	    color:#000000;
	    text-decoration:none;
	}
	#content{
		margin:0 auto;
		width:1200px;
	}
	.container{
		background-color:white;
		border-radius:5px;
		border:1px solid #E0E0E0;
		margin:10px;
		float:left;
		text-align:left;
	}
	h5{
		background-color:#D2E9FF;
		color:#2894FF;
		font-size:14px;
		text-align:center;
		line-height:20px;
		height:20px;
		width:75px;
		margin:20px auto 0 30px;
	}
	p{
		font-size:15px;
		color:#7B7B7B;
		
		align:right;
		text-indent:0;
		margin:10px auto 20px 30px;
	}
</style>
</head>

<body>
	<div class="div_head_container">
		<jsp:include page="../YH/pagehead.jsp" flush="true" />
	</div>
	<div style=" padding-top:20px; margin:0 auto 20px auto;">
		<div style="background:url(images/commoncase_title.png)no-repeat;width:319px;height:75px;margin:0 auto;">
			<span style="color:white;font-size:37px;font-weight:bold;line-height:55px">常见失效案例</span>
		</div>
	</div>
	<div id="content">
		<div class="container" id="left"  style="width:576px">
			<h5>事故名称</h5>
			<p>电站锅炉过热器管的失效分析与改造</p>
			<h5>事故时间</h5>
			<p>2006.7、2009.5</p>
			<h5>事故地点</h5>
			<p>伊朗 萨哈德 2*325MW发电厂</p>
		</div>
		
		<div class="container" id="right" style="width:576px; float:right;">
			<h5>失效形式</h5>
			<p>断裂</p>
			<h5>失效机理</h5>
			<p>高温蠕变开裂</p>
			<h5>失效设备</h5>
			<p>电厂电站（锅炉过热器）</p>
			
		</div>
		<div class="container" id="middle" style="width:1176px">
			<h5 style="margin:30px auto 0 auto;">失效部件</h5>
			<p style="margin:10px auto;text-align:center;">电站锅炉过热器管</p>
			<div style="text-align:center; margin:0 auto 30px auto;">
				<img src="images/guoreqiguan.png" alt="过热器管" width="280px" height="180px" style="border-radius:5px">
			</div>
		</div>
		<div class="container" id="bottom" style="width:1176px">
			<h5>事故概览</h5>
			<p>萨哈德电站启用于2004年，1号和2号锅炉机组过热器和回热器的蒸汽温度一直处于检测状态，但问题是锅炉燃料（重质油或者天然气）的投放量与设计值不符。</p>
			<h5>分析结论</h5>
			<p style="line-height:2em"}>
			1、失效过热管在多个部分发生弯曲<br>
			2、过热管外表面包覆着相当厚的沉淀物<br>
			3、过热管化学成分并未发生改变<br>
			4、X射线荧光分析显示沉淀物中存在高含量量的有害元素，如S、V、Na，表明所使用的重质油是不合格的。<br>
			5、过热管的平均操作温度为596℃，超过设计值540℃<br>
			6、平均喷淋水质量流率超过设计值<br>
			7、微观组织分析表明失效区的微观组织结构球状化已经很严重<br>
			8、管子在失效前已在高温下服役超过预计蠕变断裂时间的80%
			</p>
		</div>
	</div>
	<div style="clear: both;"></div>
	<div class="div_foot_container">
		<jsp:include page="../YH/pagefoot.jsp" flush="true" />
	</div>

</body>
<script type="text/javascript">


</script>
</html>