package dbsearch.util;

import java.io.File;
import java.util.Properties;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;

import org.springframework.web.context.ContextLoader;

import com.documents4j.api.DocumentType;
import com.documents4j.api.IConverter;
import com.documents4j.job.RemoteConverter;

public class Word2pdf {
	private static File tempDir = new File(
			ContextLoader.getCurrentWebApplicationContext().getServletContext().getRealPath("/tmp"));
	private static IConverter converter;
	private static Properties prop = (Properties) ContextLoader.getCurrentWebApplicationContext().getBean("appConfig");
	private static String listenUrl = prop.getProperty("convert.url");

	static {
		if (!tempDir.exists()) {
			tempDir.mkdirs();
		}
		converter = RemoteConverter.builder().baseFolder(tempDir).workerPool(20, 25, 2, TimeUnit.SECONDS)
				.requestTimeout(15, TimeUnit.SECONDS).baseUri(listenUrl).build();
	}

	public static boolean convertFile(String wordPath, String pdfPath) {
		File wordFile = new File(wordPath), target = new File(pdfPath);
		if (!converter.isOperational()) {
			converter = RemoteConverter.builder().baseFolder(tempDir).workerPool(20, 25, 2, TimeUnit.SECONDS)
					.requestTimeout(15, TimeUnit.SECONDS).baseUri(listenUrl).build();
		}
		converter.convert(wordFile).as(DocumentType.MS_WORD).to(target)
				.as(DocumentType.PDF).prioritizeWith(1000) // optional
				.execute();
		return false;
	}

	public static boolean convertDir(String dir) {
		File root = new File(dir);
		if (!root.isDirectory())
			return false;
		for (String fName : root.list()) {
			if (!fName.endsWith(".doc") && !fName.endsWith(".docx"))
				continue;
			convertFile(dir + "/" + fName,
					dir + "/" + fName.substring(0, fName.lastIndexOf(".doc", fName.length() - 5)) + ".pdf");
		}
		return true;
	}
}
