package dbsearch.domain.repository;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dbsearch.domain.Category;

@Repository
public class CategoryRepository {
	@Autowired
	private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	public List<Category> getAllCategory() {
		String hsql = "from category";
		Session session = sessionFactory.openSession();
		Query query = session.createQuery(hsql);
		return query.list();
	}
	
	public List<Category> getAllCateExcQT(String str) {
		String hsql = "from category where parent=1 and name <> '"+str+"'";
		Session session = sessionFactory.openSession();
		Query query = session.createQuery(hsql);
		return query.list();
	}
	
	public boolean addCategory(Category category) {
		Session session = sessionFactory.openSession();
		session.save(category);
		return true;
	}

	public Category getCategoryById(int id) {
		String hql = "from category where id=?";
		Session session = sessionFactory.openSession();
		Query query = session.createQuery(hql);
		query.setInteger(0, id);
		return (Category) query.uniqueResult();
	}

	@SuppressWarnings("unchecked")
	public Category getCategoryByName(String name, Integer parentId) {
		String hql = "from category where name=? and parent=?";
		Session session = sessionFactory.openSession();
		try {
			Query query = session.createQuery(hql);
			query.setString(0, name.trim());
			query.setInteger(1, parentId);
			query.setMaxResults(1);
			return (Category) query.uniqueResult();
		} finally {
			session.close();
		}
	}

	@SuppressWarnings("unchecked")
	public List<Category> getCategoryByParent(int parent) {
		String hql = "from category where parent=?";
		Session session = sessionFactory.openSession();
		try {
			Query query = session.createQuery(hql);
			query.setInteger(0, parent);
			return query.list();
		} finally {
			session.close();
		}
	}

	public boolean updateCategory(Category cate) {
		Session session = sessionFactory.openSession();
		try {
			Transaction tx = session.beginTransaction();
			Object mergedEntity = session.merge(cate);
			session.saveOrUpdate(mergedEntity);
			// session.update(cate);
			tx.commit();
		} finally {
			session.close();
		}
		return true;
	}

	public boolean deleteCategory(Category cate) {
		Session session = sessionFactory.openSession();
		try {
			Transaction tx = session.beginTransaction();
			Object mergedEntity = session.merge(cate);
			session.delete(mergedEntity);
			// session.update(cate);
			tx.commit();
		} finally {
			session.close();
		}
		return true;
	}

	public Category getCategory(String name1Leavel, String name2Leavel) {
		if(name1Leavel == null || name2Leavel == null){
			return null;
		}
		Category cate1 = getCategoryByName(name1Leavel, 1);
		if (cate1 != null) {
			return getCategoryByName(name2Leavel, cate1.getId());
		}
		return null;
	}
}
