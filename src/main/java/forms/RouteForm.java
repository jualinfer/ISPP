
package forms;

import java.util.Date;
import java.util.List;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.Valid;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

import domain.LuggageSize;
import domain.Vehicle;

public class RouteForm extends FormObject {

	public RouteForm() {
		super();
	}

	private Date								departureDate;
	private ControlPointFormCreate				origin;
	private ControlPointFormCreate				destination;
	private Integer								availableSeats;
	private LuggageSize							maxLuggage;
	private String								details;
	private Double								distance;
	private Double								pricePerPassenger;
	private Vehicle								vehicle;
	private List<ControlPointFormCreate>		controlpoints;


	// TODO PONER TAGS EN LOS getX de los atributos!!

	@NotNull
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm")
	public Date getDepartureDate() {
		return this.departureDate;
	}

	public void setDepartureDate(final Date departureDate) {
		this.departureDate = departureDate;
	}

	@NotNull
	@Valid
	public ControlPointFormCreate getOrigin() {
		return this.origin;
	}

	public void setOrigin(final ControlPointFormCreate origin) {
		this.origin = origin;
	}

	@NotNull
	@Valid
	public ControlPointFormCreate getDestination() {
		return this.destination;
	}

	public void setDestination(final ControlPointFormCreate destination) {
		this.destination = destination;
	}

	@NotNull
	@Min(1)
	public Integer getAvailableSeats() {
		return this.availableSeats;
	}

	public void setAvailableSeats(final Integer availableSeats) {
		this.availableSeats = availableSeats;
	}

	@NotNull
	public LuggageSize getMaxLuggage() {
		return this.maxLuggage;
	}

	public void setMaxLuggage(final LuggageSize maxLuggage) {
		this.maxLuggage = maxLuggage;
	}

	public String getDetails() {
		return this.details;
	}

	public void setDetails(final String details) {
		this.details = details;
	}

	public Double getDistance() {
		return this.distance;
	}

	public void setDistance(final Double distance) {
		this.distance = distance;
	}

	public Double getPricePerPassenger() {
		return this.pricePerPassenger;
	}

	public void setPricePerPassenger(final Double pricePerPassenger) {
		this.pricePerPassenger = pricePerPassenger;
	}

	@NotNull
	@Valid
	public Vehicle getVehicle() {
		return this.vehicle;
	}

	public void setVehicle(final Vehicle vehicle) {
		this.vehicle = vehicle;
	}

	@Valid
	public List<ControlPointFormCreate> getControlpoints() {
		return this.controlpoints;
	}

	public void setControlpoints(List<ControlPointFormCreate> controlpoints) {
		this.controlpoints = controlpoints;
	}

}
