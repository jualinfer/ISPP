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
	private Boolean fromAtoB;
	private String content;
	
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
	public Boolean getFromAtoB() {
		return fromAtoB;
	}

	@NotNull
	@NotBlank
	public String getContent() {
		return content;
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
	
	public void setFromAtoB(Boolean fromAtoB) {
		this.fromAtoB = fromAtoB;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public void setThread(MessagesThread thread) {
		this.thread = thread;
	}
	
}
