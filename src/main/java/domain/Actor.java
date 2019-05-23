
package domain;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.OneToOne;
import javax.validation.Valid;
import javax.validation.constraints.Min;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Range;

import security.UserAccount;

@Entity
@Access(AccessType.PROPERTY)
//@Table(uniqueConstraints = {@UniqueConstraint(columnNames = "userAccount")})
public class Actor extends DomainEntity {    //Attributes

	private String		name;
	private String		surname;
	private String		country;
	private String		city;
	private String		phone;
	private Double		mediumStars;
	private Integer		numberOfTrips;
	private Integer		newMessages;
	private Integer		newAlerts;
	private UserAccount	userAccount;


	@NotBlank
	public String getName() {

		return this.name;

	}
	@NotBlank
	public String getSurname() {

		return this.surname;

	}
	@NotBlank
	public String getCountry() {

		return this.country;

	}

	@Valid
	@OneToOne(cascade = CascadeType.ALL)
	public UserAccount getUserAccount() {

		return this.userAccount;

	}

	@NotBlank
	public String getCity() {
		return this.city;
	}

	@NotBlank
	@Pattern(regexp = "[6|7|9]{1}[0-9]{8}", message = "Invalid Phone Number")
	public String getPhone() {
		return this.phone;
	}

	@Range(min = (long) 0.0, max = (long) 5.0)
	public Double getMediumStars() {
		if (this.mediumStars == null)
			this.mediumStars = 0.0;
		return this.mediumStars;
	}

	@Min(0)
	public Integer getNumberOfTrips() {
		return this.numberOfTrips;
	}

	@Min(0)
	public Integer getNewMessages() {
		return this.newMessages;
	}

	@Min(0)
	public Integer getNewAlerts() {
		return this.newAlerts;
	}

	//Setters    public void setName(final String name) {
	public void setName(final String name) {

		this.name = name;

	}
	public void setSurname(final String surname) {

		this.surname = surname;

	}
	public void setCountry(final String country) {

		this.country = country;

	}

	public void setUserAccount(final UserAccount userAccount) {

		this.userAccount = userAccount;

	}

	public void setCity(final String city) {
		this.city = city;
	}

	public void setPhone(final String phone) {
		this.phone = phone;
	}

	public void setMediumStars(final Double mediumStars) {
		this.mediumStars = mediumStars;
	}

	public void setNumberOfTrips(final Integer numberOfTrips) {
		this.numberOfTrips = numberOfTrips;
	}

	public void setNewMessages(final Integer newMessages) {
		this.newMessages = newMessages;
	}

	public void setNewAlerts(final Integer newAlerts) {
		this.newAlerts = newAlerts;
	}

}
