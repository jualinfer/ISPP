
package services;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import repositories.ReservationRepository;
import security.LoginService;
import security.UserAccount;
import domain.Actor;
import domain.Driver;
import domain.LuggageSize;
import domain.Passenger;
import domain.Reservation;
import domain.ReservationStatus;
import domain.Route;

@Service
@Transactional
public class ReservationService {

	//Managed repository

	@Autowired
	private ReservationRepository	reservationRepository;

	//Supporting Services

	@Autowired
	private ActorService			actorService;
	@Autowired
	private RouteService			routeService;

	@Autowired
	private PassengerService		passengerService;


	//Constructor
	public ReservationService() {
		super();
	}

	//CRUD

	public Reservation create() {
		//	final UserAccount ua;
		//	Passenger passenger;
		Reservation result;

		//	ua = LoginService.getPrincipal();
		//	passenger = (Passenger) this.actorService.findByUserAccount(ua);
		//	Assert.notNull(ua);

		result = new Reservation();
		//		result.setPassenger(passenger);
		result.setStatus(ReservationStatus.PENDING);
		result.setLuggageSize(LuggageSize.NOTHING);

		return result;
	}

	public Collection<Reservation> findAll() {
		Collection<Reservation> result;

		result = this.reservationRepository.findAll();

		return result;
	}

	public Reservation findOne(final int reservationId) {
		Assert.isTrue(reservationId != 0);

		Reservation result;

		result = this.reservationRepository.findOne(reservationId);

		return result;
	}

	public Reservation save(final Reservation reservation) {
		Assert.notNull(reservation);
		Assert.notNull(reservation.getOrigin());
		Assert.notNull(reservation.getDestination());
		Assert.isTrue(!reservation.getOrigin().equals(reservation.getDestination()));
		Assert.notNull(reservation.getRoute());
		Assert.notNull(reservation.getSeat());
		Assert.notNull(reservation.getLuggageSize());
		Assert.notNull(reservation.getPrice());
		Assert.notNull(reservation.getStatus());

		Reservation result;
		UserAccount ua;
		Passenger passenger;
		Route route;
		Collection<Reservation> reservationsRoute, reservationsPassenger;

		//Comprobamos que el usuario registrado es el mismo pasajero que ha creado la reserva
		ua = LoginService.getPrincipal();
		passenger = (Passenger) this.actorService.findByUserAccount(ua);
		Assert.notNull(passenger);
		Assert.isTrue(passenger.equals(reservation.getPassenger()));
		reservation.setPassenger(passenger);
		//Comprobamos que la solicitud no se manda 5 minutos antes de la hora de salida
		route = reservation.getRoute();

		//----proceso para conseguir un Date de 5 minutos antes de la fecha y hora de salida---
		final Calendar date = Calendar.getInstance();
		date.setTime(route.getDepartureDate());
		final long departureDateMilis = date.getTimeInMillis();
		final Date lastFiveMinutes = new Date(departureDateMilis - 300000);
		//---------------------------------------------------------------------------------
		Assert.isTrue(lastFiveMinutes.after(new Date()));

		if (reservation.getStatus() == ReservationStatus.ACCEPTED)
			route.setAvailableSeats(route.getAvailableSeats() - reservation.getSeat());

		//Al guardarse la reserva se añade a la lista de reservas de la ruta
		reservationsRoute = route.getReservations();
		reservationsRoute.add(reservation);
		route.setReservations(reservationsRoute);
		this.routeService.save(route);

		//Al guardarse la reserva se añade a la lista de reservas del pasajero
		reservationsPassenger = passenger.getReservations();
		reservationsPassenger.add(reservation);
		passenger.setReservations(reservationsPassenger);
		this.passengerService.save(passenger);

		result = this.reservationRepository.save(reservation);

		return result;
	}

	// Esta función solo se debe llamar desde RouteService.cancel(route), ya que las
	// comprobaciones se hacen en el cancel y las condiciones del autoReject no son
	// exactamente las mismas que cuando un driver rechaza una solicitud manualmente
	public void autoReject(final Route route) {
		Assert.notNull(route);

		final Collection<Reservation> reservations = this.findReservationsByRouteAndStatusPendingOrAccepted(route.getId());

		if (!reservations.isEmpty()) {
			for (final Reservation r : reservations)
				r.setStatus(ReservationStatus.REJECTED);

			this.reservationRepository.save(reservations);
			this.reservationRepository.flush();
		}
	}

	public void delete(final Reservation reservation) {
		UserAccount ua;
		Actor principal;
		Passenger passenger;
		Driver driver;
		Route route;
		Collection<Reservation> reservationsRoute, reservationsPassenger;

		//Comprobamos que el usuario registrado es o el mismo pasajero que ha creado la reserva o el conductor de la ruta
		route = reservation.getRoute();
		passenger = reservation.getPassenger();
		driver = route.getDriver();
		ua = LoginService.getPrincipal();
		principal = this.actorService.findByUserAccount(ua);
		Assert.notNull(principal);
		Assert.isTrue(principal.equals(passenger) || principal.equals(driver));
		//Comprobamos que no se elimina despues de empezar el viaje
		Assert.isTrue(route.getDepartureDate().after(new Date()));

		//Si se borra la reserva, se elimina de la lista de reservas del pasajero
		reservationsPassenger = passenger.getReservations();
		reservationsPassenger.remove(reservation);
		this.passengerService.save(passenger);

		//Si se borra la reserva, se elimina de la lista de reservas de la ruta
		if (reservation.getStatus() == ReservationStatus.CANCELLED || reservation.getStatus() == ReservationStatus.REJECTED)
			route.setAvailableSeats(route.getAvailableSeats() + reservation.getSeat());
		reservationsRoute = route.getReservations();
		reservationsRoute.remove(reservation);
		this.routeService.save(route);

		this.reservationRepository.delete(reservation);
	}

