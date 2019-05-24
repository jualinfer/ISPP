/*
 * ReservationController.java
 *
 * Copyright (C) 2019 Universidad de Sevilla
 *
 * The use of this project is hereby constrained to the conditions of the
 * TDG Licence, a copy of which you may download from
 * http://www.tdg-seville.info/License.html
 */

package controllers.passenger;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import security.LoginService;
import security.UserAccount;
import services.ActorService;
import services.CommentService;
import services.MessagesThreadService;
import services.ReservationService;
import services.RouteService;
import utilities.StripeConfig;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Charge;
import com.stripe.model.Payout;
import com.stripe.model.Refund;

import controllers.AbstractController;
import domain.Actor;
import domain.Administrator;
import domain.Driver;
import domain.Passenger;
import domain.Reservation;
import domain.ReservationStatus;
import domain.Route;
import forms.CommentForm;
import forms.ReservationForm;

@Controller
@RequestMapping("/reservation/passenger")
public class ReservationPassengerController extends AbstractController {

	@Autowired
	private ReservationService	reservationService;
	@Autowired
	private CommentService 		commentService;
	@Autowired
	private MessagesThreadService	mtService;
	@Autowired
	private RouteService		routeService;
	@Autowired
	private ActorService		actorService;


	// Constructor --------------------------------------------------------
	public ReservationPassengerController() {
		super();
	}
	// Create ---------------------------------------------------------------

	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public ModelAndView create(@RequestParam final int routeId) {
		ModelAndView result;
		try {
			final Passenger passenger = (Passenger) this.actorService.findByPrincipal();

			final Route route = this.routeService.findOne(routeId);

			final ReservationForm reservation = this.reservationService.construct(this.reservationService.create(), route, passenger);
			result = this.createEditModelAndView(reservation);
		} catch (final Throwable oops) {
			result = new ModelAndView("redirect:/welcome.do");
		}
		return result;
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public ModelAndView save(@ModelAttribute(value = "reservation") @Valid final ReservationForm reservationForm, final BindingResult binding) {

		ModelAndView result = null;
		if (binding.hasErrors())
			result = this.createEditModelAndView(reservationForm);
		else
			try {
				final Passenger passenger = (Passenger) this.actorService.findByPrincipal();

				Reservation reservation = this.reservationService.reconstruct(reservationForm, passenger, binding);
				if (binding.hasErrors())
					result = this.createEditModelAndView(reservationForm);
				else {
					Stripe.apiKey = StripeConfig.SECRET_KEY;
					final Double finalPrice = reservation.getPrice() * 100;
					final Map<String, Object> chargeParams = new HashMap<>();
					chargeParams.put("amount", Integer.toString(finalPrice.intValue()));
					chargeParams.put("currency", StripeConfig.CURRENCY);
					chargeParams.put("description", "Reservation from user ID '" + reservation.getPassenger().getId() + "' on route ID '" + reservation.getRoute().getId() + "'");
					chargeParams.put("source", reservationForm.getStripeToken());
					final Charge charge = Charge.create(chargeParams);

					reservation.setChargeId(charge.getId());
					reservation = this.reservationService.save2(reservation);
					result = new ModelAndView("redirect:/route/display.do?routeId=" + reservation.getRoute().getId());
				}
			} catch (final StripeException e) {

				e.printStackTrace();
				result = this.createEditModelAndView(reservationForm, "reservation.commit.error");
			} catch (final Throwable oops) {
				oops.printStackTrace();
				result = this.createEditModelAndView(reservationForm, "reservation.commit.error");
			}
		return result;
	}
	private ModelAndView createEditModelAndView(final ReservationForm reservation) {
		return this.createEditModelAndView(reservation, null);
	}

	private ModelAndView createEditModelAndView(final ReservationForm reservation, final String message) {
		Route route;
		Collection<Reservation> routeAcceptedReservations;
		Integer remainingSeats;
		boolean routeLugNothing = false;
		boolean routeLugMedium = false;
		boolean routeLugBig = false;

		route = reservation.getRoute();

		switch (route.getMaxLuggage()) {
		case NOTHING:
			routeLugNothing = true;
			break;
		case MEDIUM:
			routeLugMedium = true;
			break;
		case BIG:
			routeLugBig = true;
			break;
		case SMALL:
			break;
		default:
			break;
		}
		//------------Asientos restantes--------------------
		routeAcceptedReservations = this.reservationService.findAcceptedReservationsByRoute(route.getId());
		remainingSeats = route.getAvailableSeats();
		for (final Reservation res : routeAcceptedReservations)
			remainingSeats = remainingSeats - res.getSeat();

		//Comprobamos que haya asientos disponibles
		Assert.isTrue(remainingSeats > 0);

		final ModelAndView result = new ModelAndView("reservation/passenger/create");
		result.addObject("reservation", reservation);
		result.addObject("requestURI", "reservation/passenger/save.do");
		result.addObject("message", message);
		result.addObject("stripePublicKey", StripeConfig.PUBLIC_KEY);
		result.addObject("currency", StripeConfig.CURRENCY);
		result.addObject("remainingSeats", remainingSeats);
		result.addObject("LugNothing", routeLugNothing);
		result.addObject("LugMedium", routeLugMedium);
		result.addObject("LugBig", routeLugBig);

		return result;
	}

	/*
	 * @RequestMapping(value = "/create", method = RequestMethod.GET)
	 * public ModelAndView create(@RequestParam final int routeId) {
	 * ModelAndView result;
	 * Route route;
	 * Reservation reservation;
	 * UserAccount ua;
	 * Passenger passenger;
	 *
	 * ua = LoginService.getPrincipal();
	 * passenger = (Passenger) this.actorService.findByUserAccount(ua);
	 * Assert.notNull(passenger);
	 *
	 * route = this.routeService.findOne(routeId);
	 *
	 * reservation = this.reservationService.create();
	 * reservation.setRoute(route);
	 * reservation.setPrice(route.getPricePerPassenger());
	 * reservation.setPassenger(passenger);
	 *
	 * result = this.createEditModelAndView(reservation);
	 *
	 * return result;
	 * }
	 */

	/*
	 * @RequestMapping(value = "/create", method = RequestMethod.POST, params = "save")
	 * public ModelAndView save(@Valid final Reservation reservation, final BindingResult binding) {
	 * ModelAndView result;
	 * Route route;
	 *
	 * if (binding.hasErrors()) {
	 * result = this.createEditModelAndView(reservation);
	 * System.out.println(binding.getAllErrors());
	 * }
	 * else {
	 * try {
	 * route = reservation.getRoute();
	 * this.reservationService.save(reservation);
	 * result = new ModelAndView("reservation/passenger/confirmReservation");
	 * result.addObject("reservation", reservation);
	 * result.addObject("route", reservation.getRoute());
	 * result.addObject("requestURI", "reservation/passenger/confirm.do");
	 * }
	 * catch (final Throwable oops) {
	 * oops.printStackTrace();
	 * result = this.createEditModelAndView(reservation, "reservation.commit.error");
	 * }
	 * }
	 * return result;
	 * }
	 */

	@RequestMapping(value = "/confirmReservation", method = RequestMethod.POST)
	public ModelAndView confirmReservation(@Valid final Reservation reservation, final BindingResult binding) {
		ModelAndView result;
		Reservation savedReservation;
		Passenger passenger;
		UserAccount ua;
		Route route;

		if (binding.hasErrors()) {
			result = this.createEditModelAndView(reservation);
			System.out.println(binding.getAllErrors());
		} else
			try {
				ua = LoginService.getPrincipal();
				passenger = (Passenger) this.actorService.findByUserAccount(ua);
				Assert.notNull(passenger);

				savedReservation = this.reservationService.confirmReservation(reservation);

				route = reservation.getRoute();
				Assert.notNull(route);
				result = new ModelAndView("redirect:/route/display.do?routeId=" + route.getId());

				//TENGO QUE PASARLE OTRA VEZ TODA LA INFO QUE HAY EN EL DISPLAY DE ROUTE

				Collection<Reservation> reservations, displayableReservations;
				Integer occupiedSeats;
				boolean startedRoute = false;
				boolean hasPassed10Minutes = false;
				boolean arrivalPlus10Min = false;

				reservations = route.getReservations();
				displayableReservations = new ArrayList<Reservation>();
				occupiedSeats = 0;
				ua = LoginService.getPrincipal();

				if (reservations != null && reservations.size() > 0)
					for (final Reservation res : reservations)
						if (res.getStatus().equals(ReservationStatus.ACCEPTED)) {
							occupiedSeats = occupiedSeats + res.getSeat();		//Contamos asientos ocupados
							displayableReservations.add(res);	//añadimos las reservas aceptadas
						}

				if (route.getDepartureDate().before(new Date()))
					startedRoute = true;

				//----proceso para conseguir la fecha de llegada---
				final Calendar date = Calendar.getInstance();
				date.setTime(route.getDepartureDate());
				final long departureDateMilis = date.getTimeInMillis();
				final Date arrivalDate = new Date(departureDateMilis + route.getEstimatedDuration() * 60000);
				final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
				sdf.format(arrivalDate);
				//------------------------------------------------

				//----proceso para conseguir la fecha de salida + 10 minutos---
				final Date tenMinutesAfterDeparture = new Date(departureDateMilis + 600000);
				if (new Date().after(tenMinutesAfterDeparture))
					hasPassed10Minutes = true;
				//----proceso para conseguir la fecha de llegada + 10 minutos---
				final Date tenMinutesAfterArrival = new Date(departureDateMilis + (route.getEstimatedDuration() * 60000) + 600000);
				if (new Date().after(tenMinutesAfterArrival))
					arrivalPlus10Min = true;
				//------------------------------------------------
				result.addObject("route", route);
				result.addObject("remainingSeats", route.getAvailableSeats() - occupiedSeats);
				result.addObject("arrivalDate", sdf.format(arrivalDate));
				result.addObject("reservations", displayableReservations);
				result.addObject("rol", 2);
				result.addObject("startedRoute", startedRoute);
				result.addObject("hasPassed10Minutes", hasPassed10Minutes);
				result.addObject("arrivalPlus10Min", arrivalPlus10Min);
			} catch (final Throwable oops) {
				oops.printStackTrace();
				result = this.createEditModelAndView(reservation, "reservation.commit.error");
			}
		return result;
	}

	/*
	 * @RequestMapping(value = "/saveConfirmation", method = RequestMethod.GET)
	 * public ModelAndView saveConfirmation(@RequestParam final int reservationId) {
	 * ModelAndView result;
	 * Reservation reservation;
	 * Passenger passenger;
	 * UserAccount ua;
	 * Route route;
	 *
	 * ua = LoginService.getPrincipal();
	 * passenger = (Passenger) this.actorService.findByUserAccount(ua);
	 * Assert.notNull(passenger);
	 *
	 * reservation = this.reservationService.findOne(reservationId);
	 * this.reservationService.confirmReservation(reservation);
	 *
	 * route = reservation.getRoute();
	 * Assert.notNull(route);
	 * result = new ModelAndView("redirect: /route/display.do?routeId=" + route.getId());
	 *
	 * //TENGO QUE PASARLE OTRA VEZ TODA LA INFO QUE HAY EN EL DISPLAY DE ROUTE
	 *
	 * Collection<Reservation> reservations, displayableReservations;
	 * Integer occupiedSeats;
	 * boolean startedRoute = false;
	 * boolean hasPassed10Minutes = false;
	 * boolean arrivalPlus10Min = false;
	 *
	 * reservations = route.getReservations();
	 * displayableReservations = new ArrayList<Reservation>();
	 * occupiedSeats = 0;
	 * ua = LoginService.getPrincipal();
	 *
	 * if (reservations != null && reservations.size() > 0)
	 * for (final Reservation res : reservations)
	 * if (res.getStatus().equals(ReservationStatus.ACCEPTED)) {
	 * occupiedSeats++; //Contamos asientos ocupados
	 * displayableReservations.add(res); //añadimos las reservas aceptadas
	 * }
	 *
	 * if (route.getDepartureDate().before(new Date()))
	 * startedRoute = true;
	 *
	 * //----proceso para conseguir la fecha de llegada---
	 * final Calendar date = Calendar.getInstance();
	 * date.setTime(route.getDepartureDate());
	 * final long departureDateMilis = date.getTimeInMillis();
	 * final Date arrivalDate = new Date(departureDateMilis + route.getEstimatedDuration() * 60000);
	 * final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
	 * sdf.format(arrivalDate);
	 * //------------------------------------------------
	 *
	 * //----proceso para conseguir la fecha de salida + 10 minutos---
	 * final Date tenMinutesAfterDeparture = new Date(departureDateMilis + 600000);
	 * if (new Date().after(tenMinutesAfterDeparture))
	 * hasPassed10Minutes = true;
	 * //----proceso para conseguir la fecha de salida + 10 minutos---
	 * final Date twentyMinutesAfterDeparture = new Date(departureDateMilis + (600000 * 2));
	 * if (new Date().after(twentyMinutesAfterDeparture))
	 * arrivalPlus10Min = true;
	 * //------------------------------------------------
	 * result.addObject("route", route);
	 * result.addObject("remainingSeats", route.getAvailableSeats() - occupiedSeats);
	 * result.addObject("arrivalDate", sdf.format(arrivalDate));
	 * result.addObject("reservations", displayableReservations);
	 * result.addObject("rol", 2);
	 * result.addObject("startedRoute", startedRoute);
	 * result.addObject("hasPassed10Minutes", hasPassed10Minutes);
	 * result.addObject("arrivalPlus10Min", arrivalPlus10Min);
	 *
	 * return result;
	 *
	 * }
	 */
	// Confirmacion de que conductor me ha recogido ---------------------------------------------------------------

	@RequestMapping(value = "/driverPickUp", method = RequestMethod.GET)
	public ModelAndView driverPickUp(final int reservationId) {
		ModelAndView result;

		result = new ModelAndView("reservation/passenger/driverPickUp");

		//TENGO QUE PASARLE OTRA VEZ TODA LA INFO QUE HAY EN EL DISPLAY DE ROUTE

		Route route;
		Collection<Reservation> reservations, displayableReservations;
		Integer occupiedSeats;
		UserAccount ua;
		Actor actor;
		Integer rol = 0;	//1->conductor de la ruta | 2->pasajero con reserva | 3-> pasajero sin reserva | 4->admin
		//		Reservation reservation;
		boolean startedRoute = false;
		boolean hasPassed10Minutes = false;
		boolean arrivalPlus10Min = false;
		boolean canComment = false;
		Collection<Passenger> passengersToComment = new ArrayList<Passenger>();
		final CommentForm commentForm = new CommentForm();
		Reservation currentReservation = null;

		currentReservation = this.reservationService.driverPickedMe(reservationId);
		route = currentReservation.getRoute();
		Assert.notNull(route);
		commentForm.setRoute(route);
		startedRoute = route.getDepartureDate().before(new Date());
//		reservation = this.reservationService.create();
//		reservation.setRoute(route);


		reservations = route.getReservations();
		displayableReservations = new ArrayList<Reservation>();
		occupiedSeats = 0;
		ua = LoginService.getPrincipal();
		actor = this.actorService.findByUserAccount(ua);
		Assert.notNull(actor);

		if (actor instanceof Driver) {
			final Driver driver = (Driver) actor;
			if (route.getDriver().equals(driver)) {
				rol = 1;
			}
		}
		if (reservations != null && reservations.size() > 0) {
			for (final Reservation res : reservations) {
				if (res.getStatus().equals(ReservationStatus.ACCEPTED)) {
					occupiedSeats = occupiedSeats + res.getSeat();		//Contamos asientos ocupados
					displayableReservations.add(res);	//añadimos las reservas aceptadas
				}
				if (actor instanceof Driver) {
					final Driver driver = (Driver) actor;
					if (route.getDriver().equals(driver)) {				//Si el conductor logeado es el de la ruta...
						rol = 1;							//...se considerará como "conductor de la ruta"...
						if (route.getDepartureDate().after(new Date())) {
							if (res.getStatus().equals(ReservationStatus.PENDING)) {
								displayableReservations.add(res);	//...añadimos tambien reservas pendientes
							}
						}
					}
				}

				if (actor instanceof Passenger) {					//Si el actor logueado es pasajero...
					final Passenger passenger = (Passenger) actor;
					for (final Reservation r : reservations) {
						//...y ha hecho alguna reserva en la ruta
						if (r.getPassenger().equals(passenger)) {
							rol = 2;		//...se considerara como "pasajero con reserva"
							result.addObject("reservation", r);
							if (route.getDepartureDate().before(new Date())) {
								startedRoute = true;
							}
							break;
						} else {
							rol = 3;
						}
					}
				}

				if (actor instanceof Administrator) {
					rol = 4;
				}
			}
		} else if (actor instanceof Passenger) {
			//final Passenger passenger = (Passenger) actor;
			rol = 3;
		}

		//----proceso para conseguir la fecha de llegada---
		final Calendar date = Calendar.getInstance();
		date.setTime(route.getDepartureDate());
		final long departureDateMilis = date.getTimeInMillis();
		final Date arrivalDate = new Date(departureDateMilis + route.getEstimatedDuration() * 60000);
		final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
		sdf.format(arrivalDate);
		//------------------------------------------------

		//----proceso para conseguir la fecha de salida + 10 minutos---
		final Date tenMinutesAfterDeparture = new Date(departureDateMilis + 600000);
		if (new Date().after(tenMinutesAfterDeparture)) {
			hasPassed10Minutes = true;
		}
		//----proceso para conseguir la fecha de llegada + 10 minutos---
		final Date tenMinutesAfterArrival = new Date(departureDateMilis + (route.getEstimatedDuration() * 60000) + 600000);
		if (new Date().after(tenMinutesAfterArrival)) {
			arrivalPlus10Min = true;
			//------------------------------------------------
		}

		// Proceso para ver si el actor puede comentar y a quien puede comentar:
		canComment = this.commentService.canComment(actor, route);

		// En caso de ser un passenger, el metodo anterior ya determina si ha comentado para esta ruta y driver ya.
		// Pero si el actor es un driver, no se ha determinado aun si le queda algun passenger sobre el que opinar.
		if (canComment) {
			if (actor instanceof Driver) {
				passengersToComment = this.commentService.passengersToComment((Driver) actor, route.getId());
				if (passengersToComment.isEmpty()) {
					canComment = false;
				}
			}
		}

		final Actor connectedUser = this.actorService.findByPrincipal();
		
		result.addObject("route", route);
		result.addObject("remainingSeats", route.getAvailableSeats() - occupiedSeats);
		result.addObject("arrivalDate", sdf.format(arrivalDate));
		result.addObject("reservations", displayableReservations);
		result.addObject("rol", rol);
		//		result.addObject("newReservation", reservation);
		result.addObject("startedRoute", startedRoute);
		result.addObject("hasPassed10Minutes", hasPassed10Minutes);
		result.addObject("arrivalPlus10Min", arrivalPlus10Min);
		result.addObject("canComment", canComment);
		result.addObject("canReport", mtService.canReport(connectedUser, route));
		result.addObject("passengersToComment", passengersToComment);
		result.addObject("commentForm", commentForm);
		result.addObject("connectedUser", connectedUser);

		return result;
	}
	// Confirmacion de que conductor NO me ha recogido ---------------------------------------------------------------

	@RequestMapping(value = "/driverNoPickUp", method = RequestMethod.GET)
	public ModelAndView driverNoPickUp(final int reservationId) {
		ModelAndView result;

		result = new ModelAndView("reservation/passenger/driverNoPickUp");

		//TENGO QUE PASARLE OTRA VEZ TODA LA INFO QUE HAY EN EL DISPLAY DE ROUTE

		Route route;
		Collection<Reservation> reservations, displayableReservations;
		Integer occupiedSeats;
		UserAccount ua;
		Actor actor;
		Integer rol = 0;	//1->conductor de la ruta | 2->pasajero con reserva | 3-> pasajero sin reserva | 4->admin
		//		Reservation reservation;
		boolean startedRoute = false;
		boolean hasPassed10Minutes = false;
		boolean arrivalPlus10Min = false;
		boolean canComment = false;
		Collection<Passenger> passengersToComment = new ArrayList<Passenger>();
		final CommentForm commentForm = new CommentForm();
		Reservation currentReservation = null;

		currentReservation = this.reservationService.driverNoPickedMe(reservationId);
		route = currentReservation.getRoute();
		Assert.notNull(route);
		commentForm.setRoute(route);
		startedRoute = route.getDepartureDate().before(new Date());

		reservations = route.getReservations();
		displayableReservations = new ArrayList<Reservation>();
		occupiedSeats = 0;
		ua = LoginService.getPrincipal();
		actor = this.actorService.findByUserAccount(ua);
		Assert.notNull(actor);

		if (actor instanceof Driver) {
			final Driver driver = (Driver) actor;
			if (route.getDriver().equals(driver)) {
				rol = 1;
			}
		}
		if (reservations != null && reservations.size() > 0) {
			for (final Reservation res : reservations) {
				if (res.getStatus().equals(ReservationStatus.ACCEPTED)) {
					occupiedSeats = occupiedSeats + res.getSeat();		//Contamos asientos ocupados
					displayableReservations.add(res);	//añadimos las reservas aceptadas
				}
				if (actor instanceof Driver) {
					final Driver driver = (Driver) actor;
					if (route.getDriver().equals(driver)) {				//Si el conductor logeado es el de la ruta...
						rol = 1;							//...se considerará como "conductor de la ruta"...
						if (route.getDepartureDate().after(new Date())) {
							if (res.getStatus().equals(ReservationStatus.PENDING)) {
								displayableReservations.add(res);	//...añadimos tambien reservas pendientes
							}
						}
					}
				}

				if (actor instanceof Passenger) {					//Si el actor logueado es pasajero...
					final Passenger passenger = (Passenger) actor;
					for (final Reservation r : reservations) {
						//...y ha hecho alguna reserva en la ruta
						if (r.getPassenger().equals(passenger)) {
							rol = 2;		//...se considerara como "pasajero con reserva"
							result.addObject("reservation", r);
							if (route.getDepartureDate().before(new Date())) {
								startedRoute = true;
							}
							break;
						} else {
							rol = 3;
						}
					}
				}

				if (actor instanceof Administrator) {
					rol = 4;
				}
			}
		} else if (actor instanceof Passenger) {
			//final Passenger passenger = (Passenger) actor;
			rol = 3;
		}

		//----proceso para conseguir la fecha de llegada---
		final Calendar date = Calendar.getInstance();
		date.setTime(route.getDepartureDate());
		final long departureDateMilis = date.getTimeInMillis();
		final Date arrivalDate = new Date(departureDateMilis + route.getEstimatedDuration() * 60000);
		final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
		sdf.format(arrivalDate);
		//------------------------------------------------

		//----proceso para conseguir la fecha de salida + 10 minutos---
		final Date tenMinutesAfterDeparture = new Date(departureDateMilis + 600000);
		if (new Date().after(tenMinutesAfterDeparture)) {
			hasPassed10Minutes = true;
		}
		//----proceso para conseguir la fecha de llegada + 10 minutos---
		final Date tenMinutesAfterArrival = new Date(departureDateMilis + (route.getEstimatedDuration() * 60000) + 600000);
		if (new Date().after(tenMinutesAfterArrival)) {
			arrivalPlus10Min = true;
			//------------------------------------------------
		}

		// Proceso para ver si el actor puede comentar y a quien puede comentar:
		canComment = this.commentService.canComment(actor, route);

		// En caso de ser un passenger, el metodo anterior ya determina si ha comentado para esta ruta y driver ya.
		// Pero si el actor es un driver, no se ha determinado aun si le queda algun passenger sobre el que opinar.
		if (canComment) {
			if (actor instanceof Driver) {
				passengersToComment = this.commentService.passengersToComment((Driver) actor, route.getId());
				if (passengersToComment.isEmpty()) {
					canComment = false;
				}
			}
		}

		final Actor connectedUser = this.actorService.findByPrincipal();
		
		result.addObject("route", route);
		result.addObject("remainingSeats", route.getAvailableSeats() - occupiedSeats);
		result.addObject("arrivalDate", sdf.format(arrivalDate));
		result.addObject("reservations", displayableReservations);
		result.addObject("rol", rol);
		//		result.addObject("newReservation", reservation);
		result.addObject("startedRoute", startedRoute);
		result.addObject("hasPassed10Minutes", hasPassed10Minutes);
		result.addObject("arrivalPlus10Min", arrivalPlus10Min);
		result.addObject("canComment", canComment);
		result.addObject("canReport", mtService.canReport(connectedUser, route));
		result.addObject("passengersToComment", passengersToComment);
		result.addObject("commentForm", commentForm);
		result.addObject("connectedUser", connectedUser);

		return result;
	}

	// Cancel Reservation ---------------------------------------------------------------

	@RequestMapping(value = "/cancelReservation", method = RequestMethod.POST, params = "cancelReservation")
	public ModelAndView cancelReservation(@RequestParam(defaultValue = "0") final int reservationId) {
		ModelAndView res;
		final Reservation reservation = this.reservationService.findOne(reservationId);
		final Route route = this.routeService.findOne(reservation.getRoute().getId());

		try {
			if (reservation.getChargeId() != null) {
				final Calendar date = Calendar.getInstance();
				date.setTime(route.getDepartureDate());
				final long departureDateMilis = date.getTimeInMillis();
				final Date fifteenMinutesBeforeDeparture = new Date(departureDateMilis - 900000);

				if ((fifteenMinutesBeforeDeparture.after(new Date())) || (!fifteenMinutesBeforeDeparture.after(new Date()) && reservation.getStatus().equals(ReservationStatus.PENDING))) {
					Stripe.apiKey = StripeConfig.SECRET_KEY;
					final Map<String, Object> params = new HashMap<>();
					params.put("charge", reservation.getChargeId());
					final Refund refund = Refund.create(params);
				} else if (!fifteenMinutesBeforeDeparture.after(new Date()) && reservation.getStatus().equals(ReservationStatus.ACCEPTED)) {

					Stripe.apiKey = StripeConfig.SECRET_KEY;

					//payout
					final Map<String, Object> payoutParams = new HashMap<String, Object>();
					final Double reservPrice = reservation.getPrice() * 100;
					payoutParams.put("amount", Integer.toString(reservPrice.intValue()));
					payoutParams.put("currency", StripeConfig.CURRENCY);

					Payout.create(payoutParams);
				}
			}
			this.reservationService.cancelReservation(reservationId);
			res = new ModelAndView("redirect:/route/display.do?routeId=" + route.getId());

		} catch (final Exception e) {
			e.printStackTrace();
			res = new ModelAndView("redirect:/route/display.do?routeId=" + route.getId());
		}

		return res;
	}

	//Ancilliary methods

	private ModelAndView createEditModelAndView(final Reservation reservation) {
		ModelAndView result;

		result = this.createEditModelAndView(reservation, null);

		return result;
	}

	private ModelAndView createEditModelAndView(final Reservation reservation, final String message) {
		ModelAndView result;
		Route route;
		//		Collection<String> places;
		Collection<Reservation> routeAcceptedReservations;
		Integer remainingSeats;
		boolean routeLugNothing = false;
		boolean routeLugMedium = false;
		boolean routeLugBig = false;
		route = reservation.getRoute();

		//---Lista de strings de lugares por donde pasa la ruta---
		//		places = new ArrayList<String>();
		//		places.add(route.getOrigin());

		//	if (route.getControlPoints() != null && !route.getControlPoints().isEmpty())
		//	for (final ControlPoint c : route.getControlPoints())
		//		places.add(c.getLocation());
		//		places.add(route.getDestination());
		//-----------------------------------------------------
		switch (route.getMaxLuggage()) {
		case NOTHING:
			routeLugNothing = true;
			break;
		case MEDIUM:
			routeLugMedium = true;
			break;
		case BIG:
			routeLugBig = true;
			break;
		case SMALL:
			break;
		default:
			break;
		}
		//------------Asientos restantes--------------------
		routeAcceptedReservations = this.reservationService.findAcceptedReservationsByRoute(route.getId());
		remainingSeats = route.getAvailableSeats();
		for (final Reservation res : route.getReservations())
			if (res.getStatus().equals(ReservationStatus.ACCEPTED))
				remainingSeats = remainingSeats - res.getSeat();

		//Comprobamos que haya asientos disponibles
		Assert.isTrue(remainingSeats > 0);
		//------------------------------------------------------

		result = new ModelAndView("reservation/passenger/create");
		result.addObject("reservation", reservation);
		result.addObject("route", route);
		//		result.addObject("places", places);
		result.addObject("remainingSeats", remainingSeats);
		result.addObject("message", message);
		result.addObject("LugNothing", routeLugNothing);
		result.addObject("LugMedium", routeLugMedium);
		result.addObject("LugBig", routeLugBig);

		return result;
	}

}
