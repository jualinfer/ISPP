package services;

import java.util.Date;

import javax.transaction.Transactional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import utilities.AbstractTest;
import domain.Passenger;
import domain.Reservation;
import domain.ReservationStatus;
import domain.Route;

@ContextConfiguration(locations = { "classpath:spring/junit.xml" })
@RunWith(SpringJUnit4ClassRunner.class)
@Transactional
public class ReservationServiceTest extends AbstractTest {

	// Servicios bajo Testeo
	@Autowired
	private RouteService routeService;

	@Autowired
	private ReservationService reservationService;
	@Autowired
	private ActorService actorService;

	@Test
	public void confirmReservation() {

		final Object testingData[][] = {

				{ 1573, null, 1100, "driver1", "driver8@gmail.com" },
				{ 1573, IllegalArgumentException.class, 1100, "driver1",
						"driver1@gmail.com" },

		};

		for (int i = 0; i < testingData.length; i++) {
			this.confirmReservationTemplate((int) testingData[i][0],
					(Class<?>) testingData[i][1], (int) testingData[i][2],
					(String) testingData[i][3], (String) testingData[i][4]);
		}
	}

	// 1417

	public void confirmReservationTemplate(int idReservation,
			Class<?> expected, int idRoute, String passengerBean,
			String userAccount) {
		Class<?> caught;
		Reservation reservation = this.reservationService
				.findOne(idReservation);
		caught = null;
		try {
			this.authenticate(userAccount);
			Route route = reservation.getRoute();
			Date fecha = new Date();
			fecha.setYear(2020);
			route.setDepartureDate(fecha);
			Route newRoute = this.routeService.save2(route);
			reservation.setRoute(newRoute);
			reservation.setStatus(ReservationStatus.PENDING);
			this.reservationService.confirmReservation(reservation);

		} catch (Throwable oops) {
			caught = oops.getClass();
		}

		this.authenticate(null);

		this.checkExceptions(expected, caught);
	}

	@Test
	public void autoReject() {

		final Object testingData[][] = {

		{ 1100, null }, { 11001, IllegalArgumentException.class },
				{ 1120, null },

		};

		for (int i = 0; i < testingData.length; i++) {
			this.autoRejectTemplate((int) testingData[i][0],
					(Class<?>) testingData[i][1]);
		}
	}

	public void autoRejectTemplate(int idRoute, Class<?> expected) {
		Class<?> caught;
		caught = null;
		try {
			Route route = this.routeService.findOne(idRoute);
			this.reservationService.autoReject(route);

		} catch (Throwable oops) {
			caught = oops.getClass();
		}

		this.authenticate(null);

		this.checkExceptions(expected, caught);
	}

	@Test
	public void rejectReservation() {

		final Object testingData[][] = {

				{ 1417, null, "passenger31", "passenger31@gmail.com" },
				{ 1417, IllegalArgumentException.class, "passenger31",
						"holaholagmail.com" },
				{ 1420, null, "passenger31", "passenger31@gmail.com" },

		};

		for (int i = 0; i < testingData.length; i++) {
			this.rejectReservationTemplate((int) testingData[i][0],
					(Class<?>) testingData[i][1], (String) testingData[i][2],
					(String) testingData[i][3]);
		}
	}

	public void rejectReservationTemplate(int reservationId, Class<?> expected,
			String driverBean, String userAccount) {
		Class<?> caught;
		caught = null;
		Passenger passenger = (Passenger) this.actorService.findOne(this
				.getEntityId(driverBean));
		try {
			this.authenticate(userAccount);
			Reservation reservation = this.reservationService
					.findOne(reservationId);
			Route route = reservation.getRoute();
			Date fecha = new Date();
			fecha.setYear(2020);
			route.setDepartureDate(fecha);
			Route newRoute = this.routeService.save2(route);
			reservation.setRoute(newRoute);
			reservation.setStatus(ReservationStatus.PENDING);
			reservation.setPassenger(passenger);
			Reservation newReservation = this.reservationService
					.save2(reservation);

			this.reservationService.rejectReservation(newReservation.getId());

		} catch (Throwable oops) {
			caught = oops.getClass();
		}

		this.authenticate(null);

		this.checkExceptions(expected, caught);
	}