	//Other business methods

	public Collection<Reservation> findReservationsByPassenger(final int passengerId) {
		Assert.isTrue(passengerId != 0);

		Collection<Reservation> result;

		result = this.reservationRepository.findReservationsByPassenger(passengerId);

		return result;
	}

	public Collection<Reservation> findReservationsByRoute(final int routeId) {
		Assert.isTrue(routeId != 0);

		Collection<Reservation> result;

		result = this.reservationRepository.findReservationsByRoute(routeId);

		return result;
	}

	public Collection<Reservation> findReservationsByRouteAndStatusPendingOrAccepted(final int routeId) {
		Assert.isTrue(routeId != 0);

		Collection<Reservation> result;

		result = this.reservationRepository.findReservationsByRouteAndStatusPendingOrAccepted(routeId, ReservationStatus.PENDING, ReservationStatus.ACCEPTED);

		return result;
	}

	public Collection<Reservation> findAcceptedReservationsByRoute(final int routeId) {
		Assert.isTrue(routeId != 0);

		final Collection<Reservation> result;
		Route route;

		route = this.routeService.findOne(routeId);
		result = new ArrayList<Reservation>();

		for (final Reservation r : route.getReservations())
			if (r.getStatus().equals(ReservationStatus.ACCEPTED))
				result.add(r);

		return result;
	}

	public Collection<Reservation> findPendingReservationsByRoute(final int routeId) {
		Assert.isTrue(routeId != 0);

		final Collection<Reservation> result;
		Route route;

		route = this.routeService.findOne(routeId);
		result = new ArrayList<Reservation>();

		for (final Reservation r : route.getReservations())
			if (r.getStatus().equals(ReservationStatus.PENDING))
				result.add(r);

		return result;
	}

	public Collection<Reservation> findCancelledReservationsByRoute(final int routeId) {
		Assert.isTrue(routeId != 0);

		final Collection<Reservation> result;
		Route route;

		route = this.routeService.findOne(routeId);
		result = new ArrayList<Reservation>();

		for (final Reservation r : route.getReservations())
			if (r.getStatus().equals(ReservationStatus.CANCELLED))
				result.add(r);

		return result;
	}

	public void driverPickedMe(final int reservationId) {
		final Reservation reservation = this.reservationRepository.findOne(reservationId);

		reservation.setDriverPickedMe(true);
		reservation.setDriverNoPickedMe(false);
	}

	public void driverNoPickedMe(final int reservationId) {
		final Reservation reservation = this.reservationRepository.findOne(reservationId);

		reservation.setDriverPickedMe(false);
		reservation.setDriverNoPickedMe(true);
	}

	public void acceptReservation(final int reservationId) {
		Assert.isTrue(reservationId > 0);
		final Reservation reservation = this.findOne(reservationId);
		final Route route = reservation.getRoute();

		//Comprobamos que la ruta está en pendiente
		Assert.isTrue(reservation.getStatus().equals(ReservationStatus.PENDING));

		//Comprobamos que la ruta no ha empezado todavía
		Assert.isTrue(route.getDepartureDate().after(new Date()));

		//Comprobamos que quedan plazas disponibles
		final Integer availableSeats = route.getAvailableSeats();
		Integer countSeats = 0;
		Integer totalSeats = 0;

		final Collection<Reservation> reservations = new ArrayList<Reservation>();
		reservations.addAll(this.findAcceptedReservationsByRoute(route.getId()));

		for (final Reservation r : reservations)
			countSeats = countSeats + r.getSeat();
		totalSeats = availableSeats - countSeats;
		Assert.isTrue(totalSeats >= 0);

		reservation.setStatus(ReservationStatus.ACCEPTED);
		this.reservationRepository.save(reservation);
	}

	public void rejectReservation(final int reservationId) {
		Assert.isTrue(reservationId > 0);
		final Reservation reservation = this.findOne(reservationId);
		final Route route = reservation.getRoute();
		Assert.isTrue(reservation.getStatus().equals(ReservationStatus.PENDING) || reservation.getStatus().equals(ReservationStatus.ACCEPTED));
		Assert.isTrue(route.getDepartureDate().after(new Date()));

		reservation.setStatus(ReservationStatus.REJECTED);
		this.reservationRepository.save(reservation);
	}

	public void cancelReservation(final int reservationId) {
		Assert.isTrue(reservationId > 0);
		final Reservation reservation = this.findOne(reservationId);
		final Route route = reservation.getRoute();
		Assert.isTrue(reservation.getStatus().equals(ReservationStatus.ACCEPTED) || reservation.getStatus().equals(ReservationStatus.PENDING));	//TODO: en vez de PENDING ponia REJECTED
		Assert.isTrue(route.getDepartureDate().after(new Date()));

		reservation.setStatus(ReservationStatus.CANCELLED);
		this.reservationRepository.save(reservation);
	}

}
