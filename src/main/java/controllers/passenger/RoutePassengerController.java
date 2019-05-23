
package controllers.passenger;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import security.LoginService;
import security.UserAccount;
import services.ActorService;
import services.RouteService;
import controllers.AbstractController;
import domain.Passenger;
import domain.Route;

@Controller
@RequestMapping("/route/passenger")
public class RoutePassengerController extends AbstractController {

	// Services ---------------------------------------------------------------
	@Autowired
	private ActorService	actorService;
	@Autowired
	private RouteService	routeService;


	// Constructors -----------------------------------------------------------
	public RoutePassengerController() {
		super();
	}

	// Listing active routes by driver-------------------------------------
	@RequestMapping(value = "/listActive", method = RequestMethod.GET)
	public ModelAndView listActiveRoutesByPassenger() {
		ModelAndView result;
		Collection<Route> routes;
		Passenger passenger;
		UserAccount ua;

		ua = LoginService.getPrincipal();
		passenger = (Passenger) this.actorService.findByUserAccount(ua);
		Assert.notNull(passenger);

		routes = this.routeService.findActiveRoutesByPassenger(passenger.getId());

		result = new ModelAndView("route/list");
		result.addObject("routes", routes);
		result.addObject("passenger", passenger);
		result.addObject("requestURI", "route/passenger/listActive.do");

		return result;
	}

}
