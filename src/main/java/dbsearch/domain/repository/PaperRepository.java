package dbsearch.domain.repository;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dbsearch.domain.Paper;

@Repository
public class PaperRepository {
	@Autowired
	private SessionFactory sessionFactory;
	
	@SuppressWarnings("unchecked")
	public List<Paper> getAllPaper() {
		String hsql = "from paper";
		Session session = sessionFactory.openSession();
		Query query = session.createQuery(hsql);
		return query.list();
	}
	
	public boolean addPaper(Paper paper) {
		Session session = sessionFactory.openSession();
		try {
			session.save(paper);
		} finally {
			session.close();
		}
		return true;
	}
	
	public Paper getPaperById(int id) {
		String hql = "from paper where id=?";
		Session session = sessionFactory.openSession();
		try {
			Query 	query = session.createQuery(hql);
			query.setInteger(0, id);
			
			Paper paper=(Paper) query.uniqueResult();
			paper.getOwner();
			return (Paper) query.uniqueResult();
		} finally {
			session.close();
		}
	}
	
	public boolean updatePaper(Paper paper) {
		Session session = sessionFactory.openSession();
		try {
			Transaction tx = session.beginTransaction();
			Object  mergedEntity = session.merge(paper);
			session.saveOrUpdate(mergedEntity);
			tx.commit();
		} finally {
			session.close();
		}
		return true;
	}
	
	public boolean deletePaper(int id) {
		Paper paper=getPaperById(id);
		Session session = sessionFactory.openSession();
		try {
			Transaction tx = session.beginTransaction();
			session.delete(paper);
			tx.commit();
			return true;
		} catch (Exception e) {
			return false;
		} finally {
			session.close();
		}
	}
	
	public List<Paper> getPaperByOwner(int ownerId) {
		String hsql = "from paper where owner="+ownerId;
		Session session = sessionFactory.openSession();
		try {
			Query query = session.createQuery(hsql);
			return query.list();
		} finally {
			session.close();
		}
	}
}
