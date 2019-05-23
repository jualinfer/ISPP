
package services;

import java.util.ArrayList;
import java.util.Collection;

import javax.transaction.Transactional;
import javax.validation.ConstraintViolationException;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import security.Authority;
import security.UserAccount;
import security.UserAccountService;
import utilities.AbstractTest;
import domain.Passenger;

@ContextConfiguration(locations = {
	"classpath:spring/junit.xml"
})
@RunWith(SpringJUnit4ClassRunner.class)
@Transactional
public class PassengerServiceTest extends AbstractTest {

	//Servicios bajo testeo

	@Autowired
	private UserAccountService	userAccountService;

	@Autowired
	private PassengerService	passengerService;


	//Test 1: vamos a registrarnos como passenger correctamente

	@Test
	public void passengerCreatePositiveTest() {
		Passenger passenger;
		UserAccount ua;
		final Authority authority;
		Collection<Authority> authorities;

		passenger = this.passengerService.create();
		ua = this.userAccountService.create();
		authority = new Authority();
		authority.setAuthority(Authority.PASSENGER);
		authorities = new ArrayList<Authority>();
		authorities.add(authority);

		passenger.setName("Name");
		passenger.setSurname("Surname");
		passenger.setCountry("Country");
		passenger.setCity("City");
		passenger.setBankAccountNumber("ES4963116815932885489285");
		passenger.setPhone("698456847");

		ua.setUsername("newpassenger@gmail.com");
		ua.setPassword("newpassenger");
		ua.setAuthorities(authorities);

		passenger.setUserAccount(ua);

		this.passengerService.save(passenger);
		this.passengerService.flush();
	}

	//Test 2: vamos a registrarnos con algunos datos no válidos

	@Test(expected = ConstraintViolationException.class)
	public void passengerCreateNegativeTest() {
		Passenger passenger;
		UserAccount ua;
		final Authority authority;
		Collection<Authority> authorities;

		passenger = this.passengerService.create();
		ua = this.userAccountService.create();
		authority = new Authority();
		authority.setAuthority(Authority.PASSENGER);
		authorities = new ArrayList<Authority>();
		authorities.add(authority);

		passenger.setName("Name");
		passenger.setSurname("Surname");
		passenger.setCountry("Country");
		passenger.setCity("City");
		passenger.setBankAccountNumber("ES4963116815932885489284"); //Número equivocado
		passenger.setPhone("398456847"); //Número equivocado
		passenger.setImage("http://google.com");

		ua.setUsername("newpassenger"); //Debe ser un email válido
		ua.setPassword("new"); //3 caracteres cuando el mínimo es 5
		ua.setAuthorities(authorities);

		passenger.setUserAccount(ua);

		this.passengerService.save(passenger);
		this.passengerService.flush();
	}

	//Test 3: ahora vamos a editar correctamente un passenger

	@Test
	public void passengerEditPositiveTest() {
		super.authenticate("passenger40@gmail.com");
		final Integer id = this.getEntityId("passenger40");
		final Passenger passenger = this.passengerService.findOne(id);

		passenger.setName("Pepe");
		passenger.setSurname("Doe");
		passenger.setCity("Patata");
		passenger.setCountry("Patata");
		passenger.setBankAccountNumber("ES9121000418450200051332");
		passenger.setPhone("985698547");
		passenger.setImage("https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png");

		final UserAccount account = passenger.getUserAccount();
		account.setPassword("123456");
		account.setUsername("pepe27@gmail.com");

		passenger.setUserAccount(account);

		this.passengerService.save(passenger);
		super.unauthenticate();
		this.passengerService.flush();
	}

	//Test 4: ahora vamos a editar un passenger con datos no válidos
	@Test(expected = ConstraintViolationException.class)
	public void passengerEditNegativeTest() {
		super.authenticate("passenger40@gmail.com");
		final Integer id = this.getEntityId("passenger40");
		final Passenger passenger = this.passengerService.findOne(id);

		passenger.setName(""); //Dato en blanco
		passenger.setSurname("");//Dato en blanco
		passenger.setCity("");//Dato en blanco
		passenger.setCountry("");//Dato en blanco
		passenger.setBankAccountNumber("ES9121000418450200051333"); //Número inválido
		passenger.setPhone("585698547"); //Número inválido
		passenger.setImage("https://google.com"); //Imagen inválida

		final UserAccount account = passenger.getUserAccount();
		account.setPassword("12"); // Contraseña inválida
		account.setUsername("pepe27"); //Usuario inválido

		passenger.setUserAccount(account);

		this.passengerService.save(passenger);
		super.unauthenticate();
		this.passengerService.flush();
	}

}
