package dbsearch.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import javax.validation.constraints.Null;

import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.record.PageBreakRecord.Break;
import org.aspectj.weaver.ast.And;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import dbsearch.domain.Category;
import dbsearch.domain.Paper;
import dbsearch.domain.User;
import dbsearch.service.impl.CategoryService;
import dbsearch.service.impl.PaperService;
import dbsearch.service.impl.UserService;
import dbsearch.util.FileMeta;
import dbsearch.util.FileParse;
import dbsearch.util.Word2pdf;

@Controller
public class HomeController {
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private PaperService paperService;
	@Autowired
	private UserService userService;

	String[] STR_LIST = Paper.STR_LIST;
	final static String allowExtNames = "pdf,doc,docx";
	
	@RequestMapping("")
	public String welcome1(Model model, HttpServletRequest request) {
		if (!model.containsAttribute("resultList")) {
			List resultList = paperService.getAllPaper();
			model.addAttribute("resultList", resultList);
		}
		List<Category> parentCateList = categoryService.getCategoryByParent(1);
		model.addAttribute("parentCateList", parentCateList);
		List<List<Category>> cateList = categoryService.getAllCategoryViaList();
		model.addAttribute("cateList", cateList);
		return "index";
	}
	
	@RequestMapping("/wenxian_commoncase")
	public String commoncase(Model model, HttpServletRequest request) {
		//***
		
		return "WX/wenxian_commoncase";
	}
	
	@RequestMapping("/YH/selfanalysis")
	public String selfamalysis(Model model, HttpServletRequest request) {
		//***锟斤拷锟斤拷一些锟斤拷锟捷达拷锟斤拷
		
		return "YH/selfanalysis";
	}
	
	
	@RequestMapping("/index")
	public String welcome2(Model model, HttpServletRequest request) {//锟剿猴拷锟斤拷锟斤拷实没锟斤拷锟斤拷
		if (!model.containsAttribute("resultList")) {
			List resultList = paperService.getAllPaper();
			model.addAttribute("resultList", resultList);
		}
		/*List<Category> parentCateList = categoryService.getCategoryByParent(1);
		model.addAttribute("parentCateList", parentCateList);
		List<List<Category>> cateList = categoryService.getAllCategoryViaList();
		model.addAttribute("cateList", cateList);*/
		//锟叫讹拷锟角凤拷锟铰斤拷锟斤拷丫锟斤拷锟铰斤拷锟斤拷锟斤拷锟斤拷锟铰斤拷锟絟idden
		//model.addAttribute("loginStatus", "req");
		return "index";
	}
	
	@RequestMapping("/index1")
	public String welcome(Model model, HttpServletRequest request) {
		if (!model.containsAttribute("resultList")) {
			List resultList = paperService.getAllPaper();
			model.addAttribute("resultList", resultList);
		}
		List<Category> parentCateList = categoryService.getCategoryByParent(1);
		model.addAttribute("parentCateList", parentCateList);
		List<List<Category>> cateList = categoryService.getAllCategoryViaList();
		model.addAttribute("cateList", cateList);
		model.addAttribute("loginStatus", "req");
		return "WX/wenxian_main";
	}

	@RequestMapping("/YH/{page}")
	public String yhPages(Model model, @PathVariable String page) {
		model.addAttribute("greeting", "Welcome	to	Web	Store!");
		model.addAttribute("tagline", "The	one	and	only	amazing	webstore");
		List<List<Category>> cateList = categoryService.getAllCategoryViaList();
		model.addAttribute("cateList", cateList);
		return "YH/" + page;
	}

	@RequestMapping("/WX/{page}")
	public String wxPages(Model model, @PathVariable String page) {
		model.addAttribute("greeting", "Welcome	to	Web	Store!");
		model.addAttribute("tagline", "The	one	and	only	amazing	webstore");
		List<List<Category>> cateList = categoryService.getAllCategoryViaList();
		model.addAttribute("cateList", cateList);
		return "WX/" + page;
	}

	@RequestMapping(value = "/insertCate", method = RequestMethod.POST)
	public String doInsertCate(Model model) {
		List<List<Category>> cateList = categoryService.getAllCategoryViaList();
		model.addAttribute("cateList", cateList);
		return "YH/leibie02";
	}

