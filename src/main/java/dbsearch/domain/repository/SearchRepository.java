package dbsearch.domain.repository;

import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dbsearch.domain.Category;
import dbsearch.domain.Paper;
import dbsearch.domain.repository.CategoryRepository;

@Repository
public class SearchRepository {
	@Autowired
	private CategoryRepository categoryRepository;
	@Autowired
	private SessionFactory sessionFactory;
	private static final int PAGESIZE = 10;
	
	public List<Paper> getAllSearchedPaper( Map sMap,String con) {
		String strSQL = "from paper where fileStatus=1";
		String strSqlSplice=sqlSplice(sMap,con);
		if(!strSqlSplice.trim().equals("")){
			strSQL=strSQL+" and ("+strSqlSplice+")";
		}
		Session session = sessionFactory.openSession();
		Query query = session.createQuery(strSQL);
		return query.list();
	}
	
	public List<Paper> getSearchedPaper(int pageIndex, Map sMap,String con) {
		String strSQL = "from paper where fileStatus=1";
		String strSqlSplice=sqlSplice(sMap,con);
		if(!strSqlSplice.trim().equals("")){
			strSQL=strSQL+" and ("+strSqlSplice+")";
		}
		strSQL+=" order by uploadTime desc";
		System.out.println(strSQL);
		Session session = sessionFactory.openSession();
		Query query = session.createQuery(strSQL);
		query.setFirstResult((pageIndex - 1) * PAGESIZE);
		query.setMaxResults(PAGESIZE);
		return query.list();
	}
	
	public int getSearchedPaperCount(Map sMap,String con) {
		String strSQL = "select count(*) from paper where fileStatus=1";
		String strSqlSplice=sqlSplice(sMap,con);
		if(!strSqlSplice.trim().equals("")){
			strSQL=strSQL+" and ("+strSqlSplice+")";
		}
		Session session = sessionFactory.openSession();
		Query query = session.createQuery(strSQL);
		return ((Long) query.uniqueResult()).intValue();
	}
	
	public List<Paper> getSearchSearchWDGL(int pageIndex, Map searchMap,String fileStatus,String searchRole) {
		String strSQL = "from paper where ";
		String strSqlSplice=sqlSpliceWDGL(searchMap,"or");
		
		if(fileStatus!=null&&!fileStatus.equals("")){
			int fStatus=Integer.parseInt(fileStatus);
			if(strSqlSplice.trim().equals("")){
				strSqlSplice+="fileStatus="+fStatus;
			}else{
				strSqlSplice+=strSqlSplice+" and fileStatus="+fStatus;
			}
		}
		
		if(searchRole.equals("adm")){
			if(strSqlSplice.trim().equals("")){
				strSQL+="1=1";
			}else{
				strSQL+=strSqlSplice;
			}
		}else{
			int ownerId=Integer.parseInt(searchRole);
			if(strSqlSplice.trim().equals("")){
				strSQL+="owner="+ownerId;
			}else{
				strSQL+=strSqlSplice+" and owner="+ownerId;
			}
		}
		strSQL+=" order by uploadTime DESC";
		Session session = sessionFactory.openSession();
		Query query = session.createQuery(strSQL);
		query.setFirstResult((pageIndex - 1) * PAGESIZE);
		query.setMaxResults(PAGESIZE);
		return query.list();
	}
	
	public int getWDGLCount(Map searchMap,String fileStatus,String searchRole) {
		String strSQL = "select count(*) from paper where ";
		String strSqlSplice=sqlSpliceWDGL(searchMap,"or");

		if(fileStatus!=null&&!fileStatus.equals("")){
			int fStatus=Integer.parseInt(fileStatus);
			if(strSqlSplice.trim().equals("")){
				strSqlSplice+="fileStatus="+fStatus;
			}else{
				strSqlSplice+=strSqlSplice+" and fileStatus="+fStatus;
			}
		}
		
		if(searchRole.equals("adm")){
			if(strSqlSplice.trim().equals("")){
				strSQL+="1=1";
			}else{
				strSQL+=strSqlSplice;
			}
		}else{
			int ownerId=Integer.parseInt(searchRole);
			if(strSqlSplice.trim().equals("")){
				strSQL+="owner="+ownerId;
			}else{
				strSQL+=strSqlSplice+" and owner="+ownerId;
			}
		}
		Session session = sessionFactory.openSession();
		Query query = session.createQuery(strSQL);
		
		return ((Long) query.uniqueResult()).intValue();
	}
	
