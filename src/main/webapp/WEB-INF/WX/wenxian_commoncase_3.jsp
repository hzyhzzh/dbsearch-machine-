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
			<p>100万千瓦超超临界火电机组双相不锈钢循环水泵的失效分析</p>
			<h5>事故时间</h5>
			<p>2012年</p>
			<h5>事故地点</h5>
			<p>中国嘉兴</p>
		</div>
		
		<div class="container" id="right" style="width:576px; float:right;">
			<h5>失效形式</h5>
			<p>断裂</p>
			<h5>失效机理</h5>
			<p>疲劳</p>
			<h5>失效设备</h5>
			<p>电厂电站（循环水泵）</p>
			
		</div>
		<div class="container" id="middle" style="width:1176px">
			<h5 style="margin:30px auto 0 auto;">失效部件</h5>
			<p style="margin:10px auto;text-align:center;">泵的筒体和法兰</p>
			<div style="text-align:center; margin:0 auto 30px auto;">
				<img src="images/commoncase_3.png" alt="法兰" width="280px" height="180px" style="border-radius:5px">
			</div>
		</div>
		<div class="container" id="bottom" style="width:1176px">
			<h5>事故概览</h5>
			<p>浙江嘉兴大型火力发电厂三期有两台（编号为7号和8号）100万千瓦超超临界发电机组，各配备三台立式循环水系（A，B，C），由日本日立泵制造有限公司设计制造，设计寿命为30年，然而两台机组循环水泵投入运行不到1年，先后发生了多次运行状态不正常现象，导致厂方不得不采取非正常的停机检修措施。观察到循环水泵出现了大量严重的断裂。</p>
			<h5>分析结论</h5>
			<p style="line-height:2em"}>
			1、焊缝坡口设计不当引起的未焊透明显降低了焊缝的强度和抗疲劳性能，这是引起循环水泵断裂最重要的原因。<br>
			2、焊缝处铁素体含量过高，应该是焊接工艺不当引起的，降低了冲击韧性和抗疲劳性能，是失效的另一个重要原因。用于循环水泵法兰和筒体的基体材料是合格的，表明失效不是因为基材。<br>
			3、伴随着泵操作引起的不可避免的循环载荷，裂纹起源于焊缝未焊透的交叉处，沿着法兰焊缝扩展，最终当它达到一定长度时法兰发生断裂。<br>
			4、法兰断裂后，整个外壳出现了一个不平衡导致其它严重的断裂。因此，裂纹发生在基材属于二次断裂。
			
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