<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ page language="java" import="dbsearch.domain.PaperField"%>
<%@ page language="java" import="dbsearch.domain.FieldKeyword"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<title>Insert title here</title>

<style type="text/css">
.tb_gjc{
	width:100%;
}
.tb_gjc tr th {
    line-height: 40px;
    border-bottom: 1px solid rgb(200,200,200);
    border-top: 1px solid rgb(200,200,200);
    font-weight: normal;
}
.tb_gjc tr td {
    line-height: 30px;
    border-top: 1px solid #e9edf3;
    padding-left: 10px;
    padding-right: 10px;
}
</style>
<script type="text/javascript">
function doHideOrDisplay(Id){
	var divId="div_"+Id;
	var spanId="span_"+Id;
	if(!$("#"+divId).is(":hidden")){
		$("#"+divId).hide();
		$("#"+spanId).text("﹀");
	}else{
		$("#"+divId).show();
		$("#"+spanId).text("︿");
	}
}
</script>
</head>
<body>
	<table width="100%" id="" border="0" class="t1" align="center"
						cellpadding="0" cellspacing="0">
		<tr>
			<td width="20%" align="center"></td>
			<th width="30%" align="center"></th>
			<th width="50%" align="center">失效案例数（结果总计：<%=request.getAttribute("resSum") %>）</th>
		</tr>
		
		<%!
			List<Map<?,?>> resList;
			Map<?,?> fieldMap=new HashMap();
			List<Map> dataList;
			Map dataMap=new HashMap();
		%>
		<%
			resList=(List<Map<?,?>>)request.getAttribute("resList");
			if(!resList.isEmpty()){
	 			for(int i=0;i<resList.size();i++){
	 				fieldMap=resList.get(i);
		%>
		<tr>
			<th width="20%" align="center">
				<span style="cursor: pointer;" onclick="doHideOrDisplay(<%=i%>)">
					<%=fieldMap.get("title") %>
					<span id="span_<%=i%>">︿</span>
				</span>
			</th>
			<td width="80%" colspan="2" align="center">
				<div id="div_<%=i%>">
				<table border="0" width="100%">
					<%
					dataList=(List<Map>)fieldMap.get("data");
					if(!dataList.isEmpty())
						for(int k=0;k<dataList.size();k++){
							dataMap=dataList.get(k);
							String improvement=dataMap.get("improvement").toString();
							int amount=Integer.parseInt(dataMap.get("amount").toString());
							if(amount!=0){
							if(improvement.equals("")){
					%>
					<tr height="30px">
						<td align="center" width="30%"><%=dataMap.get("keyword") %></td>
						<td align="center" width="50%"><%=dataMap.get("amount") %></td>
					</tr>
					<%}else{ %>
					<tr height="30px">
						<td align="center" rowspan="2" width="30%"><%=dataMap.get("keyword") %></td>
						<td align="center" width="50%"><%=dataMap.get("amount") %></td>
					</tr>
					<tr>
						<td align="left" width="50%"><b>改进措施：</b><%=dataMap.get("improvement") %></td>
					</tr>
					<%}}} %>
				</table></div>
			</td>	
		</tr>
		<%
	 			}}
		%>
	</table>
</body>
</html>