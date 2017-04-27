package dbsearch.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import dbsearch.domain.Category;
import dbsearch.domain.FieldKeyword;
import dbsearch.domain.Paper;
import dbsearch.domain.PaperField;
import dbsearch.service.impl.AnalysisService;
import dbsearch.service.impl.CategoryService;
import dbsearch.service.impl.PaperService;
import dbsearch.service.impl.SearchService;

@Controller
public class AnalysisController {

	@Autowired
	private PaperService paperService;
	@Autowired
	private AnalysisService analysisService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private SearchService searchService;
	
	String[] STR_LIST=Paper.STR_LIST;
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/analysis")
	@ResponseBody
	public List justTest(Model model, HttpServletRequest request) {
		String failureEquipment=request.getParameter("failureEquipment");//失效设备
		String cateId=request.getParameter("cateId");//失效形式和失效机理
		String failureComponent=request.getParameter("failureComponent");//失效部件
		String failureMaterial=request.getParameter("failureMaterial");//失效材料类型
		String gjcStr=request.getParameter("gjcStr");
		
		Map searchMap=new HashMap();
		for(int i=0;i<STR_LIST.length;i++){
			if("failureEquipment".equals(STR_LIST[i])){
				searchMap.put("failureEquipment", failureEquipment);
			}else if("failureComponent".equals(STR_LIST[i])){
				searchMap.put("failureComponent", failureComponent);
			}else if("failureMaterial".equals(STR_LIST[i])){
				searchMap.put("failureMaterial", failureMaterial);
			}else{
				searchMap.put(STR_LIST[i], "");
			}
		}
		
		searchMap=searchService.addCate(searchMap, cateId);
		
		List<Paper> papers=searchService.getAllSearchedPaper(searchMap, "1111111111111");
//		List<Paper> papers = paperService.getAllPaper();
		
		Set gjcSet=new HashSet();
		if(gjcStr!=null&&!gjcStr.isEmpty()){
			while(gjcStr.contains("&")){
				int x=Integer.parseInt(gjcStr.substring(0, gjcStr.indexOf("&")));
				gjcSet.add(x);
				if(gjcStr.indexOf("&")==gjcStr.length()-1)
					break;//剩最后一组数据不再截取
				gjcStr=gjcStr.substring(gjcStr.indexOf("&")+1);
			}
		}
		
		return analysisService.getStatisticInfo(papers,gjcSet);
	}
	
	@RequestMapping(value = "/Jump2Analysis", method = RequestMethod.POST)
	public String doJump2Analysis(Model model, HttpServletRequest request) {
		String failureEquipment=request.getParameter("failureEquipment");//失效设备
		String cateId=request.getParameter("cateId");//失效形式和失效机理
		String failureComponent=request.getParameter("failureComponent");//失效部件
		String failureMaterial=request.getParameter("failureMaterial");//失效材料类型
		String gjcStr=request.getParameter("gjcStr");
		
		model.addAttribute("failureEquipment", failureEquipment);
		model.addAttribute("cateId", cateId);
		model.addAttribute("failureComponent", failureComponent);
		model.addAttribute("failureMaterial", failureMaterial);
		model.addAttribute("gjcStr", gjcStr);
		return "/WX/analysis";
	}
	
	@RequestMapping(value = "/GRTJFX", method = RequestMethod.POST)
	public String doGRTJFX(Model model, HttpServletRequest request) {
		String failureEquipment=request.getParameter("failureEquipment");//失效设备
		String cateId=request.getParameter("cateId");//失效形式和失效机理
		String failureComponent=request.getParameter("failureComponent");//失效部件
		String failureMaterial=request.getParameter("failureMaterial");//失效材料类型
		
		Map searchMap=new HashMap();
		for(int i=0;i<STR_LIST.length;i++){
			if("failureEquipment".equals(STR_LIST[i])){
				searchMap.put("failureEquipment", failureEquipment);
			}else if("failureComponent".equals(STR_LIST[i])){
				searchMap.put("failureComponent", failureComponent);
			}else if("failureMaterial".equals(STR_LIST[i])){
				searchMap.put("failureMaterial", failureMaterial);
			}else{
				searchMap.put(STR_LIST[i], "");
			}
		}
		
		searchMap=searchService.addCate(searchMap, cateId);
		
		List<Paper> papers=searchService.getAllSearchedPaper(searchMap, "1111111111111");
//		List<Paper> papers = paperService.getAllPaper();
		
		List resList=analysisService.getGRStatisticInfo(papers);
		model.addAttribute("resSum",papers.size());
		model.addAttribute("resList", resList);
		return "/YH/grtjfx_zdjg";
	}
	
