package dbsearch.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dbsearch.domain.Category;
import dbsearch.domain.Paper;
import dbsearch.domain.repository.SearchRepository;

@Service
public class SearchService {
	@Autowired
	private SearchRepository searchRepository;
	@Autowired
	private CategoryService categoryService;
	
	public List<Paper> getAllSearchedPaper(Map sMap,String con) {
		return searchRepository.getAllSearchedPaper(sMap,con);
	}
	
	public List<Paper> getSearchedPaper(int pageIndex, Map sMap,String con) {
		return searchRepository.getSearchedPaper(pageIndex,sMap,con);
	}
	
	public int getSearchedPaperCount(Map sMap,String con) {
		return searchRepository.getSearchedPaperCount(sMap,con);
	}
	
	public List<Paper> getSearchSearchWDGL(int pageIndex, String strSearch, String cateId,String fileStatus, String searchRole) {
		String[] STR_LIST=Paper.STR_LIST;
		Map searchMap=new HashMap();
		for(int i=0;i<STR_LIST.length;i++){
			searchMap.put(STR_LIST[i], strSearch);
		}
		searchMap=addCate(searchMap,cateId);
		return searchRepository.getSearchSearchWDGL(pageIndex, searchMap, fileStatus, searchRole);
	}
	
	public int getWDGLCount(String strSearch, String cateId, String fileStatus, String searchRole) {
		String[] STR_LIST=Paper.STR_LIST;
		Map searchMap=new HashMap();
		for(int i=0;i<STR_LIST.length;i++){
			searchMap.put(STR_LIST[i], strSearch);
		}
		searchMap=addCate(searchMap,cateId);
		return searchRepository.getWDGLCount(searchMap, fileStatus, searchRole);
	}
	
	public Map addCate(Map searchMap,String cateId){
		if(cateId==null||cateId.equals("")||cateId.equals("0")){
//			searchMap.put("category", "");
			searchMap.put("failureBehave", "");
			searchMap.put("failureCause", "");
		}else{
			int id=0;
			try {
			    id = Integer.parseInt(cateId);
			} catch (NumberFormatException e) {
			    e.printStackTrace();
			}
			Category tempCate=categoryService.getCategoryById(id);
			int parentId=tempCate.getParent().getId();
			if(parentId!=1){//这是一个二级标题
//				searchMap.put("category", id);
				searchMap.put("failureBehave", tempCate.getParent().getName());
				searchMap.put("failureCause", tempCate.getName());
			}else{//这是一个一级标题
//				List tempList=categoryService.getCategoryByParent(id);
//				if(!tempList.isEmpty()){
//					String tempCateStr="";
//					for(int i=0;i<tempList.size();i++){
//						tempCateStr+=" "+((Category)tempList.get(i)).getId();
//					}
//					searchMap.put("category", tempCateStr);
//				}else{
//					searchMap.put("category", id);
//				}
				searchMap.put("failureBehave", tempCate.getName());
				searchMap.put("failureCause", "");
			}
		}
		return searchMap;
	}
}
