package dbsearch.util;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.List;

import org.apache.poi.POIXMLException;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.usermodel.Range;
import org.apache.poi.hwpf.usermodel.Table;
import org.apache.poi.hwpf.usermodel.TableCell;
import org.apache.poi.hwpf.usermodel.TableIterator;
import org.apache.poi.hwpf.usermodel.TableRow;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;

public class WordParse {
	public static void main(String[] args) throws Exception {
		String text = getText("E:\\failed\\145.doc");
		System.out.print(text);
	}

	public static String getCellText(XWPFTableCell sourceCell) {
		if (sourceCell == null)
			return "";
		StringBuffer content = new StringBuffer();
		content.append(sourceCell.getText().trim());
		for (XWPFTable table : sourceCell.getTables()) {
			for (XWPFTableRow row : table.getRows()) {
				for (XWPFTableCell cell : row.getTableCells()) {
					content.append(getCellText(cell));
				}
			}
		}
		return content.toString();
	}

	public static String getText(String path) throws Exception {
		StringBuffer content = new StringBuffer();
		try {
			InputStream is = new FileInputStream(path);
			XWPFDocument docx = new XWPFDocument(is);
			List<XWPFTable> tables = docx.getTables();
			for (XWPFTable table : tables) {
				for (XWPFTableRow row : table.getRows()) {
					for (XWPFTableCell cell : row.getTableCells()) {
						content.append(getCellText(cell));
					}
				}
			}
		} catch (POIXMLException xmlexp) {
			InputStream is = new FileInputStream(path);
			HWPFDocument doc = new HWPFDocument(is);
			Range range = doc.getRange();
			TableIterator tableIter = new TableIterator(range);
			Table table;
			TableRow row;
			TableCell cell;
			while (tableIter.hasNext()) {
				table = tableIter.next();
				int rowNum = table.numRows();
				for (int j = 0; j < rowNum; j++) {
					row = table.getRow(j);
					int cellNum = row.numCells();
					for (int k = 0; k < cellNum; k++) {
						cell = row.getCell(k);
						content.append(cell.text().trim());
					}
				}
			}

		}
		return content.toString();
	}
}
