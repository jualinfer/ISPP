
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

import repositories.DriverRepository;
import security.Authority;
import security.UserAccount;
import security.UserAccountService;
import domain.Comment;
import domain.CreditCard;
import domain.Driver;
import domain.Route;
import domain.Vehicle;
import forms.CredentialsfForm;

@Service
@Transactional
public class DriverService {

	// Managed Repository
	@Autowired
	private DriverRepository	driverRepository;

	// Supporting services

	@Autowired
	private ActorService		actorService;
	@Autowired
	private UserAccountService	userAccountService;
	@Autowired
	private Validator			validator;


	// Constructors

	public DriverService() {
		super();
	}

	// Simple CRUD Methods

	public Driver create() {
		Driver result;
		String name, surname, country, city, phone, bankAccountNumber;
		Integer numberOfTrips;
		Double averageStars, cash;
		Boolean pets, smoke, music, children;

		Collection<Vehicle> vehicles;
		Collection<Route> routes;
		Collection<Comment> comments;
		UserAccount userAccount;
		Authority authority;
		Collection<Authority> authorities;

		userAccount = this.userAccountService.create();
		userAccount.setEnabled(true);
		userAccount.setUsername("");
		userAccount.setPassword("");
		authority = new Authority();
		authority.setAuthority(Authority.DRIVER);
		authorities = new ArrayList<Authority>();
		authorities.add(authority);
		userAccount.setAuthorities(authorities);

		vehicles = new ArrayList<Vehicle>();
		routes = new ArrayList<Route>();
		comments = new ArrayList<Comment>();

		name = "";
		surname = "";
		country = "";
		city = "";
		phone = "";
		numberOfTrips = 0;
		averageStars = 0.0;
		cash = 0.0;
		pets = false;
		smoke = false;
		music = false;
		children = false;
		bankAccountNumber = "";

		result = new Driver();
		result.setUserAccount(userAccount);
		result.setName(name);
		result.setSurname(surname);
		result.setCountry(country);
		result.setCity(city);
		result.setPhone(phone);
		result.setMediumStars(averageStars);
		result.setNumberOfTrips(numberOfTrips);
		result.setCash(cash);
		result.setPets(pets);
		result.setSmoke(smoke);
		result.setMusic(music);
		result.setChilds(children);
		result.setBankAccountNumber(bankAccountNumber);
		result.setCreditCard(new CreditCard());

		result.setVehicles(vehicles);
		result.setRoutes(routes);
		result.setComments(comments);

		return result;
	}
	public Collection<Driver> findAll() {
		Collection<Driver> result;

		result = this.driverRepository.findAll();

		return result;
	}

	public Driver findOne(final int driverId) {
		Assert.isTrue(driverId != 0);

		Driver result;

		result = this.driverRepository.findOne(driverId);

		return result;
	}

	public Driver save(final Driver driver) {
		Assert.notNull(driver);

		final Calendar calendar = Calendar.getInstance();
		calendar.set(driver.getCreditCard().getExpYear(), driver.getCreditCard().getExpMonth(), 1);
		final Date expiration = new Date(calendar.getTimeInMillis());
		final Date now = new Date();

		Assert.isTrue(expiration.after(now));

		Driver result;
		result = (Driver) this.actorService.save(driver);

		return result;
	}
	
	public Driver saveUpdateNotifications(Driver driver) {
		return (Driver) actorService.save(driver);
	}

	public void delete(final Driver driver) {
		Assert.isTrue(driver.getId() != 0);
		Assert.notNull(driver);
		this.driverRepository.delete(driver);
	}

	// Complex business rules
	public Driver reconstruct(final Driver driver, final BindingResult binding) {
		Driver result;

		if (driver.getId() != 0) {

			result = this.driverRepository.findOne(driver.getId());

			driver.setRoutes(result.getRoutes());
			driver.setVehicles(result.getVehicles());
			driver.setBankAccountNumber(result.getBankAccountNumber());
			driver.getCreditCard().setCvv(result.getCreditCard().getCvv());
			driver.getCreditCard().setExpMonth(result.getCreditCard().getExpMonth());
			driver.getCreditCard().setExpYear(result.getCreditCard().getExpYear());
			driver.getCreditCard().setNumber(result.getCreditCard().getNumber());
			driver.setCash(result.getCash());
			driver.getUserAccount().setAuthorities(result.getUserAccount().getAuthorities());
			driver.getUserAccount().setId(result.getUserAccount().getId());
			driver.getUserAccount().setVersion(result.getUserAccount().getVersion());
			driver.getUserAccount().setEnabled(result.getUserAccount().isEnabled());
			driver.getUserAccount().setUsername(result.getUserAccount().getUsername());
			driver.getUserAccount().setPassword(result.getUserAccount().getPassword());
			driver.setComments(result.getComments());
			driver.setNumberOfTrips(result.getNumberOfTrips());
			driver.setMediumStars(result.getMediumStars());
			driver.setNewMessages(result.getNewMessages());
			driver.setNewAlerts(result.getNewAlerts());
		}

		this.validator.validate(driver, binding);
		return driver;
	}
	
	public CredentialsfForm constructCredential(Driver driver) {
		CredentialsfForm credentialsfForm = new CredentialsfForm();
		credentialsfForm.setId(driver.getId());
		return credentialsfForm;
	}
	
	public Driver reconstructCredential(CredentialsfForm credentialsfForm, BindingResult binding) {
		Driver driver = findOne(credentialsfForm.getId());
		
		String pass = credentialsfForm.getPassword();
		driver.getUserAccount().setPassword(pass);
		
		this.validator.validate(driver, binding);
		
		return driver;
	}
	
	public Driver saveCredentials(Driver driver) {
		Driver res;
		
		String pass = driver.getUserAccount().getPassword();
		
		final Md5PasswordEncoder code = new Md5PasswordEncoder();
		
		pass = code.encodePassword(pass, null);
		
		driver.getUserAccount().setPassword(pass);

		res = this.driverRepository.save(driver);
		
		return res;
	}

}
