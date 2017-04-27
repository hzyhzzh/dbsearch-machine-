package dbsearch.util;

import java.io.IOException;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.util.PDFTextStripper;

public class PdfParse {
	public static void main(String [] args) throws IOException{
		String text = getText("E:\\case1.pdf");
		System.out.print(text.replaceAll("\r\n", "").replaceAll("\n", ""));
	}
	public static String getText(String path) throws IOException {
		PDDocument doc = PDDocument.load(path);
		PDFTextStripper stripper = new PDFTextStripper();

		return stripper.getText(doc).replaceAll("\r\n", "").replaceAll("\n", "");
	}
}
