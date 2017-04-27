package dbsearch.service.impl;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dbsearch.domain.Category;
import dbsearch.domain.Paper;
import dbsearch.domain.User;
import dbsearch.domain.repository.CategoryRepository;
import dbsearch.domain.repository.PaperRepository;

@Service
public class PaperService {
	@Autowired
	private PaperRepository paperRepository;
	@Autowired
	private CategoryRepository categoryRepository;
	
	public List<Paper> getAllPaper(){
		return paperRepository.getAllPaper();
	}
	
	public boolean addPaper(Paper paper){
		return paperRepository.addPaper(paper);
	}
	
	public Paper getPaperById(int id) {
		return paperRepository.getPaperById(id);
	}
	
	public boolean updatePaper(Paper paper) {
		return paperRepository.updatePaper(paper);
	}
	
	public boolean deletePaper(int id) {
		return paperRepository.deletePaper(id);
	}
	
	public List<Paper> getPaperByOwner(int ownerId) {
		return paperRepository.getPaperByOwner(ownerId);
	}
	
	//设置管理员上传的文件默认审核通过
	public Paper setFileStatus(Paper paper, User user){
		if(user.getRole()==10){
			paper.setFileStatus(1);
			return paper;
		}else{
			paper.setFileStatus(0);
			return paper;
		}
		
	}
	
	/**   
	* 删除单个文件   
	* @param   fileName    被删除文件的文件名   
	* @return 单个文件删除成功返回true,否则返回false   
	*/   
	public boolean deleteFile(String fileName,String dir){
		boolean flag=false;
		File file = new File(dir+ File.separator +fileName);
		if (file.isFile() && file.exists()) {
			file.delete();//"删除单个文件"+name+"成功！"
			flag= true;
		}//"删除单个文件"+name+"失败！"
		if(fileName.indexOf(".pdf")<1){//原先上传的是word文件
			fileName=fileName.substring(0, fileName.lastIndexOf('.'))+".pdf";
			File file1 = new File(dir+ File.separator +fileName);
			if (file1.isFile() && file1.exists()) {
				file1.delete();//"删除单个文件"+name+"成功！"
				flag= true;
			}
		}
		return flag;
	}
	public void autoFillCategory(Paper paper){
		Category cate =  categoryRepository.getCategory(paper.getFailureBehave(), paper.getFailureCause());
		paper.setCategory(cate);
	}
}
