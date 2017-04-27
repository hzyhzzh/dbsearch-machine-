package dbsearch.interceptor;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	private static List<AuthRule> authRules = new ArrayList<AuthRule>();
	private String loginUrl = "/dbsearch/YH/login";

	static {
		AuthRule adminRule = new AuthRule(true, new Integer[] { 0, 10 },
				new String[] { "ajax/getUsers", "YH/guanliyuan", "ajax/getUserCount", "ajax/getUsers",
						"ajax/pure_upload", "ajax/raisePerm", "ajax/dropPerm", "ajax/deleteUser" });
		AuthRule userRule = new AuthRule(true, new Integer[] { 0, 1, 10 },
				new String[] { "gerenzhongxin", "resetPassword","viewer.html" });
		authRules.add(adminRule);
		authRules.add(userRule);
	}

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
		String uri = request.getRequestURI();
		String email = (String) request.getSession().getAttribute("user");
		Integer userRole = (Integer) request.getSession().getAttribute("userRole");
		for (AuthRule rule : authRules) {
			for (String endUri : rule.endUris) {
				if (uri.endsWith(endUri)) {
					if ((email != null) == rule.isEmail && rule.roleCondition.contains(userRole))
						return true;
					else
						try {
							response.sendRedirect(loginUrl);
						} catch (IOException e) {
							e.printStackTrace();
						}
				}
			}

		}
		return true;
	}
}

class AuthRule {
	boolean isEmail;
	Set<Integer> roleCondition;
	String[] endUris;

	public AuthRule(boolean isEmail, Integer[] roleCondition, String[] uris) {
		// TODO Auto-generated constructor stub
		this.isEmail = isEmail;
		this.roleCondition = new HashSet<Integer>(Arrays.asList(roleCondition));
		this.endUris = uris;
	}
}
