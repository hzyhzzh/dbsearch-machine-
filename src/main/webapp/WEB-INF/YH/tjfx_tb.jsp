<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="dbsearch.service.impl.CategoryService"%>
<%@ page language="java" import="dbsearch.domain.Paper"%>
<%@ page language="java" import="dbsearch.domain.User"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8 ">
<title>Insert title here</title>
	<script src="js/jquery.js"></script>
	<link href="css/mricode.pagination.css" rel="stylesheet" />
	
</head>
<body>
	<table width="100%" id="" border="0" class="t1" align="center"
						cellpadding="0" cellspacing="0">
		<tr>
			<th width="25%" align="center">上传的文档</th>
			<th width="15%" align="center">失效设备</th>
			<th width="20%" align="center">失效部件</th>
			<th width="10%" align="center">失效形式</th>
			<th width="10%" align="center">失效机理</th>
			<th width="20%" align="center">失效材料类型</th>
		</tr>
		<%!
			List<Paper> resultList;
			Paper paper;
		%>
		<%
			resultList=(List<Paper>)request.getAttribute("resultList");
			if(!resultList.isEmpty()){
	 			for(int i=0;i<resultList.size();i++){
	 				paper=resultList.get(i);
		%>
			<tr align="center">
	 			<td align="center"><a onclick="showPaper(<%=paper.getId() %>)"><%=retStr(paper.getAccidentName()) %></a></td>
				<td align="center"><%=retStr(paper.getFailureEquipment()) %></td>
				<td align="center"><%=retStr(paper.getFailureComponent()) %></td>
				<td align="center"><%=retStr(paper.getFailureBehave()) %></td>
				<td align="center"><%=retStr(paper.getFailureCause()) %></td>
				<td align="center"><%=retStr(paper.getFailureMaterial()) %></td>
			</tr>
		
		<%
	 			}
			}else{
		%>
			<tr align="center">
				<td align="center" colspan="5">
					---无上传记录---
				</td>
			</tr>
		<% 
			}
		%>
		<%!
		String retStr(String str){
			if(str==null){
				str="";
			}
			return str;
		}
	%>
	</table>
</body>
<!-- <script src="js/mricode.pagination.js"></script> -->
<script type="text/javascript">
function showPaper(id){
	window.location.href = "/dbsearch/showPaper?paperId="+id;
}
</script>
</html>