	@RequestMapping(value = "/YH/tjfx")
	public String doSearch_tjfx(Model model, HttpServletRequest request) {
		List<Category> parentCateList=categoryService.getCategoryByParent(1);
		model.addAttribute("parentCateList", parentCateList);
		//加载关键词
		List fieldList=analysisService.getPaperField();
		Map fieldMap=new HashMap();
		PaperField paperField;
		if(fieldList!=null){
			for(int i=0;i<fieldList.size();i++){
				paperField=(PaperField)fieldList.get(i);
				fieldMap.put(paperField.getName(), analysisService.getKeyswords(paperField.getId()));
			}
		}
		model.addAttribute("fieldList", fieldList);
		model.addAttribute("fieldMap", fieldMap);
		return "/YH/tjfx";
	}
	
	@RequestMapping(value = "/YH/grtjfx")
	public String doSearch_grtjfx(Model model, HttpServletRequest request) {
		List<Category> parentCateList=categoryService.getCategoryByParent(1);
		model.addAttribute("parentCateList", parentCateList);
		//加载关键词
		List fieldList=analysisService.getPaperField();
		Map fieldMap=new HashMap();
		PaperField paperField;
		if(fieldList!=null){
			for(int i=0;i<fieldList.size();i++){
				paperField=(PaperField)fieldList.get(i);
				fieldMap.put(paperField.getName(), analysisService.getKeyswords(paperField.getId()));
			}
		}
		model.addAttribute("fieldList", fieldList);
		model.addAttribute("fieldMap", fieldMap);
		return "/YH/grtjfx";
	}
	@RequestMapping(value = "/searchTJFX", method = RequestMethod.POST)
	public String doSearchTJFX(Model model, HttpServletRequest request) {
		String failureEquipment=request.getParameter("failureEquipment");//失效设备
		String cateId=request.getParameter("cateId");//失效形式和失效机理
		String failureComponent=request.getParameter("failureComponent");//失效部件
		String failureMaterial=request.getParameter("failureMaterial");//失效材料类型
		int pageIndex=Integer.parseInt(request.getParameter("pageIndex"));
		
		Map searchMap=new HashMap();
		for(int i=0;i<STR_LIST.length;i++){
			if("failureEquipment".equals(STR_LIST[i])){
				searchMap.put("failureEquipment", failureEquipment);
			}else if("failureComponent".equals(STR_LIST[i])){
				searchMap.put("failureComponent", failureComponent);
			}else if("failureMaterial".equals(STR_LIST[i])){
				searchMap.put("failureMaterial", failureMaterial);
			}else{
				searchMap.put(STR_LIST[i], "");
			}
		}
		searchMap=searchService.addCate(searchMap, cateId);
		
		List resultList=searchService.getSearchedPaper(pageIndex, searchMap, "1111111111111");
		model.addAttribute("resultList", resultList);
		
		return "/YH/tjfx_tb";
	}

	@RequestMapping(value = "/ajax/getTJFXCount")
	@ResponseBody
	public String doGetTJFXCount(Model model, HttpServletRequest request) {
		String failureEquipment=request.getParameter("failureEquipment");//失效设备
		String cateId=request.getParameter("cateId");//失效形式和失效机理
		String failureComponent=request.getParameter("failureComponent");//失效部件
		String failureMaterial=request.getParameter("failureMaterial");//失效材料类型
		
		Map searchMap=new HashMap();
		for(int i=0;i<STR_LIST.length;i++){
			if("failureEquipment".equals(STR_LIST[i])){
				searchMap.put("failureEquipment", failureEquipment);
			}else if("failureComponent".equals(STR_LIST[i])){
				searchMap.put("failureComponent", failureComponent);
			}else if("failureMaterial".equals(STR_LIST[i])){
				searchMap.put("failureMaterial", failureMaterial);
			}else{
				searchMap.put(STR_LIST[i], "");
			}
		}
		searchMap=searchService.addCate(searchMap, cateId);
		
		int count=searchService.getSearchedPaperCount(searchMap, "1111111111111");
		return String.valueOf(count);
	}
	
	
	@RequestMapping(value = "/TJFX_GetKeyWords")
	public String doGetKeyWords(Model model) {
		List fieldList=analysisService.getPaperField();
		Map fieldMap=new HashMap();
		PaperField paperField;
		if(fieldList!=null){
			for(int i=0;i<fieldList.size();i++){
				paperField=(PaperField)fieldList.get(i);
				fieldMap.put(paperField.getName(), analysisService.getKeyswords(paperField.getId()));
			}
		}
		model.addAttribute("fieldList", fieldList);
		model.addAttribute("fieldMap", fieldMap);
		return "/YH/tjfx_keywords";
	}
	
