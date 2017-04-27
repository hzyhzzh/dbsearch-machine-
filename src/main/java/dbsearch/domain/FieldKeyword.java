package dbsearch.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity(name = "fieldkeyword")
@Table
public class FieldKeyword {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	@ManyToOne
	@JoinColumn(name = "field")
	private PaperField field;
	@Column
	private String keyWord;
	@Column
	private String improvement;

	public FieldKeyword() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public PaperField getField() {
		return field;
	}

	public void setField(PaperField field) {
		this.field = field;
	}

	public String getImprovement() {
		if(improvement!=null)
			return improvement;
		else
			return "";
	}

	public void setImprovement(String improvement) {
		this.improvement = improvement;
	}
	
	public String getKeyWord() {
		return keyWord;
	}

	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof FieldKeyword))
			return false;
		FieldKeyword other = (FieldKeyword) obj;
		if (id != other.id)
			return false;
		return true;
	}
}
