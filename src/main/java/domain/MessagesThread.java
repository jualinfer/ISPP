package domain;

import java.util.Collection;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.validation.Valid;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

@Entity
@Access(AccessType.PROPERTY)
public class MessagesThread extends DomainEntity {
	
	//Attributes
	
	private Boolean closed;
	private Integer newMessages;
	
	//Relationships
	
	private Route route;
	private Actor participantA;
	private Actor participantB;
	private Actor reportedUser;
	private Message lastMessage;
	private Collection<Message> messages;
	
	public MessagesThread() {
		super();
	}

	//Getter
	
	@NotNull
	public Boolean getClosed() {
		return closed;
	}
	
	@Valid
	@OneToOne(optional=true)
	public Message getLastMessage() {
		return lastMessage;
	}
	
	@NotNull
	@Min(0)
	public Integer getNewMessages() {
		return newMessages;
	}
	
	@Valid
	@NotNull
	@ManyToOne(optional = false)
	public Route getRoute() {
		return route;
	}

	@Valid
	@NotNull
	@ManyToOne(optional = false)
	public Actor getParticipantA() {
		return participantA;
	}
	
	@Valid
	@NotNull
	@ManyToOne(optional = false)
	public Actor getParticipantB() {
		return participantB;
	}
	
	@Valid
	@ManyToOne(optional = true)
	public Actor getReportedUser() {
		return reportedUser;
	}

	@Valid
	@OneToMany(mappedBy = "thread")	
	public Collection<Message> getMessages() {
		return messages;
	}
	
	//Setter
	
	public void setClosed(Boolean closed) {
		this.closed = closed;
	}
	
	public void setLastMessage(Message lastMessage) {
		this.lastMessage = lastMessage;
	}
	
	public void setNewMessages(Integer newMessages) {
		this.newMessages = newMessages;
	}

	public void setRoute(Route route) {
		this.route = route;
	}

	public void setParticipantA(Actor participantA) {
		this.participantA = participantA;
	}

	public void setParticipantB(Actor participantB) {
		this.participantB = participantB;
	}

	public void setReportedUser(Actor reportedUser) {
		this.reportedUser = reportedUser;
	}
	
	public void setMessages(Collection<Message> messages) {
		this.messages = messages;
	}

}
