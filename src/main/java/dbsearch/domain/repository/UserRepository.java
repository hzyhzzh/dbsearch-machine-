package dbsearch.domain.repository;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dbsearch.domain.User;

@Repository
public class UserRepository {
	@Autowired
	private SessionFactory sessionFactory;
	private static final int PAGESIZE = 10;

	public List<User> getAllUser() {
		String hsql = "from user";
		Session session = sessionFactory.openSession();
		Query query = session.createQuery(hsql);
		List<User> userList = query.list();
		session.close();
		return userList;
	}

	public boolean addUser(User user) {
		Session session = sessionFactory.openSession();
		try {
			session.save(user);
		} finally {
			session.close();
		}
		return true;
	}

	public User getUser(String email) {
		String hql = "from user where email=?";
		Session session = sessionFactory.openSession();
		try {
			Query query = session.createQuery(hql);
			query.setString(0, email);
			User user = (User) query.uniqueResult();
			return user;
		} finally {
			session.close();
		}
	}

	public List<User> getUserByPage(int pageIndex, String myEmail, String searchEmail, String searchRole) {
		boolean byEmail = false;
		String hql = "from user where email<>? ";
		if(searchEmail != null && !searchEmail.trim().isEmpty()){
			byEmail = true;
			hql += " and email like :emailPattern ";
		}
		Integer byRole = -1;
		try {
			byRole = Integer.parseInt(searchRole);
			hql += " and role=:role ";
		} catch (Exception e) {

		}
		Session session = sessionFactory.openSession();
		try {
			Query query = session.createQuery(hql);
			query.setString(0, myEmail);
			if(byEmail){
				query.setString("emailPattern", "%" + searchEmail.trim() + "%");
			}
			if (byRole >= 0)
				query.setInteger("role", byRole);
			query.setFirstResult((pageIndex - 1) * PAGESIZE);
			query.setMaxResults(PAGESIZE);
			List<User> users = query.list();
			return users;
		} finally {
			session.close();
		}
	}

	public int getUserCount(String myEmail, String searchEmail, String searchRole) {
		boolean byEmail = false;
		String hql = "select count(*) from user where email<>? ";
		if(searchEmail != null && !searchEmail.trim().isEmpty()){
			byEmail = true;
			hql += " and email like :emailPattern ";
		}
		Integer byRole = -1;
		try {
			byRole = Integer.parseInt(searchRole);
			hql += " and role=:role";
		} catch (Exception e) {

		}
		Session session = sessionFactory.openSession();
		try {
			Query query = session.createQuery(hql);
			query.setString(0, myEmail);
			if(byEmail){
				query.setString("emailPattern", "%" + searchEmail.trim() + "%");
			}
			if (byRole >= 0)
				query.setInteger("role", byRole);
			return ((Long) query.uniqueResult()).intValue();
		} finally {
			session.close();
		}
	}

	public boolean saveOrUpdate(User user) {
		Session session = sessionFactory.openSession();
		try {
			Transaction tx = session.beginTransaction();
			session.saveOrUpdate(user);
			tx.commit();
			return true;
		} catch (Exception e) {
			return false;
		} finally {
			session.close();
		}
	}

	public boolean deleteUser(String email) {
		User user = getUser(email);
		Session session = sessionFactory.openSession();
		try {
			Transaction tx = session.beginTransaction();
			session.delete(user);
			tx.commit();
			return true;
		} catch (Exception e) {
			return false;
		} finally {
			session.close();
		}
	}
}
