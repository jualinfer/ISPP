
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

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Access(AccessType.PROPERTY)
public class Alert extends DomainEntity {

	//Attributes

	private Date		date;
	private Actor		sender;
	private Actor		receiver;
	private TypeAlert	typeAlert;
	private Boolean		isRead;
	private String		alertBody;
	//Relationships

	private Route		relatedRoute;


	//Getters

	@Valid
	@ManyToOne(optional = true)
	public Route getRelatedRoute() {
		return this.relatedRoute;
	}

	@NotNull
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm")
	public Date getDate() {
		return this.date;
	}

	@NotNull
	@Valid
	@ManyToOne(optional = false)
	public Actor getSender() {
		return this.sender;
	}

	@NotNull
	@Valid
	@ManyToOne(optional = false)
	public Actor getReceiver() {
		return this.receiver;
	}

	@NotNull
	public Boolean getIsRead() {
		return this.isRead;
	}

	public TypeAlert getTypeAlert() {
		return this.typeAlert;
	}

	public String getAlertBody() {
		return this.alertBody;
	}

	//Setters

	public void setRelatedRoute(final Route relatedRoute) {
		this.relatedRoute = relatedRoute;
	}

	public void setDate(final Date date) {
		this.date = date;
	}

	public void setSender(final Actor sender) {
		this.sender = sender;
	}

	public void setReceiver(final Actor receiver) {
		this.receiver = receiver;
	}

	public void setTypeAlert(final TypeAlert typeAlert) {
		this.typeAlert = typeAlert;
	}

	public void setIsRead(final Boolean isRead) {
		this.isRead = isRead;
	}

	public void setAlertBody(final String alertBody) {
		this.alertBody = alertBody;
	}
}
