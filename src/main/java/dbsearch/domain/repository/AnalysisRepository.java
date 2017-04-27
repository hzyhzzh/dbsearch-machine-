package dbsearch.domain.repository;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dbsearch.domain.FieldKeyword;
import dbsearch.domain.PaperField;

@Repository
public class AnalysisRepository {
	@Autowired
	private SessionFactory sessionFactory;
	
	public List<PaperField> getConsiderdFields(){
		String hql = "from paperfield where isStatistical=true";
		Session session = sessionFactory.openSession();
		try {
			Query query = session.createQuery(hql);
			return query.list();
		} finally {
			session.close();
		}
	}
	
	public PaperField getPaperFieldById(int fieldId){
		String hql = "from paperfield where isStatistical=true and id=?";
		Session session = sessionFactory.openSession();
		try {
			Query query = session.createQuery(hql);
			query.setInteger(0, fieldId);
			return (PaperField)query.uniqueResult();
		} finally {
			session.close();
		}
	}
	
	public List<FieldKeyword> getKeyswords(int fieldId){
		String hql = "from fieldkeyword where field=?";
		Session session = sessionFactory.openSession();
		try {
			Query query = session.createQuery(hql);
			query.setInteger(0, fieldId);
			return query.list();
		} finally {
			session.close();
		}
	}
	
	public FieldKeyword getKeywordById(int keyword){
		String hql = "from fieldkeyword where id=?";
		Session session = sessionFactory.openSession();
		try {
			Query query = session.createQuery(hql);
			query.setInteger(0, keyword);
			return (FieldKeyword)query.uniqueResult();
		} finally {
			session.close();
		}
	}
	
	public boolean addFieldKeyword(FieldKeyword fieldKeyword) {
		Session session = sessionFactory.openSession();
		try {
			session.save(fieldKeyword);
		} finally {
			session.close();
		}
		return true;
	}
	
	public boolean updateFieldKeyword(FieldKeyword fieldKeyword) {
		Session session = sessionFactory.openSession();
		try {
			Transaction tx = session.beginTransaction();
			Object mergedEntity = session.merge(fieldKeyword);
			session.saveOrUpdate(mergedEntity);
			tx.commit();
		} finally {
			session.close();
		}
		return true;
	}
	
	public boolean deleteFieldKeyword(FieldKeyword fieldKeyword) {
		Session session = sessionFactory.openSession();
		try {
			Transaction tx = session.beginTransaction();
			Object mergedEntity = session.merge(fieldKeyword);
			session.delete(mergedEntity);
			tx.commit();
		} finally {
			session.close();
		}
		return true;
	}
}
