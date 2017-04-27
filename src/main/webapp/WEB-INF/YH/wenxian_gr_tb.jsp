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
.now_span {
color:#fff;
font-size:17px;
}
</style>
</head>
<body>
	<table width="95%" id="" border="0" class="t1"  align="center"
						cellpadding="0" cellspacing="0">
		<tr bgcolor="#436EEE">
			<th width="10%" align="center"><span class="now_span">选择</span></th>
			<th width="50%" align="center"><span class="now_span">上传的文档</span></th>
			<th width="20%" align="center"><span class="now_span">上传时间</span></th>
			<th width="20%" align="center"><span class="now_span">审核状态</span></th>
		</tr>
		<%!
			List<Paper> resultList;
			Paper paper;
		%>
		<%
			resultList=(List<Paper>)request.getAttribute("resultList_gr");
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
				<td align="center" colspan="4">
					---无上传记录---
				</td>
			</tr>
		<% 
			}
		%>
		
	</table>
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
</body>
</html>