	@RequestMapping(value = "/insCate", method = RequestMethod.POST)
	public String doInsCate(Model model, HttpServletRequest request) {
		try {
			String parentId = request.getParameter("parent");
			String name = request.getParameter("name");
			Category category = new Category();
			category.setName(name);
			category.setParent(categoryService.getCategoryById(Integer.parseInt(parentId)));
			categoryService.addCategory(category);
			List<List<Category>> cateList = categoryService.getAllCategoryViaList();
			model.addAttribute("cateList", cateList);
			return "YH/leibie01";
		} catch (Exception e) {
			System.out.println(e);
			return "YH/leibie02";
		}
	}

	@RequestMapping(value = "/updateCate", method = RequestMethod.POST)
	public String doUpdateCate(Model model, HttpServletRequest request) {
		try {
			String cateId = request.getParameter("cateId");
			Category category = categoryService.getCategoryById(Integer.parseInt(cateId));
			model.addAttribute("category", category);
			return "YH/leibie03";
		} catch (Exception e) {
			System.out.println(e);
			List<List<Category>> cateList = categoryService.getAllCategoryViaList();
			model.addAttribute("cateList", cateList);
			return "YH/leibie01";
		}
	}

	@RequestMapping(value = "/upCate", method = RequestMethod.POST)
	public String doUpCate(Model model, HttpServletRequest request) {
		try {
			String cateId = request.getParameter("cateId");
			String cateName = request.getParameter("cateName");
			Category category = categoryService.getCategoryById(Integer.parseInt(cateId));
			category.setName(cateName);
			categoryService.updateCategory(category);

			List<List<Category>> cateList = categoryService.getAllCategoryViaList();
			model.addAttribute("cateList", cateList);
			return "YH/leibie01";
		} catch (Exception e) {
			System.out.println(e);
			return "YH/leibie03";
		}
	}

	@RequestMapping(value = "/deleteCate", method = RequestMethod.POST)
	public String doDeleteCate(Model model, HttpServletRequest request) {
		try {
			String cateId = request.getParameter("cateId");
			Category category = categoryService.getCategoryById(Integer.parseInt(cateId));
			categoryService.deleteCategory(category);

			List<List<Category>> cateList = categoryService.getAllCategoryViaList();
			model.addAttribute("cateList", cateList);
			return "YH/leibie01";
		} catch (Exception e) {
			System.out.println(e);
			return "YH/leibie01";
		}
	}

	@RequestMapping(value = "/WX/wenxian_upload", method = RequestMethod.GET)
	public String getUploadPaper(Model model) {
		List<Category> parentCateList = categoryService.getCategoryByParent(1);
		model.addAttribute("parentCateList", parentCateList);
		Paper paper = new Paper();
		model.addAttribute("newPaper", paper);
		return "/WX/wenxian_upload";
	}

	@RequestMapping(value = "/WX/wenxian_upload", method = RequestMethod.POST)
	public String doUploadPaper(Model model, @ModelAttribute("newPaper") @Valid Paper newPaper, BindingResult result,
			@RequestParam("file") MultipartFile file, HttpServletRequest request) {
		try {
			request.setCharacterEncoding("utf-8");// 锟斤拷止锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷
			
			String category = request.getParameter("category");
			newPaper.setCategory(categoryService.getCategoryById(Integer.parseInt(category)));
			Date date = new Date();
			newPaper.setUploadTime(date);// 锟斤拷锟斤拷锟侥硷拷锟较达拷时锟斤拷
			String email = (String) request.getSession().getAttribute("user");
			User user = userService.getUser(email);
			newPaper.setOwner(user);// 锟斤拷锟斤拷锟侥硷拷锟较达拷锟斤拷
			newPaper = paperService.setFileStatus(newPaper, user);// 锟斤拷锟矫癸拷锟斤拷员锟较达拷锟斤拷锟侥硷拷默锟斤拷锟斤拷锟酵拷锟�
			// 锟较达拷锟侥硷拷
			if (!file.isEmpty()) {
				final String allowExtNames = "pdf,doc,docx";

				String filename = file.getOriginalFilename(); // 锟矫碉拷锟较达拷时锟斤拷锟侥硷拷锟斤拷
				String extName = filename.substring(filename.lastIndexOf(".") + 1);
				String fileNameNoExt ="";
				if (allowExtNames.indexOf(extName) != -1) {
					try {
						// 锟斤拷锟斤拷锟侥硷拷锟斤拷锟斤拷u_id_time
						StringBuffer sb = new StringBuffer();
						sb.append("m_");
						sb.append(user.getId() + "_");
						DateFormat format = new SimpleDateFormat("yyyyMMddHHmmssSS");
						sb.append(format.format(new Date()));
						fileNameNoExt = sb.toString();
						sb.append("." + extName);
						filename = sb.toString();
						String dir = request.getServletContext().getRealPath("/WEB-INF/resources/uploaded"); // 
						//String dir = HomeController.class.getResource(arg0);
						FileUtils.writeByteArrayToFile(new File(dir, filename), file.getBytes());
						if (!filename.endsWith(".pdf")) {
							Word2pdf.convertFile(dir + File.separator + filename,
									dir + File.separator + fileNameNoExt + ".pdf");
						}
						newPaper.setFilePath(filename);
						paperService.addPaper(newPaper);
						System.out.println("upload over. " + filename);
					} catch (Exception e) {
						e.printStackTrace();
					}
				} else {
					throw new FileUploadException("file type is not allowed");
				}
			}

			return "/YH/gerenzhongxin";
		} catch (Exception e) {
			System.out.println(e);
			return "/WX/wenxian_upload";
		}
	}

