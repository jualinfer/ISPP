
package domain;

import java.util.Date;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;

public class Finder {

	//Atributos

	private String		origin;
	private Date		departureDate;
	private String		destination;
	private Date		arrivalDate;
	private Integer		vehicleType;
	private Integer		availableSeats;
	private LuggageSize	luggageSize;
	private Boolean		pets;
	private Boolean		childs;
	private Boolean		smoke;
	private Boolean		music;

	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm")
	public Date getArrivalDate() {
		return this.arrivalDate;
	}

	public void setArrivalDate(Date arrivalDate) {
		this.arrivalDate = arrivalDate;
	}
	
	public Boolean getPets() {
		return this.pets;
	}

	public void setPets(Boolean pets) {
		if (pets == null) {
			pets = false;
		}
		this.pets = pets;
	}

	public Boolean getChilds() {
		return this.childs;
	}

	public void setChilds(Boolean childs) {
		if (childs == null) {
			childs = false;
		}
		this.childs = childs;
	}

	public Boolean getSmoke() {
		return this.smoke;
	}

	public void setSmoke(Boolean smoke) {
		if (smoke == null) {
			smoke = false;
		}
		this.smoke = smoke;
	}

	public Boolean getMusic() {
		return this.music;
	}

	public void setMusic(Boolean music) {
		if (music == null) {
			music = false;
		}
		this.music = music;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "dd/MM/yyyy HH:mm")
	public Date getDepartureDate() {
		return this.departureDate;
	}

	public void setDepartureDate(Date departureDate) {
		this.departureDate = departureDate;
	}
	
	public String getOrigin() {
		return this.origin;
	}

	public void setOrigin(String origin) {
		if (origin == null) {
			origin = "";
		}
		this.origin = origin.toLowerCase();
	}

	@NotNull
	@NotBlank
	public String getDestination() {
		return this.destination;
	}

	public void setDestination(String destination) {
		if (destination == null) {
			destination = "";
		}
		this.destination = destination.toLowerCase();
	}

	public Integer getVehicleType() {
		return this.vehicleType;
	}

	public void setVehicleType(Integer vehicleType) {
		this.vehicleType = vehicleType;
	}
	
	@NotNull
	@Min(1)
	public Integer getAvailableSeats() {
		return this.availableSeats;
	}

	public void setAvailableSeats(Integer availableSeats) {
		if (availableSeats == null) {
			availableSeats = 1;
		}
		this.availableSeats = availableSeats;
	}

	public LuggageSize getLuggageSize() {
		return this.luggageSize;
	}

	public void setLuggageSize(LuggageSize luggageSize) {
		this.luggageSize = luggageSize;
	}

	public VehicleType getVehicleTypeById(int id) {
		VehicleType res = null;

		switch (id) {
		case 1:
			res = VehicleType.CAR;
			break;

		case 2:
			res = VehicleType.BIKE;
			break;
		}

		return res;
	}

}