	@Test
	public void cancelReservation() {

		final Object testingData[][] = {

				{ 1417, null, "passenger31", "passenger31@gmail.com" },
				{ 1417, IllegalArgumentException.class, "passenger31",
						"holaholagmail.com" },
				{ 1420, null, "passenger31", "passenger31@gmail.com" },

		};

		for (int i = 0; i < testingData.length; i++) {
			this.cancelReservationTemplate((int) testingData[i][0],
					(Class<?>) testingData[i][1], (String) testingData[i][2],
					(String) testingData[i][3]);
		}
	}

	public void cancelReservationTemplate(int reservationId, Class<?> expected,
			String driverBean, String userAccount) {
		Class<?> caught;
		caught = null;
		Passenger passenger = (Passenger) this.actorService.findOne(this
				.getEntityId(driverBean));
		try {
			this.authenticate(userAccount);
			Reservation reservation = this.reservationService
					.findOne(reservationId);
			Route route = reservation.getRoute();
			Date fecha = new Date();
			fecha.setYear(2020);
			route.setDepartureDate(fecha);
			Route newRoute = this.routeService.save2(route);
			reservation.setRoute(newRoute);
			reservation.setStatus(ReservationStatus.PENDING);
			reservation.setPassenger(passenger);
			Reservation newReservation = this.reservationService
					.save2(reservation);

			this.reservationService.cancelReservation(newReservation.getId());

		} catch (Throwable oops) {
			caught = oops.getClass();
		}

		this.authenticate(null);

		this.checkExceptions(expected, caught);
	}

	@Test
	public void aceptReservation() {

		final Object testingData[][] = {

				{ 1417, null, "passenger31", "passenger31@gmail.com" },
				{ 1417, IllegalArgumentException.class, "passenger31",
						"holaholagmail.com" },
				{ 1420, null, "passenger31", "passenger31@gmail.com" },

		};

		for (int i = 0; i < testingData.length; i++) {
			this.aceptReservationTemplate((int) testingData[i][0],
					(Class<?>) testingData[i][1], (String) testingData[i][2],
					(String) testingData[i][3]);
		}
	}

	public void aceptReservationTemplate(int reservationId, Class<?> expected,
			String driverBean, String userAccount) {
		Class<?> caught;
		caught = null;
		Passenger passenger = (Passenger) this.actorService.findOne(this
				.getEntityId(driverBean));
		try {
			this.authenticate(userAccount);
			Reservation reservation = this.reservationService
					.findOne(reservationId);
			Route route = reservation.getRoute();
			Date fecha = new Date();
			fecha.setYear(2020);
			route.setDepartureDate(fecha);
			Route newRoute = this.routeService.save2(route);
			reservation.setRoute(newRoute);
			reservation.setStatus(ReservationStatus.PENDING);
			reservation.setPassenger(passenger);
			Reservation newReservation = this.reservationService
					.save2(reservation);

			this.reservationService.acceptReservation(newReservation.getId());

		} catch (Throwable oops) {
			caught = oops.getClass();
		}

		this.authenticate(null);

		this.checkExceptions(expected, caught);
	}

	@Test
	public void driverNoPickedMe() {

		final Object testingData[][] = {

				{ 1417, null, "passenger31", "passenger31@gmail.com" },
				{ 1417, IllegalArgumentException.class, "passenger31",
						"holaholagmail.com" },
				{ 1420, null, "passenger31", "passenger31@gmail.com" },

		};

		for (int i = 0; i < testingData.length; i++) {
			this.driverNoPickedMeTemplate((int) testingData[i][0],
					(Class<?>) testingData[i][1], (String) testingData[i][2],
					(String) testingData[i][3]);
		}
	}

	public void driverNoPickedMeTemplate(int reservationId, Class<?> expected,
			String driverBean, String userAccount) {
		Class<?> caught;
		caught = null;
		try {
			this.authenticate(userAccount);
			Reservation reservation = this.reservationService
					.findOne(reservationId);

			Reservation newReservation = this.reservationService
					.save2(reservation);

			this.reservationService.driverNoPickedMe(newReservation.getId());

		} catch (Throwable oops) {
			caught = oops.getClass();
		}

		this.authenticate(null);

		this.checkExceptions(expected, caught);
	}

}