	@RequestMapping(value = "/WX/wenxian_update", method = RequestMethod.GET)
	public String getUpdatePaper(Model model, HttpServletRequest request) {
		String paperId = request.getParameter("paperId");
		List<Category> parentCateList = categoryService.getCategoryByParent(1);
		model.addAttribute("parentCateList", parentCateList);
		Paper paper = new Paper();
		paper = paperService.getPaperById(Integer.parseInt(paperId));
		model.addAttribute("editPaper", paper);
		return "/WX/wenxian_update";
	}

	@RequestMapping(value = "/WX/wenxian_update", method = RequestMethod.POST)
	public String doUpdatePaper(Model model, @ModelAttribute("editPaper") @Valid Paper editPaper, BindingResult result,
			@RequestParam("file") MultipartFile file,HttpServletRequest request) {
		try {
			String category = request.getParameter("category");
			editPaper.setCategory(categoryService.getCategoryById(Integer.parseInt(category)));
			Date date = new Date();
			editPaper.setUploadTime(date);// 锟斤拷锟斤拷锟侥硷拷锟较达拷时锟斤拷
			String email = (String) request.getSession().getAttribute("user");
			User user = userService.getUser(email);
			// editPaper.setOwner(user);//锟斤拷锟斤拷锟侥硷拷锟较达拷锟斤拷
			editPaper = paperService.setFileStatus(editPaper, user);// 锟斤拷锟矫癸拷锟斤拷员锟较达拷锟斤拷锟侥硷拷默锟斤拷锟斤拷锟酵拷锟�
			// 锟较达拷锟侥硷拷
			if (!file.isEmpty()) {
				//锟斤拷删锟斤拷原锟斤拷锟斤拷锟侥硷拷
				String filePath = editPaper.getFilePath();
				String dir = request.getServletContext().getRealPath("WEB-INF/resources/uploaded"); // 路径问题
				paperService.deleteFile(filePath,dir);
				
				final String allowExtNames = "pdf,doc,docx";

				String filename = file.getOriginalFilename(); // 锟矫碉拷锟较达拷时锟斤拷锟侥硷拷锟斤拷
				String extName = filename.substring(filename.lastIndexOf(".") + 1);
				String fileNameNoExt ="";
				if (allowExtNames.indexOf(extName) != -1) {
					try {
						// 锟斤拷锟斤拷锟侥硷拷锟斤拷锟斤拷u_id_time
						StringBuffer sb = new StringBuffer();
						sb.append("m_");
						sb.append(user.getId() + "_");
						DateFormat format = new SimpleDateFormat("yyyyMMddHHmmssSS");
						sb.append(format.format(new Date()));
						fileNameNoExt = sb.toString();
						sb.append("." + extName);
						filename = sb.toString();
						
						FileUtils.writeByteArrayToFile(new File(dir, filename), file.getBytes());
						if (!filename.endsWith(".pdf")) {
							Word2pdf.convertFile(dir + File.separator + filename,
									dir + File.separator + fileNameNoExt + ".pdf");
						}
						editPaper.setFilePath(filename);
						paperService.addPaper(editPaper);
						System.out.println("upload over. " + filename);
					} catch (Exception e) {
						e.printStackTrace();
					}
				} else {
					throw new FileUploadException("file type is not allowed");
				}
			}

			Paper orgPaper = paperService.getPaperById(editPaper.getId());
			editPaper.setOwner(orgPaper.getOwner());
			editPaper.setFilePath(orgPaper.getFilePath());
			paperService.updatePaper(editPaper);

			Paper paper = (Paper) paperService.getPaperById(editPaper.getId());
			model.addAttribute("paper", paper);
			return "/WX/wenxian_view";
		} catch (Exception e) {
			System.out.println(e);
			return "/WX/wenxian_update";
		}
	}

