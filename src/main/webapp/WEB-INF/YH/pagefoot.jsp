<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'pagefoot.jsp' starting page</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8 ">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="css/other.css" rel="stylesheet" type="text/css" />
<link href="css/index.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.span_foot{
color:#fff;
 line-height:100%
}
</style>
</head>

<body>
	<div class="e_foot">
		<div class="foot_content">
			<ul class="first">
				<li class="bzzx"><a href="#">关于</a></li>
				<li><a href="#">关于我们</a></li>
				<li><a href="#">加入我们</a></li>
			</ul>

			<ul>
				<li class="zxzx"><a href="#">服务</a></li>
				<li><a href="#">服务条款</a></li>
				<li><a href="#">隐私协议</a></li>

			</ul>
			<ul>
				<li class="gywm"><a href="#">产品</a></li>
				<li><a href="#">如何使用</a></li>
				<li><a href="#">更新历史</a></li>
				<li><a href="#">FAQ</a></li>
			</ul>
			<div style="width:300px;height:160px;float:right;">
				<div style="width:100%;height:20;border-bottom:2px solid white;color:#fff;padding-bottom:5px;margin-bottom:5px;text-align:left;">
				联系方式
				</div>
				<div style="float:left; display:inline;width:140px;height:30px;background:url(images/FACEBOOK.png) no-repeat 5% 0 "><span class="span_foot">Facebook</span></div>
				<div style="float:left; display:inline;width:140px;height:30px;background:url(images/qq.png) no-repeat 5% 0 "><span class="span_foot">QQ</span></div>
				<div style="float:left; display:inline;width:140px;height:30px;background:url(images/twitter.png) no-repeat 5% 0 "><span class="span_foot">Twitter</span></div>
				<div style="float:left; display:inline;width:140px;height:30px;background:url(images/weixin.png) no-repeat 5% 0"><span class="span_foot">Weixin</span></div>
				<div style="float:left; display:inline;width:140px;height:30px;background:url(images/GOOGLE.png) no-repeat 5% 0"><span class="span_foot">Google+</span></div>
				<div style="float:left; display:inline;width:140px;height:30px;background:url(images/weibo.png) no-repeat 5% 0 "><span class="span_foot">Weibo</span></div>
				<div style="float:left; display:inline;width:140px;height:30px;background:url(images/IN.png) no-repeat 5% 0"><span class="span_foot">Linkedln</span></div>
				<div style="float:left; display:inline;width:140px;height:30px;background:url(images/code.png) no-repeat 5% 0 "><span class="span_foot">二维码</span></div>
			
			</div>
			<div style="clear: both;"></div>

			<div class="copyright">
				copyright&nbsp;
				2017&nbsp;&nbsp;&copy;&nbsp;&nbsp;华东理工大学&nbsp;&nbsp;版权所有&nbsp;&nbsp;
			</div>
		</div>
	</div>

</body>
<script type="text/javascript">
	
</script>
</html>
