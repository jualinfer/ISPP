
package domain;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.validation.Valid;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

@Entity
@Access(AccessType.PROPERTY)
public class Reservation extends DomainEntity {

	//Attributes

	private LuggageSize			luggageSize;
	private Double				price;
	private String				origin;
	private String				destination;
	private Integer				seat;
	private ReservationStatus	status;
	private boolean				driverPickedMe;
	private boolean				driverNoPickedMe;
	private Boolean				paymentResolved;
	private String				chargeId;

	//Relationships

	private Passenger			passenger;
	private Route				route;


	//Getters

	@NotNull
	@Min(value = 0)
	public Double getPrice() {
		return this.price;
	}

	@NotBlank
	public String getOrigin() {
		return this.origin;
	}

	@NotBlank
	public String getDestination() {
		return this.destination;
	}

	@NotNull
	@Valid
	public LuggageSize getLuggageSize() {
		return this.luggageSize;
	}

	@NotNull
	@Min(value = 1)
	public Integer getSeat() {
		return this.seat;
	}

	@Valid
	@NotNull
	@ManyToOne(optional = false)
	public Route getRoute() {
		return this.route;
	}

	@Valid
	@NotNull
	@ManyToOne(optional = false)
	public Passenger getPassenger() {
		return this.passenger;
	}
	@NotNull
	@Valid
	public ReservationStatus getStatus() {
		return this.status;
	}

	@NotNull
	public boolean isDriverPickedMe() {
		return this.driverPickedMe;
	}
	@NotNull
	public boolean isDriverNoPickedMe() {
		return this.driverNoPickedMe;
	}
	
	@NotNull
	public Boolean isPaymentResolved() {
		return paymentResolved;
	}

	public String getChargeId() {
		return this.chargeId;
	}

	//Setters

	public void setLuggageSize(final LuggageSize luggageSize) {
		this.luggageSize = luggageSize;
	}

	public void setPrice(final Double price) {
		this.price = price;
	}

	public void setOrigin(final String origin) {
		this.origin = origin;
	}

	public void setDestination(final String destination) {
		this.destination = destination;
	}

	public void setSeat(final Integer seat) {
		this.seat = seat;
	}

	public void setRoute(final Route route) {
		this.route = route;
	}

	public void setPassenger(final Passenger passenger) {
		this.passenger = passenger;
	}

	public void setStatus(final ReservationStatus status) {
		this.status = status;
	}

	public void setDriverPickedMe(final boolean driverPickedMe) {
		this.driverPickedMe = driverPickedMe;
	}

	public void setDriverNoPickedMe(final boolean driverNoPickedMe) {
		this.driverNoPickedMe = driverNoPickedMe;
	}
	
	public void setPaymentResolved(final Boolean paymentResolved) {
		this.paymentResolved = paymentResolved;
	}

	public void setChargeId(final String chargeId) {
		this.chargeId = chargeId;
	}

}
