package domain;

import java.util.Date;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Access(AccessType.PROPERTY)
public class Message extends DomainEntity {
	
	//Attributes

	private Date issueDate;
	private Boolean AtoB;
	private String content;
	private Boolean read;
	
	//Relationships
	
	private MessagesThread thread;
	
	public Message() {
		super();
	}

	//Getter

	@NotNull
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm")
	public Date getIssueDate() {
		return issueDate;
	}
	
	@NotNull
	public Boolean getAtoB() {
		return AtoB;
	}

	@NotNull
	@NotBlank
	public String getContent() {
		return content;
	}
	
	@NotNull
	public Boolean getRead() {
		return read;
	}
	
	@Valid
	@NotNull
	@ManyToOne(optional = false)
	public MessagesThread getThread() {
		return thread;
	}
	
	//Setter
	
	public void setIssueDate(Date issueDate) {
		this.issueDate = issueDate;
	}
	
	public void setAtoB(Boolean AtoB) {
		this.AtoB = AtoB;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public void setRead(Boolean read) {
		this.read = read;
	}
	
	public void setThread(MessagesThread thread) {
		this.thread = thread;
	}
	
}
