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
		border:1px solid #E0E0E0;
		width:1063px;
		height:600px;
		margin:20px auto;
		background-color:white;
		border-radius:5px;
		padding-top:25px;
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
	.img_case{
		border-radius:5px;
		width:300px;
		height:200px;
		margin:20px 25px;
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
	<div class="failureExample" >
		<table>
			<tbody>
				<tr>
					<td><img  class="img_case" src="images/commoncase_1.png" alt="断裂——高温蠕变开裂" width="300px" height="200px"></td>
					<td><img  class="img_case" src="images/commoncase_2.png" alt="断裂——腐蚀过热" width="300px" height="200px"></td>	
					<td><img  class="img_case" src="images/commoncase_3.png" alt="断裂——疲劳" width="300px" height="200px"></td>	
				</tr>
				<tr >
					<td><a href="/dbsearch/WX/wenxian_commoncase_1">断裂——高温蠕变开裂</a></td>
					<td><a href="/dbsearch/WX/wenxian_commoncase_2">断裂——腐蚀过热</a></td>
					<td><a href="/dbsearch/WX/wenxian_commoncase_3">断裂——疲劳</a></td>
				</tr>
				<tr><td colspan="3"><br><br></td></tr>
				<tr>
					<td><img  class="img_case" src="images/commoncase_4.png" alt="断裂——疲劳弯曲" width="300px" height="200px"></td>
					<td><img  class="img_case" src="images/commoncase_5.png" alt="断裂——疲劳腐蚀" width="300px" height="200px"></td>	
					<td><img  class="img_case" src="images/commoncase_6.png" alt="断裂——疲劳断裂" width="300px" height="200px"></td>	
				</tr>
				<tr>
					<td><a href="/dbsearch/WX/wenxian_commoncase_4">断裂——疲劳弯曲</a></td>
					<td><a href="/dbsearch/WX/wenxian_commoncase_5">断裂——疲劳腐蚀</a></td>
					<td><a href="/dbsearch/WX/wenxian_commoncase_6">断裂——疲劳断裂</a></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div style="clear: both;"></div>
	<div class="div_foot_container">
		<jsp:include page="../YH/pagefoot.jsp" flush="true" />
	</div>



</body>
<script type="text/javascript">
</script>
</html>