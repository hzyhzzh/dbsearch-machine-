package dbsearch.util;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties({ "bytes" })
public class FileMeta {
	private String fileName;
	private String fileSize;
	private String timeCost;
	private String result;

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public String getTimeCost() {
		return timeCost;
	}

	public void setTimeCost(String fileType) {
		this.timeCost = fileType;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
}
