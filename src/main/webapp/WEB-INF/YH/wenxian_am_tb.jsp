<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="dbsearch.service.impl.CategoryService"%>
<%@ page language="java" import="dbsearch.domain.Paper"%>
<%@ page language="java" import="dbsearch.domain.User"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
span{
color:#fff;
}
</style>
</head>
<body>
	<table width="100%" id="" border="0" class="t1" align="center"
						cellpadding="0" cellspacing="0">
		<tr>
			<th width="10%" align="center">选择</th>
			<th width="45%" align="center">上传的文档</th>
			<th width="15%" align="center">上传者</th>
			<th width="18%" align="center">上传时间</th>
			<th width="12%" align="center">审核状态</th>
		</tr>
		<%!
			List<Paper> resultList;
			Paper paper;
		%>
		<%
			resultList=(List<Paper>)request.getAttribute("resultList_am");
			if(!resultList.isEmpty()){
	 			for(int i=0;i<resultList.size();i++){
	 				paper=resultList.get(i);
		%>
			<tr align="center">
				<td align="center">
					<input id="chkId_<%=paper.getId() %>" name="chk" type="checkbox" value="<%=paper.getId() %>" 
	 					onclick="setSelectedSingle(this)"/>
	 				<input name="fileStatus" id="fileStatus_<%=paper.getId() %>" type="hidden" value="<%=paper.getFileStatus() %>"></input>
	 			</td>
	 			<td align="center"><a onclick="showPaper(<%=paper.getId() %>)"><%=paper.getAccidentName() %></a></td>
				<td align="center"><%=paper.getOwner().getEmail()%></td>
				<td align="center"><%=paper.getUploadTime().toString().substring(0, 16) %></td>
				<td align="center">
					<%=setSta(paper.getFileStatus()) %>
				</td>
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
		String setSta(int isPass){
			String str="";
			if(isPass==0){
				str="待审核";
			}else if(isPass==1){
				str="已通过";
			}else if(isPass==2){
				str="未通过";
			}
			return str;
		}
	%>
	</table>
</body>
</html>