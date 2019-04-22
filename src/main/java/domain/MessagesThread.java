package domain;

import java.util.Collection;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;

@Entity
@Access(AccessType.PROPERTY)
public class MessagesThread extends DomainEntity {
	
	//Attributes
	
	private Boolean closed;
	
	//Relationships
	
	private Route route;
	private Actor participantA;
	private Actor participantB;
	private Actor reportedUser;
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
