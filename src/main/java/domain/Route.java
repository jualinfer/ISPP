
package domain;

import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.Valid;
import javax.validation.constraints.Digits;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Access(AccessType.PROPERTY)
public class Route extends DomainEntity {

	//Attributes

	private Date					departureDate;
	private String					origin;
	private String					destination;
	private Integer					estimatedDuration;
	private String					daysRepeat;
	private Integer					availableSeats;
	private Double					distance;
	private Double					pricePerPassenger;
	private String					details;
	private LuggageSize				maxLuggage;
	private Boolean					isCancelled;

	//Relationships

	private Driver					driver;
	private Vehicle					vehicle;
	private List<ControlPoint>		controlPoints;
	private Collection<Reservation>	reservations;
	private Collection<Comment>		comments;


	//Getter

	//@NotBlank
	//@Pattern(regexp = "MONDAY|TUESDAY|WEDNESDAY|THURSDAY|FRIDAY|SATURDAY|SUNDAY|NOTHING")
	public String getDaysRepeat() {
		return this.daysRepeat;
	}

	@NotNull
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm")
	public Date getDepartureDate() {
		return this.departureDate;
	}

	@NotNull
	@NotBlank
	public String getOrigin() {
		return this.origin;
	}

	@NotNull
	@NotBlank
	public String getDestination() {
		return this.destination;
	}

	@NotNull
	@Min(value = 1)
	public Integer getEstimatedDuration() {
		return this.estimatedDuration;
	}

	@NotNull
	@Min(value = 0)
	@Digits(fraction = 2, integer = 8)
	public Double getDistance() {
		return this.distance;
	}

	@NotNull
	@Min(value = 1)
	public Integer getAvailableSeats() {
		return this.availableSeats;
	}

	@NotNull
	@Min(value = (long) 1.10)
	public Double getPricePerPassenger() {
		return this.pricePerPassenger;
	}

	public String getDetails() {
		return this.details;
	}

	@Valid
	@NotNull
	public LuggageSize getMaxLuggage() {
		return this.maxLuggage;
	}

	@NotNull
	public Boolean getIsCancelled() {
		return this.isCancelled;
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
	public Vehicle getVehicle() {
		return this.vehicle;
	}

	@Valid
	@OneToMany(mappedBy = "route")
	public List<ControlPoint> getControlPoints() {
		return this.controlPoints;
	}

	@Valid
	@OneToMany(mappedBy = "route")
	public Collection<Reservation> getReservations() {
		return this.reservations;
	}

	@Valid
	@OneToMany(mappedBy = "route")
	public Collection<Comment> getComments() {
		return this.comments;
	}

	//Setter

	public void setDepartureDate(final Date departureDate) {
		this.departureDate = departureDate;
	}

	public void setOrigin(final String origin) {
		this.origin = origin;
	}

	public void setDestination(final String destination) {
		this.destination = destination;
	}

	public void setEstimatedDuration(final Integer estimatedDuration) {
		this.estimatedDuration = estimatedDuration;
	}

	public void setDaysRepeat(final String daysRepeat) {
		this.daysRepeat = daysRepeat;
	}

	public void setDistance(final Double distance) {
		this.distance = distance;
	}

	public void setDriver(final Driver driver) {
		this.driver = driver;
	}

	public void setControlPoints(final List<ControlPoint> controlPoints) {
		this.controlPoints = controlPoints;
	}
	public void setReservations(final Collection<Reservation> reservations) {
		this.reservations = reservations;
	}

	public void setComments(final Collection<Comment> comments) {
		this.comments = comments;
	}

	public void setAvailableSeats(final Integer availableSeats) {
		this.availableSeats = availableSeats;
	}

	public void setPricePerPassenger(final Double pricePerPassenger) {
		this.pricePerPassenger = pricePerPassenger;
	}

	public void setDetails(final String details) {
		this.details = details;
	}

	public void setMaxLuggage(final LuggageSize maxLuggage) {
		this.maxLuggage = maxLuggage;
	}

	public void setIsCancelled(final Boolean isCancelled) {
		this.isCancelled = isCancelled;
	}

	public void setVehicle(final Vehicle vehicle) {
		this.vehicle = vehicle;
	}

}
