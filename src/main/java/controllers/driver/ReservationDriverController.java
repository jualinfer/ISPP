/*
 * ReservationController.java
 * 
 * Copyright (C) 2019 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the
 * TDG Licence, a copy of which you may download from
 * http://www.tdg-seville.info/License.html
 */

package controllers.driver;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import services.ReservationService;
import services.RouteService;
import utilities.StripeConfig;

import com.stripe.Stripe;
import com.stripe.model.Refund;

import controllers.AbstractController;
import domain.Reservation;
import domain.Route;

@Controller
@RequestMapping("/reservation/driver")
public class ReservationDriverController extends AbstractController {

	@Autowired
	private ReservationService	reservationService;
	@Autowired
	private RouteService		routeService;


	// Constructor --------------------------------------------------------
	public ReservationDriverController() {
		super();
	}

	// Accept Reservation ---------------------------------------------------------------

	@RequestMapping(value = "/acceptReservation", method = RequestMethod.POST, params = "acceptReservation")
	//, params = "acceptReservation")
	public ModelAndView acceptReservation(@RequestParam(defaultValue = "0") final int reservationId) {
		ModelAndView res;
		final Reservation reservation = this.reservationService.findOne(reservationId);
		final Route route = reservation.getRoute();

		try {
			this.reservationService.acceptReservation(reservationId);
			res = new ModelAndView("redirect:/route/display.do?routeId=" + route.getId());

		} catch (final Exception e) {
			res = new ModelAndView("redirect:/route/display.do?routeId=" + route.getId());
		}

		return res;
	}

	// Reject Reservation ---------------------------------------------------------------

	@RequestMapping(value = "/rejectReservation", method = RequestMethod.POST, params = "rejectReservation")
	public ModelAndView rejectReservation(@RequestParam(defaultValue = "0") final int reservationId) {
		ModelAndView res;
		final Reservation reservation = this.reservationService.findOne(reservationId);
		final Route route = this.routeService.findOne(reservation.getRoute().getId());

		try {
			if (reservation.getChargeId() != null) {
				Stripe.apiKey = StripeConfig.SECRET_KEY;

				final Map<String, Object> params = new HashMap<>();
				params.put("charge", reservation.getChargeId());
				final Refund refund = Refund.create(params);
			}
			this.reservationService.rejectReservation(reservationId);
			res = new ModelAndView("redirect:/route/display.do?routeId=" + route.getId());

		} catch (final Exception e) {
			e.printStackTrace();
			res = new ModelAndView("redirect:/route/display.do?routeId=" + route.getId());
		}

		return res;
	}

}
