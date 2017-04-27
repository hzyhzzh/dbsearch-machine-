package dbsearch.controller;


import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ContextLoader;

import dbsearch.domain.User;
import dbsearch.service.impl.UserService;
import dbsearch.util.EmailUtil;
import dbsearch.util.GenerateLinkUtil;

@Controller
public class UserController {

	@Autowired
	private UserService userService;

	@RequestMapping("/users")
	public String getUsers(Model model) {
		model.addAttribute("users", userService.getAllUser());
		return "users";
	}

	@RequestMapping(value = "/YH/register", method = RequestMethod.GET)
	public String getRegisterUser(Model model) {
		User cuUser = new User();
		model.addAttribute("newUser", cuUser);
		return "/YH/register";
	}

	@RequestMapping(value = "/YH/register", method = RequestMethod.POST)
	public String doRegisterUser(Model model, @ModelAttribute("newUser") @Valid User newUser, BindingResult result,
			HttpServletRequest request) {
		if (result.hasErrors()) {
			return "/YH/register";
		}
		userService.addUser(newUser);
		request.getSession().setAttribute("user", newUser.getEmail());
		request.getSession().setAttribute("userRole", newUser.getRole());
		return "forward:/index";
	}

	@RequestMapping(value = "/YH/gerenzhongxin", method = RequestMethod.GET)
	public String getUserCenter(Model model, HttpServletRequest request) {
		
		String email = (String)request.getSession().getAttribute("user");
		User user = (User)userService.getUser(email);
		//user.addScore(1);
		model.addAttribute("user", user);
		return "/YH/gerenzhongxin";
	}

	@RequestMapping(value = "/YH/resetPassword", method = RequestMethod.POST)
	public String resetPassword(Model model, HttpServletRequest request) {
		String email = (String) request.getSession().getAttribute("user");
		String newpass = (String) request.getParameter("password");
		userService.resetPassword(email, newpass);
		return "redirect:/YH/gerenzhongxin?section=grxx_main_success";
	}

	@RequestMapping(value = "/YH/login", method = RequestMethod.GET)
	public String getLogin(Model model, HttpServletRequest request) {
		model.addAttribute("loginStatus", "req");
		return "forward:/index";
	}

	@RequestMapping(value = "/YH/login", method = RequestMethod.POST)
	public String doLogin(Model model, HttpServletRequest request) {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		if (userService.validLogin(email, password) == UserService.LoginStatus.OK) {
			request.getSession().setAttribute("user", email);
			request.getSession().setAttribute("userRole", userService.getUser(email).getRole());
		} else
			model.addAttribute("loginStatus", "fail");
		return "forward:/index";
	}

	@RequestMapping(value = "/YH/logout")
	public String doLogout(Model model, HttpServletRequest request) {
		request.getSession().removeAttribute("user");
		request.getSession().removeAttribute("userRole");
		return "forward:/index";
	}

	@RequestMapping(value = "/ajax/getUserCount")
	@ResponseBody
	public String getUserCount(Model model, HttpServletRequest request) {
		String email = (String) request.getSession().getAttribute("user");
		String searchEmail = request.getParameter("searchEmail");
		String searchRole = request.getParameter("searchRole");
		return String.valueOf(userService.getUserCount(email, searchEmail, searchRole));
	}

	@RequestMapping(value = "/ajax/getUsers")
	public String getUsers(Model model, HttpServletRequest request) {
		int pageIndex = Integer.parseInt(request.getParameter("pageIndex"));
		String searchEmail = request.getParameter("searchEmail");
		String searchRole = request.getParameter("searchRole");
		String email = (String) request.getSession().getAttribute("user");
		model.addAttribute("users", userService.getUserByPage(pageIndex, email, searchEmail, searchRole));
		return "/YH/userList";
	}

	@RequestMapping(value = "/ajax/raisePerm")
	public String raisePerm(Model model, HttpServletRequest request) {
		String email = request.getParameter("email");
		userService.raisePerm(email);
		return "nothing";
	}

	@RequestMapping(value = "/ajax/dropPerm")
	public String dropPerm(Model model, HttpServletRequest request) {
		String email = request.getParameter("email");
		userService.dropPerm(email);
		return "nothing";
	}

	@RequestMapping(value = "/ajax/deleteUser")
	public String deleteUser(Model model, HttpServletRequest request) {
		String email = request.getParameter("email");
		userService.deleteUser(email);
		return "nothing";
	}

	@RequestMapping(value = "/YH/guanliyuan", method = RequestMethod.GET)
	public String getGly(Model model, HttpServletRequest request) {
		return "/YH/guanliyuan";
	}

	@RequestMapping(value = "/YH/getPassLink", method = RequestMethod.GET)
	public String getPassLink(Model model, HttpServletRequest request) {
		String email = request.getParameter("email");
		User user = userService.getUser(email);
		if (user == null) {
			model.addAttribute("emailError", "yes");
			return "/YH/forgetPass";
		}
		String urlPrefix = String.format("http://%s:%s", request.getServerName(),request.getServerPort());
		EmailUtil.sendResetPasswordEmail(user, urlPrefix);
		return "/YH/getLinkSuccess";
	}

	@RequestMapping(value = "/YH/tempResetPassword", method = RequestMethod.GET)
	public String tempResetPassword(Model model, HttpServletRequest request) {
		String email = request.getParameter("email");
		User user = userService.getUser(email);
		if (user != null) {
			if (GenerateLinkUtil.verifyCheckcode(user, request)) {
				userService.resetRandomCode(user);
				request.getSession().setAttribute("user", email);
				request.getSession().setAttribute("userRole", userService.getUser(email).getRole());
				return "redirect:/YH/gerenzhongxin?section=grxx_main_reset";
			} else
				return "/YH/linkExpired";
		} else
			return "/YH/forgetPass";
	}
	@RequestMapping(value = "/ajax/getAdminEmail")
	@ResponseBody
	public String getAdminEmail(Model model, HttpServletRequest request) {
		Properties prop = (Properties) ContextLoader.getCurrentWebApplicationContext().getBean("appConfig");
		return prop.getProperty("admin.email");
	}
}