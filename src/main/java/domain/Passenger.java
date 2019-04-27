
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
public class Passenger extends Actor {

	//Attributes
	private Double					cash;
	private String					bankAccountNumber;
	private String					image;

	//Relationships
	private Collection<Reservation>	reservations;
	private Collection<Comment>		comments;


	//Getter

	@Min(value = 0)
	public Double getCash() {
		return this.cash;
	}

	@NotBlank
	@Pattern(regexp = "^ES\\d{22}$", message = "Invalid Spain Bank Number")
	public String getBankAccountNumber() {
		return this.bankAccountNumber;
	}

	@URL
	public String getImage() {
		return this.image;
	}

	@Valid
	@NotNull
	@OneToMany(mappedBy = "passenger")
	public Collection<Reservation> getReservations() {
		return this.reservations;
	}

	@Valid
	@NotNull
	@OneToMany(mappedBy = "passenger")
	public Collection<Comment> getComments() {
		return this.comments;
	}

	//Setter

	public void setCash(final Double cash) {
		this.cash = cash;
	}

	public void setReservations(final Collection<Reservation> reservations) {
		this.reservations = reservations;
	}

	public void setComments(final Collection<Comment> comments) {
		this.comments = comments;
	}

	public void setBankAccountNumber(final String bankAccountNumber) {
		this.bankAccountNumber = bankAccountNumber;
	}

	public void setImage(final String image) {
		this.image = image;
	}

}
