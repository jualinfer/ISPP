
package services;

import java.util.ArrayList;
import java.util.Collection;

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
		Integer newAlerts;
		Integer newMessages;

		Collection<Vehicle> vehicles;
		Collection<Route> routes;
		Collection<Comment> comments;
		UserAccount userAccount;
		Authority authority;
		Collection<Authority> authorities;

		userAccount = this.userAccountService.create();
		userAccount.setEnabled(true);
		userAccount.setBanned(false);
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
		newAlerts = 0;
		newMessages = 0;

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
		result.setNewAlerts(newAlerts);
		result.setNewMessages(newMessages);

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

		Driver result;
		result = (Driver) this.actorService.save(driver);

		return result;
	}

	public Driver saveUpdateNotifications(final Driver driver) {
		return (Driver) this.actorService.save(driver);
	}

	public void delete(final Driver driver) {
		Assert.isTrue(driver.getId() != 0);
		Assert.notNull(driver);
		this.driverRepository.delete(driver);
	}

	// Complex business rules

	public void flush() {
		this.driverRepository.flush();
	}
	public Driver reconstruct(final Driver driver, final BindingResult binding) {
		Driver result;

		if (driver.getId() != 0) {

			result = this.driverRepository.findOne(driver.getId());

			driver.setRoutes(result.getRoutes());
			driver.setVehicles(result.getVehicles());
			driver.setCash(result.getCash());
			driver.getUserAccount().setAuthorities(result.getUserAccount().getAuthorities());
			driver.getUserAccount().setId(result.getUserAccount().getId());
			driver.getUserAccount().setVersion(result.getUserAccount().getVersion());
			driver.getUserAccount().setEnabled(result.getUserAccount().isEnabled());
			driver.getUserAccount().setBanned(result.getUserAccount().getBanned());
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

	public CredentialsfForm constructCredential(final Driver driver) {
		final CredentialsfForm credentialsfForm = new CredentialsfForm();
		credentialsfForm.setId(driver.getId());
		return credentialsfForm;
	}

	public Driver reconstructCredential(final CredentialsfForm credentialsfForm, final BindingResult binding) {
		final Driver driver = this.findOne(credentialsfForm.getId());

		final String pass = credentialsfForm.getPassword();
		driver.getUserAccount().setPassword(pass);

		this.validator.validate(driver, binding);

		return driver;
	}

	public Driver saveCredentials(final Driver driver) {
		Driver res;

		String pass = driver.getUserAccount().getPassword();

		final Md5PasswordEncoder code = new Md5PasswordEncoder();

		pass = code.encodePassword(pass, null);

		driver.getUserAccount().setPassword(pass);

		res = this.driverRepository.save(driver);

		return res;
	}

}
