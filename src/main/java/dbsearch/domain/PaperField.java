package dbsearch.domain;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity(name = "paperfield")
@Table
public class PaperField {
	public PaperField() {
		// TODO Auto-generated constructor stub
	}
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	@Column
	private String name;
	@Column
	private String title;
	@Column
	private boolean isStatistical;
	@OneToMany(mappedBy = "field")
	private Set<FieldKeyword> keywords;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isStatistical() {
		return isStatistical;
	}

	public void setStatistical(boolean isStatistical) {
		this.isStatistical = isStatistical;
	}

	public Set<FieldKeyword> getKeywords() {
		return keywords;
	}

	public void setKeywords(Set<FieldKeyword> keywords) {
		this.keywords = keywords;
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
		if (!(obj instanceof PaperField))
			return false;
		PaperField other = (PaperField) obj;
		if (id != other.id)
			return false;
		return true;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
}
