
package controllers;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import security.LoginService;
import security.UserAccount;
import services.ActorService;
import services.ReservationService;
import services.RouteService;
import domain.Actor;
import domain.Administrator;
import domain.Driver;
import domain.Finder;
import domain.Passenger;
import domain.Reservation;
import domain.ReservationStatus;
import domain.Route;

@Controller
@RequestMapping("/route")
public class RouteController extends AbstractController {

	// Services ---------------------------------------------------------------
	@Autowired
	private RouteService		routeService;
	@Autowired
	private ReservationService	reservationService;

	@Autowired
	private ActorService		actorService;


	// Constructors -----------------------------------------------------------
	public RouteController() {
		super();
	}

	// Listing -------------------------------------
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView list() {
		ModelAndView result;
		Collection<Route> routes;

		routes = this.routeService.findAll();

		result = new ModelAndView("route/list");
		result.addObject("routes", routes);
		result.addObject("requestURI", "route/list.do");

		return result;

	}

	// Display ---------------------------------------------------------------

	@RequestMapping(value = "/display", method = RequestMethod.GET)
	public ModelAndView display(@RequestParam final int routeId) {
		ModelAndView result;
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

		route = this.routeService.findOne(routeId);
		Assert.notNull(route);
		result = new ModelAndView("route/display");
		//		reservation = this.reservationService.create();
		//		reservation.setRoute(route);
		//		reservation.setPrice(route.getPricePerPassenger());
		//		reservation.setLuggageSize(LuggageSize.NOTHING);
		//		reservation.setStatus(ReservationStatus.PENDING);

		reservations = route.getReservations();
		displayableReservations = new ArrayList<Reservation>();
		occupiedSeats = 0;
		ua = LoginService.getPrincipal();
		actor = this.actorService.findByUserAccount(ua);
		Assert.notNull(actor);

		if (actor instanceof Driver) {
			final Driver driver = (Driver) actor;
			if (route.getDriver().equals(driver))
				rol = 1;
		}
		if (reservations != null && reservations.size() > 0)
			for (final Reservation res : reservations) {
				if (res.getStatus().equals(ReservationStatus.ACCEPTED)) {
					occupiedSeats = occupiedSeats + res.getSeat();	//TODO: NO SE TENIA EN CUENTA EL Nº DE ASIENTOS POR RESERVA	//Contamos asientos ocupados
					displayableReservations.add(res);	//añadimos las reservas aceptadas
				}
				if (actor instanceof Driver) {
					final Driver driver = (Driver) actor;
					if (route.getDriver().equals(driver)) {				//Si el conductor logeado es el de la ruta...
						rol = 1;							//...se considerará como "conductor de la ruta"...
						if (route.getDepartureDate().after(new Date()))	// ...y además si la ruta no ha empezado...
							if (res.getStatus().equals(ReservationStatus.PENDING))
								displayableReservations.add(res);	//...añadimos tambien reservas pendientes
					}
				}

				if (actor instanceof Passenger) {					//Si el actor logueado es pasajero...
					final Passenger passenger = (Passenger) actor;
					for (final Reservation r : reservations)
						//...y ha hecho alguna reserva en la ruta
						if (r.getPassenger().equals(passenger)) {
							rol = 2;		//...se considerara como "pasajero con reserva" 
							result.addObject("reservation", r);
							if (route.getDepartureDate().before(new Date()))
								startedRoute = true;
							break;
						} else
							rol = 3;
					//reservation.setPassenger(passenger);
				}

				if (actor instanceof Administrator)
					rol = 4;
			}
		else if (actor instanceof Passenger)
			//final Passenger passenger = (Passenger) actor;
			rol = 3;

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
		result.addObject("rol", rol);
		//		result.addObject("newReservation", reservation);
		result.addObject("startedRoute", startedRoute);
		result.addObject("hasPassed10Minutes", hasPassed10Minutes);
		result.addObject("hasPassed20Minutes", arrivalPlus10Min);

		return result;
	}
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public ModelAndView searchView() {
		final ModelAndView result;
		Finder finder;

		finder = new Finder();
		result = new ModelAndView("route/search");
		result.addObject("finder", finder);

		return result;
	}

	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public ModelAndView searchResult(@Valid final Finder finder, final BindingResult bindingResult) {
		ModelAndView result;
		Collection<Route> routes;

		try {
			routes = this.routeService.searchRoutes(finder);
			result = new ModelAndView("route/searchResults");
			result.addObject("routes", routes);

		} catch (final Throwable oops) {
			oops.printStackTrace();
			result = this.searchView();
			result.addObject(finder);
		}

		return result;
	}

	// Ancilliary methods ----------------------------------------------------------------
	private ModelAndView createEditModelAndView(final Route route) {
		ModelAndView result;

		result = this.createEditModelAndView(route, null);

		return result;
	}

	private ModelAndView createEditModelAndView(final Route route, final String message) {
		ModelAndView result;
		String requestURI;

		final Driver driver = (Driver) this.actorService.findByPrincipal();

		requestURI = "route/driver/edit.do";
		result = new ModelAndView("route/driver/create");
		result.addObject("route", route);
		result.addObject("vehicles", driver.getVehicles());
		result.addObject("message", message);
		result.addObject("requestURI", requestURI);

		return result;
	}

	private ModelAndView routeDisplayModelAndView(final Route route, final String message) {
		ModelAndView result;
		String requestURI;

		requestURI = "route/display.do";
		result = new ModelAndView("route/display");
		result.addObject("route", route);
		result.addObject("message", message);
		result.addObject("requestURI", requestURI);

		return result;
	}

}
