
package services;

import java.util.Calendar;
import java.util.Date;

import javax.transaction.Transactional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.util.Assert;

import utilities.AbstractTest;
import domain.Actor;
import domain.Passenger;
import domain.Reservation;
import domain.ReservationStatus;
import domain.Route;

@ContextConfiguration(locations = {
	"classpath:spring/junit.xml"
})
@RunWith(SpringJUnit4ClassRunner.class)
@Transactional
public class MessagetServiceTest extends AbstractTest {

	// Servicios bajo Testeo
	@Autowired
	private MessageService			messageService;

	@Autowired
	private MessagesThreadService	messagesThreadService;

	@Autowired
	private RouteService			routeService;

	@Autowired
	private ActorService			actorService;

	@Autowired
	private ReservationService		ReservationService;


	@Override
	public void setUp() {
		Route route1;
		Calendar now;
		Actor actor;
		Reservation reserv;

		// Establecemos la fecha de salida a esta ruta en hace dos horas para poder comentar en ella
		route1 = this.routeService.findOne(this.getEntityId("route1"));
		now = Calendar.getInstance();
		now.setTime(new Date());
		now.add(Calendar.HOUR, -2);
		route1.setDepartureDate(now.getTime());

		this.authenticate("passenger31@gmail.com");
		actor = this.actorService.findByPrincipal();

		reserv = this.ReservationService.create();
		reserv.setStatus(ReservationStatus.ACCEPTED);
		reserv.setRoute(route1);
		reserv.setPassenger((Passenger) actor);
		reserv.setPrice(1.0);
		reserv.setOrigin("A");
		reserv.setDestination("B");
		this.ReservationService.save2(reserv);

		this.authenticate(null);

	}

	@Test
	public void CanReport() {
		// Test del método CanMessage intentando probar todas las variables que tiene en cuenta
		final Object testingData[][] = {
			{
				"driver1", "route1", true
			}, {
				"driver1", "route10", false
			}, {
				"passenger31", "route1", true
			}, {
				"passenger31", "route10", false
			}, {
				"driver2", "route1", false
			}, {
				"passenger32", "route1", false
			}
		};

		for (int i = 0; i < testingData.length; i++)
			this.CanReportTemplate((String) testingData[i][0], (String) testingData[i][1], (Boolean) testingData[i][2]);
	}

	public void CanReportTemplate(final String userName, final String routeBean, final Boolean expected) {
		Route route;
		Actor actor;

		route = this.routeService.findOne(this.getEntityId(routeBean));

		this.authenticate(userName + "@gmail.com");
		actor = this.actorService.findByPrincipal();

		Assert.isTrue(this.messagesThreadService.canReport(actor, route) == expected);

		this.authenticate(null);
	}

	//	@Test
	//	public void MessageFlow() {
	//		// Test del método Save de MessageService intentando probar todas las variables que tiene en cuenta
	//
	//		final Object testingData[][] = {
	//			{
	//				"driver1", "passenger31", true, "route1", null, "driver1@gmail.com"
	//			}, {
	//				"driver1", "passenger31", false, "route1", null, "passenger31@gmail.com"
	//			}, {
	//				"driver1", "passenger32", true, "route1", IllegalArgumentException.class, "driver1@gmail.com"
	//			}, {
	//				"driver2", "passenger31", true, "route1", IllegalArgumentException.class, "driver2@gmail.com"
	//			}, {
	//				"driver2", "passenger31", false, "route1", IllegalArgumentException.class, "driver2@gmail.com"
	//			}, {
	//				"driver1", "passenger31", true, "route1", IllegalArgumentException.class, "driver2@gmail.com"
	//			}, {
	//				"driver1", "passenger31", false, "route1", IllegalArgumentException.class, "passenger2@gmail.com"
	//			}
	//		};
	//
	//		for (int i = 0; i < testingData.length; i++) {
	//			this.MessageFlowTemplate((String) testingData[i][0], (String) testingData[i][1], (Boolean) testingData[i][2], (String) testingData[i][3], (Class<?>) testingData[i][4], (String) testingData[i][5]);
	//		}
	//	}
	//
	//	public void MessageFlowTemplate(String driverBean, String passengerBean, Boolean fromDriver, String routeBean, Class<?> expected, String userAccount) {
	//
	//		Class<?> caught;
	//		Message message;
	//		Driver driver;
	//		Passenger passenger;
	//		Route route;
	//
	//		message = new Message();
	//		message.setDate(new Date());
	//		message.setStar(1.0);
	//		message.setText("wasd");
	//
	//		caught = null;
	//
	//		try {
	//
	//			driver = (Driver) this.actorService.findOne(this.getEntityId(driverBean));
	//			passenger = (Passenger) this.actorService.findOne(this.getEntityId(passengerBean));
	//			route = this.routeService.findOne(this.getEntityId(routeBean));
	//
	//			message.setDriver(driver);
	//			message.setPassenger(passenger);
	//			message.setRoute(route);
	//			message.setFromDriver(fromDriver);
	//
	//			this.authenticate(userAccount);
	//
	//			message = this.messageService.save(message);
	//			Assert.notNull(message);
	//
	//		} catch (Throwable oops) {
	//			caught = oops.getClass();
	//		}
	//
	//		this.authenticate(null);
	//
	//		this.checkExceptions(expected, caught);
	//
	//	}

}
