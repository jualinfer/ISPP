
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
import domain.Driver;

@ContextConfiguration(locations = {
	"classpath:spring/junit.xml"
})
@RunWith(SpringJUnit4ClassRunner.class)
@Transactional
public class DriverServiceTest extends AbstractTest {

	//Servicios bajo testeo

	@Autowired
	private UserAccountService	userAccountService;

	@Autowired
	private DriverService		driverService;


	//Test 1: vamos a registrarnos como driver correctamente

	@Test
	public void driverCreatePositiveTest() {
		Driver driver;
		UserAccount ua;
		final Authority authority;
		Collection<Authority> authorities;

		driver = this.driverService.create();
		ua = this.userAccountService.create();
		authority = new Authority();
		authority.setAuthority(Authority.DRIVER);
		authorities = new ArrayList<Authority>();
		authorities.add(authority);

		driver.setName("Name");
		driver.setSurname("Surname");
		driver.setCountry("Country");
		driver.setCity("City");
		driver.setBankAccountNumber("ES4963116815932885489285");
		driver.setPhone("698456847");
		driver.setChilds(true);
		driver.setMusic(true);
		driver.setSmoke(false);
		driver.setPets(true);

		ua.setUsername("newdriver@gmail.com");
		ua.setPassword("newdriver");
		ua.setAuthorities(authorities);

		driver.setUserAccount(ua);

		this.driverService.save(driver);
		this.driverService.flush();
	}

	//Test 2: vamos a registrarnos con algunos datos no válidos

	@Test(expected = ConstraintViolationException.class)
	public void driverCreateNegativeTest() {
		Driver driver;
		UserAccount ua;
		final Authority authority;
		Collection<Authority> authorities;

		driver = this.driverService.create();
		ua = this.userAccountService.create();
		authority = new Authority();
		authority.setAuthority(Authority.DRIVER);
		authorities = new ArrayList<Authority>();
		authorities.add(authority);

		driver.setName("Name");
		driver.setSurname("Surname");
		driver.setCountry("Country");
		driver.setCity("City");
		driver.setBankAccountNumber("ES4963116815932885489284"); //Número equivocado
		driver.setPhone("398456847"); //Número equivocado
		driver.setImage("http://google.com");
		driver.setChilds(true);
		driver.setMusic(true);
		driver.setSmoke(false);
		driver.setPets(true);

		ua.setUsername("newdriver"); //Debe ser un email válido
		ua.setPassword("new"); //3 caracteres cuando el mínimo es 5
		ua.setAuthorities(authorities);

		driver.setUserAccount(ua);

		this.driverService.save(driver);
		this.driverService.flush();
	}

	//Test 3: ahora vamos a editar correctamente un driver

	@Test
	public void passengerEditPositiveTest() {
		super.authenticate("driver20@gmail.com");
		final Integer id = this.getEntityId("driver20");
		final Driver driver = this.driverService.findOne(id);

		driver.setName("Pepe");
		driver.setSurname("Doe");
		driver.setCity("Patata");
		driver.setCountry("Patata");
		driver.setBankAccountNumber("ES9121000418450200051332");
		driver.setPhone("985698547");
		driver.setImage("https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png");
		driver.setChilds(true);
		driver.setMusic(true);
		driver.setSmoke(false);
		driver.setPets(true);

		final UserAccount account = driver.getUserAccount();
		account.setPassword("123456");
		account.setUsername("pepe27@gmail.com");

		driver.setUserAccount(account);

		this.driverService.save(driver);
		super.unauthenticate();
		this.driverService.flush();
	}

	//Test 4: ahora vamos a editar un driver con datos no válidos
	@Test(expected = ConstraintViolationException.class)
	public void passengerEditNegativeTest() {
		super.authenticate("driver20@gmail.com");
		final Integer id = this.getEntityId("driver20");
		final Driver driver = this.driverService.findOne(id);

		driver.setName(""); //Dato en blanco
		driver.setSurname("");//Dato en blanco
		driver.setCity("");//Dato en blanco
		driver.setCountry("");//Dato en blanco
		driver.setBankAccountNumber("ES9121000418450200051333"); //Número inválido
		driver.setPhone("585698547"); //Número inválido
		driver.setImage("https://google.com"); //Imagen inválida
		driver.setChilds(true);
		driver.setMusic(true);
		driver.setSmoke(false);
		driver.setPets(true);

		final UserAccount account = driver.getUserAccount();
		account.setPassword("12"); // Contraseña inválida
		account.setUsername("pepe27"); //Usuario inválido

		driver.setUserAccount(account);

		this.driverService.save(driver);
		super.unauthenticate();
		this.driverService.flush();
	}

}
