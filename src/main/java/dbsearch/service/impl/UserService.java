package dbsearch.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import dbsearch.domain.User;
import dbsearch.domain.repository.UserRepository;

@Service
public class UserService {
	@Autowired
	private UserRepository userRepository;
	public static Map<Integer, String> RCode2Name = new HashMap<Integer, String>();

	static {
		RCode2Name.put(0, "注册用户");
		RCode2Name.put(1, "会员");
		RCode2Name.put(10, "管理员");
	}

	public List<User> getAllUser() {
		return userRepository.getAllUser();
	}

	public List<User> getUserByPage(int pageIndex, String myEmail, String searchEmail, String searchRole) {
		return userRepository.getUserByPage(pageIndex, myEmail, searchEmail, searchRole);
	}

	public int getUserCount(String myEmail, String searchEmail, String searchRole) {
		return userRepository.getUserCount(myEmail, searchEmail, searchRole);
	}

	public boolean addUser(User user) {
		return userRepository.saveOrUpdate(user);
	}

	public User getUser(String email) {
		return userRepository.getUser(email);
	}

	public LoginStatus validLogin(String email, String password) {
		User realUser = userRepository.getUser(email);
		if (realUser != null && realUser.getPassword().equals(password)) {
			return LoginStatus.OK;
		}
		return LoginStatus.FAILED;
	}

	public boolean resetPassword(String email, String newPassword) {
		User realUser = userRepository.getUser(email);
		if (realUser != null) {
			realUser.setPassword(newPassword);
			return userRepository.saveOrUpdate(realUser);
		}
		return false;
	}

	public void raisePerm(String email) {
		User user = getUser(email);
		user.setRole(user.getRole() < 1 ? 1 : 10);
		userRepository.saveOrUpdate(user);
	}

	public void dropPerm(String email) {

		User user = getUser(email);
		user.setRole(user.getRole() > 1 ? 1 : 0);
		userRepository.saveOrUpdate(user);
	}

	public static enum LoginStatus {
		OK, FAILED, REPET
	}

	public void deleteUser(String email) {
		userRepository.deleteUser(email);
	}

	public void resetRandomCode(User user) {
		user.setRandomCode(String.valueOf(Math.random()));
		userRepository.saveOrUpdate(user);
	}

}
