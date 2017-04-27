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
			<p>汽车曲轴的失效分析</p>
			<h5>事故时间</h5>
			<p>不详</p>
			<h5>事故地点</h5>
			<p>葡萄牙</p>
		</div>
		
		<div class="container" id="right" style="width:576px; float:right;">
			<h5>失效形式</h5>
			<p>断裂</p>
			<h5>失效机理</h5>
			<p>装配不当，弯曲疲劳</p>
			<h5>失效设备</h5>
			<p>车（柴油汽车发动机）</p>
			
		</div>
		<div class="container" id="middle" style="width:1176px">
			<h5 style="margin:30px auto 0 auto;">失效部件</h5>
			<p style="margin:10px auto;text-align:center;">曲轴</p>
			<div style="text-align:center; margin:0 auto 30px auto;">
				<img src="images/commoncase_4.png" alt="曲轴" width="280px" height="180px" style="border-radius:5px">
			</div>
		</div>
		<div class="container" id="bottom" style="width:1176px">
			<h5>事故概览</h5>
			<p>失效的曲柄轴属于一台90马力的柴油汽车的发动机。经过三年的常规运行，柴油汽车发动机出现故障，原因是曲轴的2号曲柄销咬粘。发动机在未授权的机械车间进行了修理，包括对曲柄销的深度整改。跑了30000千米后，发动机再次发生损坏。</p>
			<h5>分析结论</h5>
			<p style="line-height:2em"}>
			曲柄销的断面形貌清晰的表明疲劳是曲柄销严重失效的根本原因。曲柄销圆角的裂纹萌生区域在基体金属和外加金属合金层的交界面，并且由于焊接的硬化微观组织而加重。外加金属合金层没有热处理以及曲轴可能存在的偏差，造成了过早的严重失效。当曲轴销发生咬粘，去除的材料超过了制造商推荐的尺寸限制的时候，就应该重新更换一个新的曲轴而不是添加金属合金层。
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