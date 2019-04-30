
package domain;

import java.util.Collection;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.validation.Valid;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.URL;

@Entity
@Access(AccessType.PROPERTY)
public class Driver extends Actor {

	//Attributes
	private Double				cash;
	private String				bankAccountNumber;
	private Boolean				pets;
	private Boolean				smoke;
	private Boolean				music;
	private Boolean				childs;
	private String				image;

	//Relationships
	private Collection<Route>	routes;
	private Collection<Comment>	comments;
	private Collection<Vehicle>	vehicles;


	//Getter

	@Min(value = 0)
	public Double getCash() {
		return this.cash;
	}

	@Pattern(regexp = "^ES\\d{22}$", message = "Invalid Spain Bank Number")
	@NotBlank
	public String getBankAccountNumber() {
		return this.bankAccountNumber;
	}

	@URL
	public String getImage() {
		return this.image;
	}

	@NotNull
	public Boolean getPets() {
		return this.pets;
	}

	@NotNull
	public Boolean getSmoke() {
		return this.smoke;
	}

	@NotNull
	public Boolean getMusic() {
		return this.music;
	}

	@NotNull
	public Boolean getChilds() {
		return this.childs;
	}

	@Valid
	@OneToMany(mappedBy = "driver")
	public Collection<Route> getRoutes() {
		return this.routes;
	}

	@Valid
	@OneToMany(mappedBy = "driver")
	public Collection<Comment> getComments() {
		return this.comments;
	}

	@Valid
	@OneToMany(mappedBy = "driver")
	public Collection<Vehicle> getVehicles() {
		return this.vehicles;
	}

	//Setter

	public void setCash(final Double cash) {
		this.cash = cash;
	}

	public void setPets(final Boolean pets) {
		this.pets = pets;
	}

	public void setSmoke(final Boolean smoke) {
		this.smoke = smoke;
	}

	public void setMusic(final Boolean music) {
		this.music = music;
	}

	public void setBankAccountNumber(final String bankAccountNumber) {
		this.bankAccountNumber = bankAccountNumber;
	}

	public void setChilds(final Boolean childs) {
		this.childs = childs;
	}

	public void setRoutes(final Collection<Route> routes) {
		this.routes = routes;
	}

	public void setComments(final Collection<Comment> comments) {
		this.comments = comments;
	}

	public void setVehicles(final Collection<Vehicle> vehicles) {
		this.vehicles = vehicles;
	}

	public void setImage(final String image) {
		this.image = image;
	}

}