	public String sqlSplice(Map sMap,String con){//con取值and或or
		String retStr="";
		String attrCon="and";
		String[] STR_LIST=Paper.STR_LIST;
		if(con==null||con.length()!=13){
			con="0000000000000";
			attrCon="or";
		}
		for(int i=0;i<STR_LIST.length;i++){
			String attrStr=STR_LIST[i];
			if(getVal(attrStr,sMap).trim()!=""){
				if(retStr.equals("")){
//					retStr+=" ("+getSubStr(attrStr,sMap.get(attrStr).toString(),"","and")+")";
					String tempStr=con.substring(i, i+1);
					String and_or=con.substring(i, i+1).equals("1")?"And":"Or";
					retStr+=" ("+getSubStr(attrStr,sMap.get(attrStr).toString(),"",and_or)+")";
				}else{
//					retStr+=" "+con+" ("+getSubStr(attrStr,sMap.get(attrStr).toString(),"","and")+")";
					String tempStr=con.substring(i, i+1);
					String and_or=con.substring(i, i+1).equals("1")?"And":"Or";
					retStr+=" "+attrCon+" ("+getSubStr(attrStr,sMap.get(attrStr).toString(),"",and_or)+")";
				}
			}
		}
		return retStr;
	}
	
	public String sqlSpliceWDGL(Map sMap,String con){//con取值and或or
		String retStr="";
		String[] STR_LIST=Paper.STR_LIST;

		for(int i=0;i<STR_LIST.length;i++){
			String attrStr=STR_LIST[i];
			if(getVal(attrStr,sMap).trim()!=""){
				if(retStr.equals("")){
					retStr+=" ("+getSubStr(attrStr,sMap.get(attrStr).toString(),"","and")+")";
				}else{
					retStr+=" "+con+" ("+getSubStr(attrStr,sMap.get(attrStr).toString(),"","and")+")";
				}
			}
		}
		return retStr;
	}
	
	public String getVal(String inStr,Map sMap){
		String retStr="";
		if(sMap.get(inStr)!=null){
			retStr=sMap.get(inStr).toString();
		}
		return retStr;
	}
	
	public String getSubStr(String attrStr,String inStr,String subStr,String con){
		inStr=sideTrim(inStr.trim()," ");
		if(!inStr.equals("")){
			if(inStr.contains(" ")){
				if(subStr==null||subStr.equals("")){
					subStr+=" ("+attrStr+" like '%"+inStr.substring(0, inStr.indexOf(' '))+"%')";
					inStr=inStr.substring(inStr.indexOf(' '));
				}else{
					subStr+=" "+con+" ("+attrStr+" like '%"+inStr.substring(0, inStr.indexOf(' '))+"%')";
					inStr=inStr.substring(inStr.indexOf(' '));
				}
			}else{
				if(subStr==null||subStr.equals("")){
					if("failureBehave".equals(attrStr)&&(("其他".equals(inStr)||"其它".equals(inStr)))){//失效形式，“其他”
						List<Category> listCate=categoryRepository.getAllCateExcQT(inStr);
						if(listCate!=null)for(int k=0;k<listCate.size();k++){
							if(k==0){
								subStr+=" ("+attrStr+" not like '%"+((Category)listCate.get(k)).getName()+"%')";
							}else{
								subStr+="and ("+attrStr+" not like '%"+((Category)listCate.get(k)).getName()+"%')";
							}
						}
					}else{
						subStr+=" ("+attrStr+" like '%"+inStr+"%')";
					}
//					subStr+=" ("+attrStr+" like '%"+inStr+"%')";
				}else{
					subStr+=" "+con+" ("+attrStr+" like '%"+inStr+"%')";
				}
				inStr="";
			}
			return getSubStr(attrStr,inStr,subStr,con);
		}
		return subStr;
	}
	
	/**
	 *
	 *去掉指定字符串的开头和结尾的指定字符
	 *
	 * @param stream 要处理的字符串
	 * @param trimstr 要去掉的字符串
	 * @return 处理后的字符串
	 */
	public static String sideTrim(String stream, String trimstr) {
		// null或者空字符串的时候不处理
	    if (stream == null || stream.length() == 0 || trimstr == null || trimstr.length() == 0) {
	      return stream;
	    }
	    
	    // 结束位置
	    int epos = 0;
	    
	    // 正规表达式
	    String regpattern = "[" + trimstr + "]*+";
	    Pattern pattern = Pattern.compile(regpattern, Pattern.CASE_INSENSITIVE);
	 
	    // 去掉结尾的指定字符 
	    StringBuffer buffer = new StringBuffer(stream).reverse();
	    Matcher matcher = pattern.matcher(buffer);
	    if (matcher.lookingAt()) {
	      epos = matcher.end();
	      stream = new StringBuffer(buffer.substring(epos)).reverse().toString();
	    }
	 
	    // 去掉开头的指定字符 
	    matcher = pattern.matcher(stream);
	    if (matcher.lookingAt()) {
	      epos = matcher.end();
	      stream = stream.substring(epos);
	    }
	 
	    // 返回处理后的字符串
	    return stream;
	  }
}