	@RequestMapping(value = "/WX/wenxian_shenhe", method = RequestMethod.GET)
	public String doShenhePaper(Model model, HttpServletRequest request) {
		try {
			String paperId = request.getParameter("paperId");
			String fileStatus = request.getParameter("status");
			Paper paper = new Paper();
			paper = paperService.getPaperById(Integer.parseInt(paperId));
			paper.setFileStatus(Integer.parseInt(fileStatus));
			paperService.updatePaper(paper);
			List resultList = paperService.getAllPaper();
			model.addAttribute("resultList_am", resultList);
			return "forward:/YH/wenxian_list_am";
		} catch (Exception e) {
			System.out.println(e);
			List resultList = paperService.getAllPaper();
			model.addAttribute("resultList_am", resultList);
			return "forward:/YH/wenxian_list_am";
		}
	}

	@RequestMapping(value = "/WX/wenxian_delete", method = RequestMethod.GET)
	public String doDeletePaper(Model model, HttpServletRequest request) {
		String paperId = request.getParameter("paperId");
		String filePath = paperService.getPaperById(Integer.parseInt(paperId)).getFilePath();
		paperService.deletePaper(Integer.parseInt(paperId));
		String dir = request.getServletContext().getRealPath("/WEB-INF/resources/uploaded"); // 锟借定锟侥硷拷锟斤拷锟斤拷锟侥柯�
		paperService.deleteFile(filePath,dir);
		String operRole = request.getParameter("operRole");
		if (operRole != null && operRole.equals("adm")) {
			List resultList = paperService.getAllPaper();
			model.addAttribute("resultList_am", resultList);
			return "forward:/YH/wenxian_list_am";
		}
		return "forward:/YH/gerenzhongxin";
	}

	@RequestMapping(value = "/showPaper", method = RequestMethod.GET)
	public String doShowPaper(Model model, HttpServletRequest request) {
		try {
			String paperId = request.getParameter("paperId");
			Paper paper = (Paper) paperService.getPaperById(Integer.parseInt(paperId));
			model.addAttribute("errorInfo","");
			model.addAttribute("paper", paper);
			return "/WX/wenxian_view";
		} catch (Exception e) {
			System.out.println(e);
			return "/index";
		}

	}

	@RequestMapping(value = "/showPdf", method = RequestMethod.GET)
	public String showPdf(Model model, HttpServletRequest request) {
		String errorInfo="";
		try {
			String email = (String) request.getSession().getAttribute("user");
			User user = userService.getUser(email);
			
			String paperId = request.getParameter("paperId");
			Paper paper = (Paper) paperService.getPaperById(Integer.parseInt(paperId));
			
			User owner=paper.getOwner();
			if(owner.getId()!=user.getId() ){//id为1或2的文章免费
				if(user.getRole()==0){
					errorInfo="抱歉，您无权查看此文献，请申请VIP或联系管理员。";
					model.addAttribute("errorInfo",errorInfo);
					model.addAttribute("paper", paper);
					return "/WX/wenxian_view";
				}
			}
//			return "redirect:/web/viewer.html?file=/dbsearch/uploaded/"
//					+ paper.getFilePath().replaceFirst("docx$", "pdf").replaceFirst("doc$", "pdf");
			String filePath="/dbsearch/uploaded/"+ paper.getFilePath().replaceFirst("docx$", "pdf").replaceFirst("doc$", "pdf");
			String dir=request.getSession().getServletContext().getRealPath("/WEB-INF/resources/uploaded");
			File filePDF=new File(dir+File.separator+paper.getFilePath().replaceFirst("docx$", "pdf").replaceFirst("doc$", "pdf"));
			if(!filePDF.exists()==true){
				Word2pdf.convertFile(dir + File.separator + paper.getFilePath(),
						dir+File.separator+paper.getFilePath().replaceFirst("docx$", "pdf").replaceFirst("doc$", "pdf"));
			}
			return "redirect:/web/viewer.html?file="+filePath;
		} catch (Exception e) {
			System.out.println(e);
			return "/index";
		}

	}

