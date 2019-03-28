
package domain;

import java.util.Date;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.joda.time.LocalTime;
import org.springframework.format.annotation.DateTimeFormat;

public class Finder {

	//Atributos

	private Date		departureDate;
	private String		origin;
	private LocalTime	originTime;
	private String		destination;
	private LocalTime	destinationTime;
	private Integer		vehicleType;
	private Integer		availableSeats;
	private LuggageSize	luggageSize;
	private Boolean		pets;
	private Boolean		childs;
	private Boolean		smoke;
	private Boolean		music;


	@Temporal(TemporalType.TIME)
	@DateTimeFormat(pattern = "HH:mm")
	public LocalTime getOriginTime() {
		return this.originTime;
	}

	public void setOriginTime(LocalTime originTime) {
		this.originTime = originTime;
	}

	@Temporal(TemporalType.TIME)
	@DateTimeFormat(pattern = "HH:mm")
	public LocalTime getDestinationTime() {
		return this.destinationTime;
	}

	public void setDestinationTime(LocalTime destinationTime) {
		this.destinationTime = destinationTime;
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

	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "dd/MM/yyyy")
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
