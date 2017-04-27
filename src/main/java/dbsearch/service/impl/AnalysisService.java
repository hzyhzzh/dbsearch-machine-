package dbsearch.service.impl;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dbsearch.domain.FieldKeyword;
import dbsearch.domain.Paper;
import dbsearch.domain.PaperField;
import dbsearch.domain.repository.AnalysisRepository;
import dbsearch.domain.repository.PaperRepository;

@Service
public class AnalysisService {
	@Autowired
	private AnalysisRepository analysisRepository;
	@Autowired
	private PaperRepository paperRepository;

	public List getStatisticInfo(List<Paper> collection, Set gjcSet) {
		List sumList = new LinkedList();
		for (PaperField field : analysisRepository.getConsiderdFields()) {
			Map<String, Object> fieldMap = new HashMap<>();
			fieldMap.put("title", field.getTitle());
//			fieldMap.put("name", field.getName());
			String fieldName=field.getName();
			fieldName=fieldName.replaceAll("failure", "FL");//解决name长度溢出问题
			fieldMap.put("name", fieldName);
			List dataList = new LinkedList();
			int amountSum=0;
			if(!gjcSet.isEmpty())
			for (FieldKeyword keyword : analysisRepository.getKeyswords(field.getId())) {
				if(gjcSet.contains(keyword.getId())){//判断关键词是否在set中，即关键词是否选中
					Map<String, Object> dataMap = new HashMap<>();
					try {
						dataMap.put("keyword", keyword.getKeyWord());
						dataMap.put("amount",
								filterPaper(collection, field.getName(), keyword.getKeyWord()).size());
						amountSum+=filterPaper(collection, field.getName(), keyword.getKeyWord()).size();
					} catch (Exception e) {
						e.printStackTrace();
					}
					dataList.add(dataMap);
				}
			}
			Map<String, Object> dataMap1 = new HashMap<>();
			dataMap1.put("keyword", "其它");
			dataMap1.put("amount",collection.size()-amountSum);
			dataList.add(dataMap1);
			
			fieldMap.put("data", dataList);
			sumList.add(fieldMap);
		}
		return sumList;
	}
	
	//会员用户统计分析
	public List getGRStatisticInfo(List<Paper> collection) {
		List sumList = new LinkedList();
		for (PaperField field : analysisRepository.getConsiderdFields()) {
			Map<String, Object> fieldMap = new HashMap<>();
			fieldMap.put("title", field.getTitle());
			String fieldName=field.getName();
			fieldMap.put("name", fieldName);
			List dataList = new LinkedList();
			int amountSum=0;
			for (FieldKeyword keyword : analysisRepository.getKeyswords(field.getId())) {
					Map<String, Object> dataMap = new HashMap<>();
					try {
						dataMap.put("keyword", keyword.getKeyWord());
						dataMap.put("improvement", keyword.getImprovement());
						dataMap.put("amount",
								filterPaper(collection, field.getName(), keyword.getKeyWord()).size());
						amountSum+=filterPaper(collection, field.getName(), keyword.getKeyWord()).size();
					} catch (Exception e) {
						e.printStackTrace();
					}
					dataList.add(dataMap);
			}
			fieldMap.put("data", dataList);
			sumList.add(fieldMap);
		}
		return sumList;
	}
	
	public List<Paper> filterPaper(List<Paper> collection, String fieldName, String fieldKeyword) throws Exception {
		if (fieldName == null || fieldKeyword == null || collection == null)
			return null;
		List<Paper> resultList = new LinkedList<Paper>();
		Method targetMethod = null;
		for (Method method : Paper.class.getMethods()) {
			if (method.getName().startsWith("get") && method.getName().endsWith(fieldName.substring(1))) {
				targetMethod = method;
				break;
			}
		}
		if (targetMethod == null)
			return null;
		for (Paper paper : collection) {
			String fieldValue = (String) targetMethod.invoke(paper);
			if (fieldValue != null && fieldValue.toLowerCase().contains(fieldKeyword.toLowerCase())) {
				resultList.add(paper);
			}
		}
		return resultList;
	}
	
	public List<PaperField> getPaperField(){
		return analysisRepository.getConsiderdFields();
	}
	
	public PaperField getPaperFieldById(int fieldId){
		return analysisRepository.getPaperFieldById(fieldId);
	}
	
	public List<FieldKeyword> getKeyswords(int fieldId){
		return analysisRepository.getKeyswords(fieldId);
	}
	
	public FieldKeyword getKeywordById(int keyword){
		return analysisRepository.getKeywordById(keyword);
	}
	
	public boolean addFieldKeyword(FieldKeyword fieldKeyword){
		return analysisRepository.addFieldKeyword(fieldKeyword);
	}
	
	public boolean updateFieldKeyword(FieldKeyword fieldKeyword) {
		return analysisRepository.updateFieldKeyword(fieldKeyword);
	}
	
	public boolean deleteFieldKeyword(FieldKeyword fieldKeyword) {
		return analysisRepository.deleteFieldKeyword(fieldKeyword);
	}
}