	@RequestMapping(value = "/ajax/pure_upload", method = RequestMethod.POST)
	public @ResponseBody LinkedList<FileMeta> pureUpload(MultipartHttpServletRequest request,
			HttpServletResponse response) {

		Date startTime = new Date();
		LinkedList<FileMeta> files = new LinkedList<FileMeta>();
		FileMeta fileMeta = null;
		// 1. build an iterator
		Iterator<String> itr = request.getFileNames();
		MultipartFile mpf = null;
		
		String email = (String) request.getSession().getAttribute("user");
		User user = userService.getUser(email);
		// 2. get each file
		while (itr.hasNext()) {
			// 2.1 get next MultipartFile
			mpf = request.getFile(itr.next());
			String filename = "", fileNameNoExt = "";
			try {
				filename = URLDecoder.decode(mpf.getOriginalFilename(), "UTF-8");
			} catch (UnsupportedEncodingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} // 锟矫碉拷锟较达拷时锟斤拷锟侥硷拷锟斤拷
			System.out.println(filename + " uploaded! " + files.size());
			// 2.2 if files > 10 remove the first from the list
			if (files.size() >= 100)
				files.pop();
			// 2.3 create new fileMeta
			fileMeta = new FileMeta();
			fileMeta.setFileName(filename);
			fileMeta.setFileSize(mpf.getSize() / 1024 + " Kb");
			try {
				Paper newPaper = new Paper();
				newPaper.setOwner(user);// 锟斤拷锟斤拷锟侥硷拷锟较达拷锟斤拷
				newPaper = paperService.setFileStatus(newPaper, user);// 锟斤拷锟矫癸拷锟斤拷员锟较达拷锟斤拷锟侥硷拷默锟斤拷锟斤拷锟酵拷锟�

				String extName = filename.substring(filename.lastIndexOf(".") + 1);
				if (allowExtNames.indexOf(extName) != -1) {
					try {
						// 锟斤拷锟斤拷锟侥硷拷锟斤拷锟斤拷u_id_time
						StringBuffer sb = new StringBuffer();
						sb.append("m_");
						sb.append(user.getId() + "_");
						DateFormat format = new SimpleDateFormat("yyyyMMddHHmmssSS");
						sb.append(format.format(new Date()));
						fileNameNoExt = sb.toString();
						sb.append("." + extName);
						filename = sb.toString();
					} catch (Exception e) {

					}
				}
				String dir = request.getServletContext().getRealPath("/WEB-INF/resources/uploaded"); // 锟借定锟侥硷拷锟斤拷锟斤拷锟侥柯�
				FileCopyUtils.copy(mpf.getBytes(), new FileOutputStream(dir + File.separator + filename));
//				if (!filename.endsWith(".pdf")) {
//					Word2pdf.convertFile(dir + File.separator + filename,
//							dir + File.separator + fileNameNoExt + ".pdf");
//				}
				try {
					FileParse.fillModel(newPaper, dir + File.separator + filename);
					paperService.autoFillCategory(newPaper);
					newPaper.setFilePath(filename);
					newPaper.setAnalyseMethod("");
					paperService.addPaper(newPaper);
					fileMeta.setResult("上传成功");
				} catch (Exception e) {
					fileMeta.setResult("上传失败");
					e.printStackTrace();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			fileMeta.setTimeCost(String.valueOf((new Date().getTime() - startTime.getTime()) / 1000) + "秒");
			files.add(fileMeta);
		}
		return files;
	}
}