	@RequestMapping(value = "/TJFXKeyWordsInsert", method = RequestMethod.POST)
	public String doTJFXKeyWordsInsert(Model model, HttpServletRequest request) throws UnsupportedEncodingException{
		request.setCharacterEncoding("utf-8");// 防止中文名乱码
		
		String fieldId=request.getParameter("fieldId");
		String keyWord=request.getParameter("keyWord");
		String improvement=request.getParameter("improvement");
		FieldKeyword fieldKeyword = new FieldKeyword();
		fieldKeyword.setField(analysisService.getPaperFieldById(Integer.parseInt(fieldId)));
		if(keyWord!=null&&!keyWord.trim().equals(""))
			fieldKeyword.setKeyWord(keyWord);
		if(improvement!=null&&!improvement.trim().equals(""))
			fieldKeyword.setImprovement(improvement);;
		analysisService.addFieldKeyword(fieldKeyword);
		
		List fieldList=analysisService.getPaperField();
		Map fieldMap=new HashMap();
		PaperField paperField;
		if(fieldList!=null){
			for(int i=0;i<fieldList.size();i++){
				paperField=(PaperField)fieldList.get(i);
				fieldMap.put(paperField.getName(), analysisService.getKeyswords(paperField.getId()));
			}
		}
		model.addAttribute("fieldList", fieldList);
		model.addAttribute("fieldMap", fieldMap);
		return "/YH/tjfx_keywords";
	}
	
	@RequestMapping(value = "/TJFXKeyWordsAlter", method = RequestMethod.POST)
	public String doTJFXKeyWordsAlter(Model model, HttpServletRequest request) throws UnsupportedEncodingException{
		request.setCharacterEncoding("utf-8");// 防止中文名乱码
		
		String keyWordId=request.getParameter("keyWordId");
		String keyWord=request.getParameter("keyWord");
		String improvement=request.getParameter("improvement");
		
		FieldKeyword fieldKeyword = analysisService.getKeywordById(Integer.parseInt(keyWordId));
		if(keyWord!=null&&!keyWord.trim().equals(""))
			fieldKeyword.setKeyWord(keyWord);
		if(improvement!=null&&!improvement.trim().equals(""))
			fieldKeyword.setImprovement(improvement);;
		analysisService.updateFieldKeyword(fieldKeyword);
		
		List fieldList=analysisService.getPaperField();
		Map fieldMap=new HashMap();
		PaperField paperField;
		if(fieldList!=null){
			for(int i=0;i<fieldList.size();i++){
				paperField=(PaperField)fieldList.get(i);
				fieldMap.put(paperField.getName(), analysisService.getKeyswords(paperField.getId()));
			}
		}
		model.addAttribute("fieldList", fieldList);
		model.addAttribute("fieldMap", fieldMap);
		return "/YH/tjfx_keywords";
	}
	
	@RequestMapping(value = "/TJFXKeyWordsDelete", method = RequestMethod.POST)
	public String doTJFXKeyWordsDelete(Model model, HttpServletRequest request) throws UnsupportedEncodingException{
		request.setCharacterEncoding("utf-8");// 防止中文名乱码
		
		String keyWordId=request.getParameter("keyWordId");
		
		FieldKeyword fieldKeyword = analysisService.getKeywordById(Integer.parseInt(keyWordId));
		analysisService.deleteFieldKeyword(fieldKeyword);
		
		List fieldList=analysisService.getPaperField();
		Map fieldMap=new HashMap();
		PaperField paperField;
		if(fieldList!=null){
			for(int i=0;i<fieldList.size();i++){
				paperField=(PaperField)fieldList.get(i);
				fieldMap.put(paperField.getName(), analysisService.getKeyswords(paperField.getId()));
			}
		}
		model.addAttribute("fieldList", fieldList);
		model.addAttribute("fieldMap", fieldMap);
		return "/YH/tjfx_keywords";
	}
}
