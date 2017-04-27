<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@	taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@	taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" import="dbsearch.service.impl.CategoryService"%>
<%@ page language="java" import="dbsearch.domain.Category"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'wenxian_menu.jsp' starting page</title>
    
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
	<link href="css/css.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		body{
			font-family:综艺体; 
			font-size:16px; 
		}
		.menu_lev1{
			height:50px;
			width:auto;
			line-height: 50px;
			border-top:solid 1px rgb(200,200,200);
			background:url(images/doc.png) no-repeat 20% 50%;
		}
		.menu_super_span{
		
		}
		.menu_lev1_span{
			margin-left:0px;
		}
		.menu_lev2{
			height:50px;
			width:auto;
			line-height: 50px;
			border-top:solid 1px rgb(200,200,200);
			background:url(images/fushi.png) no-repeat 20% 50%;
		}
		.menu_lev2_span{
			margin-left:35px;
		}
	</style>

  </head>
  
  <body>
    <div style="width:60%;margin-left:100px;background-color:rgb(255,255,255);border:solid 1px rgb(200,200,200);">
    	<div style="height:50px;width:auto;line-height: 50px;padding-left:-35px;background-color:rgb(80,80,80);" 
    		onclick="do_menu_Super() " onmouseover="this.style.cursor='hand'">
    		<span class="menu_super_span" style="color:rgb(255,255,255);">全部文档</span>
    	</div>
 		<%!
 			List<List<Category>> menuList;
 			CategoryService categoryService;
 			Category tempCategory;
 		%>
 		
 		<%
//  			menuList=(List<List<Category>>)session.getAttribute("cateList");
 			menuList=(List<List<Category>>)request.getAttribute("cateList");
 			List<Category> subList;
 			if(!menuList.isEmpty()){
	 			for(int i=0;i<menuList.size();i++){
	 				subList=menuList.get(i);
	 				tempCategory=subList.get(0);//一级标题
	 	%>
	 	<div id="menu_lev1" class="menu_lev1" onmouseover="this.style.cursor='hand'" ondblclick="do_menu_Super()" onclick="do_menu_lev1(<%=tempCategory.getId() %>)">
    		<span id="span_lev1_<%=tempCategory.getId() %>" class="menu_lev1_span"><%=strCute(tempCategory.getName()) %></span>
    	</div>
    	<div id="menu_lev1_Sub_id_<%=tempCategory.getId() %>" name="menu_lev1_Sub" style="display:none;">
	 	<%			
	 				for(int k=1;k<subList.size();k++){
	 					tempCategory=subList.get(k);//二级标题
	 	%>
	 		<div class="menu_lev2" onmouseover="this.style.cursor='hand'"  onclick="do_menu_lev2(<%=tempCategory.getId() %>)">
	    		<span id="span_lev2_<%=tempCategory.getId() %>" class="menu_lev2_span"><%=strCute(tempCategory.getName()) %></span>
	    	</div>
	 	<%
	 				}
	 	%>
	 	</div>
	 	<%
	 			}
 			}
 		%>
 		
 		<%!
 		String strCute(String inStr){
 			if(inStr.contains("(")){
 				return inStr.substring(0, inStr.indexOf('('));
 			}else if(inStr.contains("（")){
 				return inStr.substring(0, inStr.indexOf('（'));
 			}else{
 				return inStr;
 			}
 		}
 		%>
    </div>
    <script type="text/javascript">
	    function do_menu_Super(){
			doHide_menu_lev1_Sub();
			menuCSS("");
			ajax_ref_list("");
		}
 	    function do_menu_lev1(id){
    		doHide_menu_lev1_Sub();
    		var divId="menu_lev1_Sub_id_"+id;
    		document.getElementById(divId).style.display = "block";
//     		window.location.href = "/dbsearch/searchCate?strCate="+id;
			var spanId="span_lev1_"+id;
			menuCSS(spanId);
			
    		ajax_ref_list(id);
    	}
    	
    	
    	
    	function do_menu_lev2(id){
//     		window.location.href = "/dbsearch/searchCate?strCate="+id;
			var spanId="span_lev2_"+id;
			menuCSS(spanId);
			
    		ajax_ref_list(id);
    	}
    	function menuCSS(spanId){
    		var menu_lev1_span=$(".menu_lev1_span");
    		for(var i=0;i<menu_lev1_span.length;i++){
    			menu_lev1_span[i].style.backgroundColor="#fff";
    			menu_lev1_span[i].style.color="#000";
    		}
    		var menu_lev2_span=$(".menu_lev2_span");
    		for(var i=0;i<menu_lev2_span.length;i++){
    			menu_lev2_span[i].style.backgroundColor="rgb(242,242,242)";
    			menu_lev2_span[i].style.color="#000";
    		}
    		if(spanId!=null&&spanId!=""){
	    		document.getElementById(spanId).style.backgroundColor="#505767";
	 			document.getElementById(spanId).style.color="#fff";
    		}
    	}
    	
    	
    	/* function ajax_ref_list(id){//ajax刷新右侧文献列表
    		var url = "/dbsearch/searchCate?strCate="+id;
    		var data = {
    			type : 1
    		};
    		$.ajax({
    			type : "post",
    			async : false, //同步请求
    			url : url,
    			data : data,
    			success : function(dates) {
    				//alert(dates);
    				$("#list_wrap").html(dates);//要刷新的div
    			},
    			error : function() {
    				alert("失败，请稍后再试！");
    			}
    		});
    	} */
    	function ajax_ref_list(id){
    		accidentName="";
    		accidentTime="";
    		accidentLocation="";
    		productor="";
    		failureEquipment= "";
    		failureComponent= "";
    		applyEnv="";
    		category= id;
    		failureCause= "";
    		failureMaterial= "";
    		materialInfo= "";
    		accidentDescription= "";
    		analyseConclusion= "";
//     		con="and";
			con="1111111111111";
    		loadPageBar(true, 0);
    	}
    	function doHide_menu_lev1_Sub(){
    		var arr=document.getElementsByName("menu_lev1_Sub");
    		for(var i=0;i<arr.length;i++){
    			arr[i].style.display = "none";
    	    }
    	}
    </script>
  </body>
</html>
