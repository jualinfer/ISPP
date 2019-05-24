
package services;

import javax.transaction.Transactional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import utilities.AbstractTest;
import domain.Alert;

@ContextConfiguration(locations = {
	"classpath:spring/junit.xml"
})
@RunWith(SpringJUnit4ClassRunner.class)
@Transactional
public class AlertServiceTest extends AbstractTest {

	// Servicios bajo Testeo
	@Autowired
	private AlertService		alertService;

	@Autowired
	private RouteService		routeService;

	@Autowired
	private ReservationService	reservationService;

	@Autowired
	private ActorService		actorService;

	@Autowired
	private ReservationService	ReservationService;


	@Test
	public void CreateAlertAdmin() {
		// Test del método CreateAdmin

		final Object testingData[][] = {
			{
				null, "admin@gmail.com"//We create an alert as an admin
			}, {
				IllegalArgumentException.class, "passenger@gmail.com"//We try to creaate an alert as someone who is not administrator
			},

		};

		for (int i = 0; i < testingData.length; i++)
			this.CreateAlertAdminAndDeleteTemplate((Class<?>) testingData[i][0], (String) testingData[i][1]);
	}

	public void CreateAlertAdminAndDeleteTemplate(final Class<?> expected, final String userAccount) {
		Class<?> caught;
		Alert alert;

		caught = null;

		try {
			this.authenticate(userAccount);
			alert = this.alertService.createAdmin();

			alert.setAlertBody("test Body");
			this.alertService.save(alert);
			this.alertService.delete(alert);
		} catch (final Throwable oops) {
			caught = oops.getClass();
		}

		this.authenticate(null);

		this.checkExceptions(expected, caught);
	}

}
