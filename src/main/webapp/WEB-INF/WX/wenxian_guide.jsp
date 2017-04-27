<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="dbsearch.domain.Paper"%>
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

<title>My JSP 'wenxian_guide.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script src="js/jquery.js"></script>
<script src="js/jquery-3.0.0.js"></script>
<script src="js/jquery-3.0.0.min.js"></script>
<script type="text/javascript" src="js/pptBox.js"></script>
<script type="text/javascript" src="js/md5.js"></script>
<link href="css/mricode.pagination.css" rel="stylesheet" />
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/index.css" rel="stylesheet" type="text/css" />
<link href="css/admin_login.css" rel="stylesheet" type="text/css" />
<link href="css/other.css" rel="stylesheet" type="text/css" />
<style type="text/css">
body {
	text-align: center
}

.box-shadow-left{  
-webkit-box-shadow:0 0 15px rgba(159,182,205, .5);  
  -moz-box-shadow:0 0 15px rgba(159,182,205, .5);  
  box-shadow:0 0 15px rgba(159,182,205, .5);  
	display:inline-block;
  width:273px;
  height:313px;
  margin-right:100px;
  border-right:3px;
vertical-align:top;
}  
.box-shadow-right{  
-webkit-box-shadow:0 0 15px rgba(159,182,205, .5);  
  -moz-box-shadow:0 0 15px rgba(159,182,205, .5);  
  box-shadow:0 0 15px rgba(159,182,205, .5);  
	display:inline-block;
  width:273px;
  height:313px;
  border-right:3px;
vertical-align:top;
} 
 
#links ul{text-align:center;list-style-type:none;}
.clearfix {
	width: 1200px;
	height: auto;
	margin: 0 auto;
}
.jb_title{color:#436EEE; 
font-weight:bold; 
 list-style:none;
 margin-bottom:5px;}
.div_inline{display:inline;width:330px;}
.jump-link {
	color: #777;
	text-decoration: none;
	float: left;
	display: inline;
	margin-top: 5px;
	font-family: "Lucida Console", Monaco, monospace, "微软雅黑";
}

.submit-btn {
	border: 0 none;
	width: 60px;
	height: 30px;
	line-height: 30px;
	font-size: 16px;
	color: #fff;
	text-align: center;
	background: #4ba0d7;
	border-radius: 3px;
	cursor: pointer;
	vertical-align: middle;
	font-family: "Lucida Console", Monaco, monospace, "微软雅黑";
}
.jc_line {
	width: 100%;
	border-bottom: 1px solid #ccc;
	margin-bottom: 10px;
}

.clear {
	clear: both;
	height: 1px;
	background:#fff;
}
</style>
</head>

<body>
	<div style="height: auto; text-align: left; font-size: 13px;">
		<jsp:include page="../YH/pagehead.jsp" flush="true" />
	</div>
	<div
		style="margin:0 auto; padding:0;width: 100%; height: auto; float: center;">
		<script>
				var box = new PPTBox();
				box.width =$("div").width(); //宽度
				box.height = box.width/3;//高度
				box.autoplayer = 6;//自动播放间隔时间

				//box.add({"url":"图片地址","title":"悬浮标题","href":"链接地址"})
				box.add({
					"url" : "images/scroll1.png",
					//"href" : "#",
					"title" : "悬浮提示标题1"
				})
				box.add({
					"url" : "images/scroll1.png",
					//"href" : "#",
					"title" : "悬浮提示标题2"
				})
				box.add({
					"url" : "images/scroll1.png",
					//"href" : "#",
					"title" : "悬浮提示标题3"
				})
				box.show();
			</script>
	</div>
	<div style="width:100%;height:60px;background:#fff;padding-top:60px;text-align:center;">
		<img src="images/huanggtouming.png" />
	</div>
	<div class="clear"></div>
	<div style="width:100%; margin:0px auto; background:#fff;height:330px;padding-bottom:30px;text-align:center;" >
		<div id="mid" style="width:auto;margin:0 auto;">
		<div class="box-shadow-left">
		<img  src="images/mid1.png">
		<div style="height:30px;"></div>
		<ul >
			<li class="jb_title"><center>常见失效分类</center></li>
			 <li><a href="/dbsearch/index1">应力集中  弹性变形  晶间腐蚀</a></li>
			 <li><a href="/dbsearch/index1">脆性断裂  塑性变形  缝隙腐蚀</a></li>
			 <li><a href="/dbsearch/index1">韧性断裂  应力松弛  局部腐蚀</a></li>
			 <li>......</li>
		</ul>
		</div>
		<div class="box-shadow-left">
		<img  src="images/mid2.png">
		<div style="height:30px;"></div>
		<ul>
		<li class="jb_title">典型案例</li>
			 <li ><a href="/dbsearch/wenxian_commoncase">疲劳</a></li>
			 <li ><a href="/dbsearch/wenxian_commoncase">断裂</a></li>
			 <li><a href="/dbsearch/wenxian_commoncase">腐蚀</a></li>
			 <li>.....</li>
		</ul>
		</div>
		
		
		<div class="box-shadow-right">
		<img  src="images/mid3.png">
		<div style="height:30px;"></div>
		<ul>
			 <li class="jb_title">最近上传</li>
			 <%!
			List<Paper> resultList;
		%>
		<%
			if(((List<Paper>)request.getAttribute("resultList")).size()>3){
				Collections.reverse(((List<Paper>)request.getAttribute("resultList")));	
				resultList=((List<Paper>)request.getAttribute("resultList")).subList(0,2);
		%>
			<c:forEach var="paperItem" end="2" items="${resultList}"  varStatus="status">
				<li style="white-space:nowrap;text-overflow:ellipsis;overflow: hidden;" >${paperItem.accidentName}</li>
			</c:forEach>
		<%
			}
			else{
		%>
				<li >无</li>
		<%
			}
		%>
		</ul>
		</div>
		</div>
	</div>
	<div style="clear: both;"></div>
	<div class="wmzxd">
    	<div class="wmzxd_content">
    		<span style="font-weight:bold;font-size:24px;font-familly:'微软雅黑'">关于我们</span>
    		<div style="margin-bottom:10px;margin-top:10px;">
    		<img src="images/huanggtouming.png"/>
            </div>
            <div class="wmzxd_info">
            	<div style="margin-bottom:40px"><img src="images/shouye_bottom.png" /></div>
                <div style="width:1000px;">
                	<p style="width:535px;text-align:center;color:#404040; font-size:15px;margin-left:240px;">我们致力于将机械领域内的失效案例联合互联网，从失效数据出发，进行失效机理物理分析，确定失效模式和失效机理。再进行失效根因分析，提出改进方案，实施形成预防措施。</p>
                </div>
            </div>
        </div>
        
    </div>
	
	
	
	<div style="clear: both;"></div>
	<div class="div_foot_container">
		<jsp:include page="../YH/pagefoot.jsp" flush="true" />
	</div>
</body>
<script src="js/mricode.pagination.js"></script>
<script type="text/javascript">
</script>
</html>


