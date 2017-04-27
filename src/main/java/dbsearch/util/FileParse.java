package dbsearch.util;

import java.lang.reflect.Method;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import dbsearch.domain.Paper;

public class FileParse {

	public static void main(String[] args) {
		try {
			fillModel(new Paper(), "E:\\case1.doc");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void fillModel(Paper paper, String path) throws Exception {
		String text;
		if (path.endsWith(".pdf")) {
			text = PdfParse.getText(path);
		} else if (path.endsWith(".doc") || path.endsWith(".docx")) {
			text = WordParse.getText(path);
		} else
			throw new Exception("source file is not pdf or word format");
		int index = 0;
		String[] fieldName = {"事故名称","事故时间","事故地点","产品制造商信息","失效设备","失效部件","应用环境","失效形式","失效机理","失效材料类型","失效材料信息",
				"事故概览","失效分析目的","分析方法","分析结论"};
		String[] regs = { "(?<=事故名称).+?(?=事故时间)", "(?<=事故时间).+?(?=事故地点)", "(?<=事故地点).+?(?=产品制造商信息)",
				"(?<=产品制造商信息(（包括名称、地址等）)?).+?(?=失效设备)", "(?<=失效设备).+?(?=失效部件)", "(?<=失效部件).+?(?=应用环境)",
				"(?<=应用环境).+?(?=失效形式)", "(?<=失效形式).+?(?=失效机理)", "(?<=失效机理).+?(?=失效材料类型)", "(?<=失效材料类型).+?(?=失效材料信息)",
				"(?<=失效材料信息(（包括成分、力学性能等）)?).+?(?=事故概览)", "(?<=事故概览).+?(?=失效分析目的)", "(?<=失效分析目的).+?(?=分析方法.{0,4}测试项目)",
				"(?<=分析方法.{0,4}测试项目).+?(?=分析结果)", "(?<=分析结论).+(?=研究人员及其单位)", };
		Class c = paper.getClass();
		Method[] methods = { c.getMethod("setAccidentName", new Class[] { String.class }),
				c.getMethod("setAccidentTime", new Class[] { String.class }),
				c.getMethod("setAccidentLocation", new Class[] { String.class }),
				c.getMethod("setProductor", new Class[] { String.class }),
				c.getMethod("setFailureEquipment", new Class[] { String.class }),
				c.getMethod("setFailureComponent", new Class[] { String.class }),
				c.getMethod("setApplyEnv", new Class[] { String.class }),
				c.getMethod("setFailureBehave", new Class[] { String.class }),
				c.getMethod("setFailureCause", new Class[] { String.class }),
				c.getMethod("setFailureMaterial", new Class[] { String.class }),
				c.getMethod("setMaterialInfo", new Class[] { String.class }),
				c.getMethod("setAccidentDescription", new Class[] { String.class }),
				c.getMethod("setAnalyseGoal", new Class[] { String.class }),
				c.getMethod("setAnalyseMethod", new Class[] { String.class }),
				c.getMethod("setAnalyseConclusion", new Class[] { String.class }), };
		boolean[] nullAble = {false,true,true,true,false,true,false,false,false,false,false,true,true,true,false};
		Pattern p;
		Matcher m;
		String reg;
		Method meth;
		int i = 0;
		for (; i < regs.length - 1; i++) {
			reg = regs[i];
			meth = methods[i];
			p = Pattern.compile(reg, Pattern.DOTALL);
			m = p.matcher(text);
			if (m.find(index)) {
				index = m.end();
				meth.invoke(paper, m.group().trim());
				System.out.println(m.group());
			}
			else if(nullAble[i] ==false)
				throw new Exception(fieldName[i]+" 解析失败");
		}
		reg = regs[i];
		meth = methods[i];
		p = Pattern.compile(reg, Pattern.DOTALL);
		m = p.matcher(text);
		String conclution = "";
		while (m.find(index)) { // get the last match
			conclution = m.group().trim();
			index = m.start() + 1;
		}
		meth.invoke(paper, conclution);
		System.out.println(conclution);
	}
}
