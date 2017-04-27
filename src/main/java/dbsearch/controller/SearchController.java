package dbsearch.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import dbsearch.domain.Category;
import dbsearch.domain.Paper;
import dbsearch.service.impl.CategoryService;
import dbsearch.service.impl.PaperService;
import dbsearch.service.impl.SearchService;
import dbsearch.service.impl.UserService;

@Controller
public class SearchController {
	@Autowired
	private SearchService searchService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private UserService userService;
	@Autowired
	private PaperService paperService;
	
	String[] STR_LIST=Paper.STR_LIST;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/search")
	public String doSearch(Model model, HttpServletRequest request) {
		Map searchMap=new HashMap();
		for(int i=0;i<STR_LIST.length;i++){
			searchMap.put(STR_LIST[i], request.getParameter(STR_LIST[i]));
		}
		String con=request.getParameter("con");
		if(con.equals("0")){
			searchMap.put("failureBehave", request.getParameter("accidentName"));
			searchMap.put("failureCause", request.getParameter("accidentName"));
		}else{
			searchMap=searchService.addCate(searchMap, request.getParameter("category"));
		}
		int pageIndex=Integer.parseInt(request.getParameter("pageIndex"));
		List resultList=searchService.getSearchedPaper(pageIndex, searchMap, con);
		model.addAttribute("resultList", resultList);
		return "forward:/WX/wenxian_list";
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/searchCount")
	@ResponseBody
	public String doGetSearchCount(Model model, HttpServletRequest request) {
		Map searchMap=new HashMap();
		for(int i=0;i<STR_LIST.length;i++){
			searchMap.put(STR_LIST[i], request.getParameter(STR_LIST[i]));
		}
		String con=request.getParameter("con");
		if(con.equals("0")){
			searchMap.put("failureBehave", request.getParameter("accidentName"));
			searchMap.put("failureCause", request.getParameter("accidentName"));
		}else{
			searchMap=searchService.addCate(searchMap, request.getParameter("category"));
		}
		int count=searchService.getSearchedPaperCount(searchMap,con);
		return String.valueOf(count);
	}
	
	@RequestMapping(value = "/selectCate", method = RequestMethod.GET)
	public void doSelectCate(Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
		String parentId=request.getParameter("parentId");
		String xml_start = "<selects>"; 
        String xml_end = "</selects>"; 
        String xml = ""; 
        List childCateList=categoryService.getCategoryByParent(Integer.parseInt(parentId));
        if(!childCateList.isEmpty()){
        	for(int i=0;i<childCateList.size();i++){
        		Category category=(Category)childCateList.get(i);
        		xml += "<select><value>"+category.getId()+"</value><text>"+category.getName()+"</text></select>"; 
        	}
        }
        String last_xml = xml_start + xml + xml_end; 
        
        response.getWriter().write(last_xml); 
	}
	
	@RequestMapping(value = "/YH/wenxian_list_gr")
	public String doSearch_gr(Model model, HttpServletRequest request) {
		List<Category> parentCateList=categoryService.getCategoryByParent(1);
		model.addAttribute("parentCateList", parentCateList);
		return "/YH/wenxian_list_gr";
	}
	
	@RequestMapping(value = "/YH/wenxian_list_am")
	public String doSearch_am(Model model, HttpServletRequest request) {
		List<Category> parentCateList=categoryService.getCategoryByParent(1);
		model.addAttribute("parentCateList", parentCateList);
		return "/YH/wenxian_list_am";
	}
	
	@RequestMapping(value = "/searchWDGL")
	public String doSearchWDGL(Model model, HttpServletRequest request) {
		String operRole=request.getParameter("operRole");
		if(!operRole.equals("adm")){
			String email=(String)request.getSession().getAttribute("user");
			operRole=""+userService.getUser(email).getId();
		}
		String strSearch=request.getParameter("strSearch");
		String cateId=request.getParameter("cateId");
		String fileStatus=request.getParameter("fileStatus");
		int pageIndex=Integer.parseInt(request.getParameter("pageIndex"));
		List resultList=searchService.getSearchSearchWDGL(pageIndex, strSearch, cateId, fileStatus, operRole);
		model.addAttribute("strSearch",strSearch);
		model.addAttribute("cateId",cateId);
		model=setCate2Model(model,cateId);
		List<Category> parentCateList=categoryService.getCategoryByParent(1);
		model.addAttribute("parentCateList", parentCateList);
		if(operRole!=null&&operRole.equals("adm")){
			model.addAttribute("resultList_am", resultList);
			return "/YH/wenxian_am_tb";
		}else{
			model.addAttribute("resultList_gr", resultList);
			return "/YH/wenxian_gr_tb";
		}
	}
	@RequestMapping(value = "/ajax/getWDGLCount")
	@ResponseBody
	public String doGetWDGLCount(Model model, HttpServletRequest request) {
		String operRole=request.getParameter("operRole");
		if(!operRole.equals("adm")){
			String email=(String)request.getSession().getAttribute("user");
			operRole=""+userService.getUser(email).getId();
		}
		String strSearch=request.getParameter("strSearch");
		String cateId=request.getParameter("cateId");
		String fileStatus=request.getParameter("fileStatus");
		int count=searchService.getWDGLCount(strSearch, cateId, fileStatus, operRole);
		return String.valueOf(count);
	}
	
	private Model setCate2Model(Model model,String cateId){
		if(cateId==null||cateId.equals("")||cateId.equals("0")){
			return model;
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
				model.addAttribute("cate_F",parentId);
				model.addAttribute("cate_S",cateId);
			}else{//这是一个一级标题
				model.addAttribute("cate_F",cateId);
				model.addAttribute("cate_S",0);
			}
			return model;
		}
	}
}
