
package controllers.driver;

import java.util.Collection;
import java.util.Date;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import security.LoginService;
import security.UserAccount;
import services.ActorService;
import services.RouteService;
import controllers.AbstractController;
import domain.Driver;
import domain.Route;

@Controller
@RequestMapping("/route/driver")
public class RouteDriverController extends AbstractController {

	// Services ---------------------------------------------------------------
	@Autowired
	private ActorService	actorService;
	@Autowired
	private RouteService	routeService;


	// Constructors -----------------------------------------------------------
	public RouteDriverController() {
		super();
	}

	// Listing -------------------------------------
	@RequestMapping(value = "/listActive", method = RequestMethod.GET)
	public ModelAndView listActiveRoutesByDriver() {
		ModelAndView result;
		Collection<Route> routes;
		Driver driver;
		UserAccount ua;

		ua = LoginService.getPrincipal();
		driver = (Driver) this.actorService.findByUserAccount(ua);
		Assert.notNull(driver);

		routes = this.routeService.findActiveRoutesByDriver(driver.getId(), new Date());

		result = new ModelAndView("route/list");
		result.addObject("routes", routes);
		result.addObject("driver", driver);
		result.addObject("requestURI", "route/driver/listActive.do");

		return result;
	}

	// Creation ---------------------------------------------------------------

	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public ModelAndView create() {
		ModelAndView result;
		Route route;

		route = this.routeService.create();

		result = this.createEditModelAndView(route);

		return result;
	}

	// Edition ---------------------------------------------------------------

	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public ModelAndView edit(@RequestParam final int routeId) {
		final ModelAndView result;
		Route route;

		route = this.routeService.findOne(routeId);
		Assert.notNull(route);
		result = this.createEditModelAndView(route);

		return result;
	}

	@RequestMapping(value = "/create", method = RequestMethod.POST, params = "save")
	public ModelAndView save(@Valid final Route route, final BindingResult binding) {
		Route saved;

		if (route.getId() != 0)
			Assert.isTrue(route.getDriver().getId() == this.actorService.findByPrincipal().getId());

		ModelAndView result;
		for (final ObjectError oe : binding.getAllErrors())
			System.out.println(oe);
		if (binding.hasErrors()) {
			System.out.println(binding.getAllErrors());
			result = this.createEditModelAndView(route);
		} else
			try {
				saved = this.routeService.save2(route, binding);
				if (binding.hasErrors()) {
					System.out.println(binding.getAllErrors());
					result = this.createEditModelAndView(route);
				}
				result = new ModelAndView("redirect:/route/driver/confirmRoute.do?routeId=" + saved.getId());
			} catch (final Throwable oops) {
				oops.printStackTrace();
				result = this.createEditModelAndView(route, "driver.commit.error");
			}
		return result;
	}

	@RequestMapping(value = "/cancel", method = RequestMethod.GET)
	public ModelAndView cancel(@RequestParam final int routeId) {
		ModelAndView result;
		Route route;

		route = this.routeService.findOne(routeId);
		try {
			this.routeService.cancel(route);
			result = new ModelAndView("redirect:/route/driver/listActive.do");
		} catch (final Throwable oops) {
			oops.printStackTrace();
			result = this.routeDisplayModelAndView(route, "driver.cancel.error");
		}

		return result;
	}

	// Delete/Confirm route ---------------------------------------------------------------

	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public ModelAndView delete(final Route route) {
		ModelAndView result;

		try {
			this.routeService.delete(route);
			result = new ModelAndView("redirect:create.do");
		} catch (final Throwable oops) {
			result = this.createEditModelAndView(route, "route.commit.error");
		}
		return result;
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST, params = "delete")
	public ModelAndView delete(final Route route, final BindingResult binding) {
		ModelAndView result;
		for (final ObjectError oe : binding.getAllErrors())
			System.out.println(oe);
		try {
			this.routeService.delete(route);
			result = new ModelAndView("redirect:list.do");
		} catch (final Throwable oops) {
			result = this.createEditModelAndView(route, "route.commit.error");
		}
		return result;
	}

	@RequestMapping(value = "/confirmRoute", method = RequestMethod.GET)
	public ModelAndView confirmRoute(@RequestParam final int routeId) {
		ModelAndView result;
		Route route;
		final Driver driver;
		UserAccount ua;

		ua = LoginService.getPrincipal();
		driver = (Driver) this.actorService.findByUserAccount(ua);
		Assert.notNull(driver);

		route = this.routeService.findOne(routeId);

		result = new ModelAndView("route/driver/confirmRoute");
		result.addObject("route", route);
		result.addObject("requestURI", "route/driver/confirmRoute.do");

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

		requestURI = "route/driver/create.do";
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
