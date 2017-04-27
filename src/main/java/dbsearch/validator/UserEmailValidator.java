package dbsearch.validator;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import org.springframework.beans.factory.annotation.Autowired;

import dbsearch.domain.User;
import dbsearch.service.impl.UserService;

public class UserEmailValidator implements ConstraintValidator<UserEmail, String> {
	@Autowired
	private UserService userService;

	public void initialize(UserEmail constraintAnnotation) {
	}

	public boolean isValid(String value, ConstraintValidatorContext context) {
		User user;
		try {
			user = userService.getUser(value);
		} catch (Exception e) {
			return true;
		}
		if (user != null) {
			return false;
		}
		return true;
	}
}
