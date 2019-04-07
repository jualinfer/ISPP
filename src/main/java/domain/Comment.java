
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
import org.hibernate.validator.constraints.Range;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Access(AccessType.PROPERTY)
public class Comment extends DomainEntity {

	//Attributes

	private Date		date;
	private Double		star;
	private String		text;
	private Boolean		fromDriver;

	//Relationships

	private Passenger	passenger;
	private Driver		driver;
	private Route		route;


	//Getters

	@NotNull
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm")
	public Date getDate() {
		return this.date;
	}

	@NotBlank
	public String getText() {
		return this.text;
	}

	@NotNull
	@Range(min = 0, max = 5)
	public Double getStar() {
		return this.star;
	}

	@NotNull
	public Boolean getFromDriver() {
		return this.fromDriver;
	}

	@Valid
	@NotNull
	@ManyToOne(optional = false)
	public Driver getDriver() {
		return this.driver;
	}

	@Valid
	@NotNull
	@ManyToOne(optional = false)
	public Passenger getPassenger() {
		return this.passenger;
	}

	@Valid
	@NotNull
	@ManyToOne(optional = false)
	public Route getRoute() {
		return this.route;
	}

	//Setters

	public void setDate(final Date date) {
		this.date = date;
	}

	public void setStar(final Double star) {
		this.star = star;
	}

	public void setText(final String text) {
		this.text = text;
	}

	public void setFromDriver(Boolean fromDriver) {
		this.fromDriver = fromDriver;
	}

	public void setDriver(final Driver driver) {
		this.driver = driver;
	}

	public void setPassenger(final Passenger passenger) {
		this.passenger = passenger;
	}

	public void setRoute(Route route) {
		this.route = route;
	}
}
