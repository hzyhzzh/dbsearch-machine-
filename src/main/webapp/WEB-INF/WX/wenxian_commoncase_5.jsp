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
		line-height:25px;
		height:25px;
		width:100px;
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
			<p>汽轮机AISI 410不锈钢翼型件失效分析</p>
			<h5>事故时间</h5>
			<p>不详</p>
			<h5>事故地点</h5>
			<p>不详</p>
		</div>
		
		<div class="container" id="right" style="width:576px; float:right;">
			<h5>失效形式</h5>
			<p>断裂</p>
			<h5>失效机理</h5>
			<p>腐蚀疲劳断裂</p>
			<h5>失效设备</h5>
			<p>汽轮机</p>
			
		</div>
		<div class="container" id="middle" style="width:1176px">
			<h5 style="margin:30px auto 0 auto;">失效部件</h5>
			<p style="margin:10px auto;text-align:center;">叶轮叶片</p>
			<div style="text-align:center; margin:0 auto 30px auto;">
				<img src="images/commoncase_5.png" alt="叶轮叶片" width="280px" height="180px" style="border-radius:5px">
			</div>
		</div>
		<div class="container" id="bottom" style="width:1176px">
			<h5>事故概览</h5>
			<p>由AISI 410不锈钢制成的汽轮机末级叶片翼型件上出现一个横向裂纹。裂纹的宽度超过90%叶片的宽度无法继续使用。用橡胶锤很容易把它分离成2个部分。</p>
			<h5>分析结论</h5>
			<p style="line-height:2em"}>
			从有限元分析结果表明，翼型件故障不能归结为设计的缺陷，几何缺陷或叶片阵列不匹配。发现的证据表明，翼型件的设计足以承受汽轮机低压端部的工作条件。固有频率不是故障的原因，因为研究的振动/频率模式与涡轮机的主工作频率都不匹配。
因此，翼型件的失败可以归因于用于连接翼面和拉筋的钎焊过程的不足。有缺陷的间隙设计，加工温度低，表面清洗差和有限的，或不存在的，真空条件导致不完整的材料填充和孔隙度和叶片-杆接头处的非金属颗粒。断裂起源于这样的界面，通过疲劳腐蚀机制传播。失效表面上所示的扫描电镜分析可知，叶片材料中的第二相夹杂物的存在也有助于裂纹扩展。

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