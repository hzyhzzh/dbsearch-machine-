<%@page import="javax.xml.crypto.dsig.keyinfo.KeyValue"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="dbsearch.service.impl.*"%>
<%@ page language="java" import="dbsearch.domain.User"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
	function getAndLoadUser(desUrl) {
		$.get(desUrl, function(result) {
			loadUsers(currentPageIndex + 1);
		});
	}
	function getAndLoadPage(desUrl) {
		$.get(desUrl, function(result) {
			loadUserPage(true, currentPageIndex);
		});
	}
</script>
<table width="100%" id="" border="0" class="t1" align="center"
	cellpadding="0" cellspacing="0">
	<tr>
		<th width="25%" align="center">邮箱</th>
		<th width="15%" align="center">注册时间</th>
		<th width="15%" align="center">用户权限</th>
		<th width="15%" align="center">权限配置</th>
		<th width="15%" align="center">删除用户</th>
	</tr>
	<%
		List<User> users = (List<User>) request.getAttribute("users");
		for (User u : users) {
	%>
	<tr align="center">
		<td><%=u.getEmail()%></td>
		<td><fmt:formatDate value="<%=u.getRegiDate()%>" type="date" /></td>
		<td><%=UserService.RCode2Name.get(u.getRole())%></td>
		<td>
			<button type="button"
				style="display: <%=u.getRole() <= 0 ? "none" : "inline"%>"
				onclick="getAndLoadUser('ajax/dropPerm?email=<%=u.getEmail()%>')">降低权限</button>
			<button type="button"
				style="display: <%=u.getRole() >= 10 ? "none" : "inline"%>"
				onclick="getAndLoadUser('ajax/raisePerm?email=<%=u.getEmail()%>')">提升权限</button>
		<td><button type="button"
				onclick="if (confirm('确定删除用户<%=u.getEmail()%>吗？')) getAndLoadPage('ajax/deleteUser?email=<%=u.getEmail()%>')">删除</button></td>
	</tr>
	<%
		}
	%>
</table>

