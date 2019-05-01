
package domain;

import java.util.Date;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.Valid;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Access(AccessType.PROPERTY)
public class ControlPoint extends DomainEntity implements Comparable<ControlPoint> {

	//Attributes

	private String	location;
	private Integer	arrivalOrder;
	private Date	arrivalTime;
	private Double	distance;

	//Relationships
	private Route	route;


	//Getters

	@NotBlank
	public String getLocation() {
		return this.location;
	}

	@Valid
	@NotNull
	@ManyToOne(optional = false)
	public Route getRoute() {
		return this.route;
	}

	@NotNull
	@Min(0)
	public Integer getArrivalOrder() {
		return this.arrivalOrder;
	}

	@NotNull
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm")
	public Date getArrivalTime() {
		return this.arrivalTime;
	}

	public Double getDistance() {
		return this.distance;
	}

	//Setters

	public void setLocation(final String text) {
		this.location = text;
	}

	public void setRoute(final Route route) {
		this.route = route;
	}

	public void setDistance(final Double distance) {
		this.distance = distance;
	}

	public void setArrivalTime(final Date arrivalTime) {
		this.arrivalTime = arrivalTime;
	}

	public void setArrivalOrder(final Integer arrivalOrder) {
		this.arrivalOrder = arrivalOrder;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + ((this.arrivalOrder == null) ? 0 : this.arrivalOrder.hashCode());
		result = prime * result + ((this.route == null) ? 0 : this.route.hashCode());
		return result;
	}

	@Override
	public boolean equals(final Object obj) {
		if (this == obj)
			return true;
		if (!super.equals(obj))
			return false;
		if (this.getClass() != obj.getClass())
			return false;
		final ControlPoint other = (ControlPoint) obj;
		if (this.arrivalOrder == null) {
			if (other.arrivalOrder != null)
				return false;
		} else if (!this.arrivalOrder.equals(other.arrivalOrder))
			return false;
		if (this.route == null) {
			if (other.route != null)
				return false;
		} else if (!this.route.equals(other.route))
			return false;
		return true;
	}

	@Override
	public int compareTo(final ControlPoint n) {
		return Integer.compare(this.arrivalOrder, n.arrivalOrder);
	}
}
