
package services;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;

import repositories.PassengerRepository;
import security.Authority;
import security.UserAccount;
import security.UserAccountService;
import domain.Comment;
import domain.CreditCard;
import domain.Passenger;
import domain.Reservation;
import forms.CredentialsfForm;

@Service
@Transactional
public class PassengerService {

	//managed repository
	@Autowired
	private PassengerRepository	passengerRepository;

	//Supporting Services
	@Autowired
	private ActorService		actorService;
	@Autowired
	private UserAccountService	userAccountService;

	@Autowired
	private Validator			validator;


	//CRUD

	public Passenger create() {
		Passenger result;
		UserAccount ua;
		Authority authority;
		Collection<Authority> authorities;
		Collection<Comment> comments;
		final Collection<Reservation> reservations;

		ua = this.userAccountService.create();
		ua.setUsername("");
		ua.setPassword("");
		ua.setEnabled(true);
		authority = new Authority();
		authority.setAuthority(Authority.PASSENGER);
		authorities = new ArrayList<Authority>();
		authorities.add(authority);
		ua.setAuthorities(authorities);

		comments = new ArrayList<Comment>();
		reservations = new ArrayList<Reservation>();

		String name, surname, country, city, phone, bankAccountNumber;
		Integer numberOfTrips;
		Double averageStars, cash;

		name = "";
		surname = "";
		country = "";
		city = "";
		phone = "";
		numberOfTrips = 0;
		averageStars = 0.0;
		cash = 0.0;
		bankAccountNumber = "";

		result = new Passenger();

		result.setName(name);
		result.setSurname(surname);
		result.setCountry(country);
		result.setCity(city);
		result.setPhone(phone);
		result.setMediumStars(averageStars);
		result.setNumberOfTrips(numberOfTrips);
		result.setCash(cash);
		result.setBankAccountNumber(bankAccountNumber);
		result.setCreditCard(new CreditCard());

		result.setUserAccount(ua);
		result.setComments(comments);
		result.setReservations(reservations);

		return result;
	}

	public Passenger findOne(final int adminId) {
		Passenger result;

		result = this.passengerRepository.findOne(adminId);

		return result;
	}

	public Collection<Passenger> findAll() {
		Collection<Passenger> result;

		result = this.passengerRepository.findAll();

		return result;
	}

	public Passenger save(final Passenger passenger) {
		Assert.notNull(passenger);

		Passenger result;

		final Calendar calendar = Calendar.getInstance();
		calendar.set(passenger.getCreditCard().getExpYear(), passenger.getCreditCard().getExpMonth(), 1);
		final Date expiration = new Date(calendar.getTimeInMillis());
		final Date now = new Date();

		Assert.isTrue(expiration.after(now), "The date of a credit card are expired");

		result = (Passenger) this.actorService.save(passenger);

		return result;
	}

	public Collection<Passenger> findPassengersAcceptedByRoute(int routeId) {
		Collection<Passenger> result;

		result = this.passengerRepository.findPassengersAcceptedByRoute(routeId);

		return result;
	}

	// Complex business rules
	public Passenger reconstruct(final Passenger passenger, final BindingResult binding) {
		Passenger result;

		if (passenger.getId() != 0) {

			result = this.passengerRepository.findOne(passenger.getId());

			passenger.setReservations(result.getReservations());
			passenger.setBankAccountNumber(result.getBankAccountNumber());
			passenger.getCreditCard().setCvv(result.getCreditCard().getCvv());
			passenger.getCreditCard().setExpMonth(result.getCreditCard().getExpMonth());
			passenger.getCreditCard().setExpYear(result.getCreditCard().getExpYear());
			passenger.getCreditCard().setNumber(result.getCreditCard().getNumber());
			passenger.setCash(result.getCash());
			passenger.getUserAccount().setAuthorities(result.getUserAccount().getAuthorities());
			passenger.getUserAccount().setId(result.getUserAccount().getId());
			passenger.getUserAccount().setVersion(result.getUserAccount().getVersion());
			passenger.getUserAccount().setEnabled(result.getUserAccount().isEnabled());
			passenger.getUserAccount().setUsername(result.getUserAccount().getUsername());
			passenger.getUserAccount().setPassword(result.getUserAccount().getPassword());
			passenger.setComments(result.getComments());
			passenger.setNumberOfTrips(result.getNumberOfTrips());
			passenger.setMediumStars(result.getMediumStars());
		}

		this.validator.validate(passenger, binding);
		return passenger;
	}
	
	public CredentialsfForm constructCredential(Passenger passenger) {
		CredentialsfForm credentialsfForm = new CredentialsfForm();
		credentialsfForm.setId(passenger.getId());
		return credentialsfForm;
	}
	
	public Passenger reconstructCredential(CredentialsfForm credentialsfForm, BindingResult binding) {
		Passenger passenger = findOne(credentialsfForm.getId());
		
		String pass = credentialsfForm.getPassword();
		passenger.getUserAccount().setPassword(pass);
		
		this.validator.validate(passenger, binding);
		
		return passenger;
	}
	
	public Passenger saveCredentials(Passenger passenger) {
		Passenger res;
		
		String pass = passenger.getUserAccount().getPassword();
		
		final Md5PasswordEncoder code = new Md5PasswordEncoder();
		
		pass = code.encodePassword(pass, null);
		
		passenger.getUserAccount().setPassword(pass);

		res = this.passengerRepository.save(passenger);
		
		return res;
	}
	
}
