/*
 * AdministratorController.java
 * 
 * Copyright (C) 2019 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the
 * TDG Licence, a copy of which you may download from
 * http://www.tdg-seville.info/License.html
 */

package controllers;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import security.UserAccount;
import services.ActorService;
import services.ReservationService;
import services.RouteService;
import domain.Actor;
import domain.Administrator;
import domain.Driver;
import domain.Passenger;
import domain.Reservation;
import domain.ReservationStatus;
import domain.Route;

@Controller
@RequestMapping("/administrator")
public class AdministratorController extends AbstractController {

	@Autowired
	private ActorService		actorService;

	@Autowired
	private RouteService		routeService;

	@Autowired
	private ReservationService	reservationService;


	// Constructors -----------------------------------------------------------

	public AdministratorController() {
		super();
	}

	@RequestMapping(value = "/controlPanel", method = RequestMethod.GET)
	public ModelAndView controlPanel() {
		final ModelAndView result = new ModelAndView("administrator/controlPanel");

		return result;
	}

	//Ban users

	@RequestMapping(value = "/ban", method = RequestMethod.GET)
	public ModelAndView ban(@RequestParam final int userId) {

		ModelAndView result;
		Actor actor;
		Driver driver;
		Passenger passenger;

		actor = this.actorService.findOne(userId);
		if (!(actor instanceof Administrator)) {

			final UserAccount ua = actor.getUserAccount();

			try {

				if (actor instanceof Driver) { //Si el actor baneado es un Driver, se le cancelan las rutas activas que no hayan empezado...

					driver = (Driver) actor;
					for (final Route r : this.routeService.findActiveRoutesByDriver(driver.getId(), new Date()))
						this.routeService.cancel(r);
				} else { //Por el contrario, si es un Passenger, se le cancela las Reservatios de las rutas activas...

					passenger = (Passenger) actor;
					for (final Route r : this.routeService.findActiveRoutesByPassenger(passenger.getId()))
						for (final Reservation re : this.reservationService.findReservationsByRouteAndPassenger(r.getId(), passenger.getId())) {
							re.setStatus(ReservationStatus.CANCELLED);
							this.reservationService.save2(re);
						}
				}

				ua.setBanned(true);
				actor.setUserAccount(ua);
				this.actorService.save(actor);

				result = new ModelAndView("redirect:/thread/report/list.do");
			} catch (final Throwable e) {
				e.printStackTrace();
				result = new ModelAndView("redirect:/thread/report/list.do");
			}
		} else
			result = new ModelAndView("redirect:/thread/report/list.do");
		return result;
	}

	// Action-1 ---------------------------------------------------------------

	@RequestMapping("/action-1")
	public ModelAndView action1() {
		ModelAndView result;

		result = new ModelAndView("administrator/action-1");

		return result;
	}

	// Action-2 ---------------------------------------------------------------

	@RequestMapping("/action-2")
	public ModelAndView action2() {
		ModelAndView result;

		result = new ModelAndView("administrator/action-2");

		return result;
	}

}
