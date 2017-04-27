package dbsearch.domain;

import java.util.Date;
import java.util.Set;

import javax.persistence.*;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

import dbsearch.validator.UserEmail;

@Entity(name = "user")
@Table
public class User {//用户类
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	@Column(length = 100)
	@NotEmpty(message = "邮箱不能为空")
	@Email(message = "{email.validation}")
	@UserEmail(message = "{user.email.replicator.message}")
	private String email;
	@Column
	@Size(min = 1, max = 40, message = "{user.password.message}")
	private String password;
	@Column
	private int role = 0;
	@Column
	private String randomCode = String.valueOf(Math.random());
	
	//积分
	private int score=-1;

	public String getRandomCode() {
		return randomCode;
	}

	public void setRandomCode(String randomCode) {
		this.randomCode = randomCode;
	}

	public User() {
		super();
		// TODO Auto-generated constructor stub
	}

	public User(String email, String password) {
		super();
		this.email = email;
		this.password = password;
		// TODO Auto-generated constructor stub
	}
	@Column
	private Date regiDate = new Date();
	@OneToMany(mappedBy = "owner")
	private Set<Paper> papers;

	public int getId() {
		return id;
	}
	//积分操作
	public int getScore()
	{
		return score;
	}
	
	public void addScore(int num){
		this.score = this.score + num;
	}
	
	public void reduceScore(int num){
		this.score = this.score - num;
	}
	
	
	
	///
	public void setId(int id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}

	public Date getRegiDate() {
		return regiDate;
	}

	public void setRegiDate(Date regiDate) {
		this.regiDate = regiDate;
	}

	public Set<Paper> getPapers() {
		return papers;
	}

	public void setPapers(Set<Paper> papers) {
		this.papers = papers;
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
		if (!(obj instanceof User))
			return false;
		User other = (User) obj;
		if (id != other.id)
			return false;
		return true;
	}

}
