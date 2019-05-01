
package controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import services.ActorService;
import services.RouteService;

@Controller
@RequestMapping("/controlpoint")
public class ControlPointController extends AbstractController {

	// Services ---------------------------------------------------------------
	@Autowired
	private ActorService	actorService;
	@Autowired
	private RouteService	routeService;
	@Autowired
	private RouteController routeController;


	// Constructors -----------------------------------------------------------
	public ControlPointController() {
		super();
	}
	
	

	/*
	 * // Listing -------------------------------------
	 * 
	 * @RequestMapping(value = "/list", method = RequestMethod.GET)
	 * public ModelAndView list() {
	 * ModelAndView result;
	 * Collection<Route> routes;
	 * 
	 * routes = this.routeService.findAll();
	 * 
	 * result = new ModelAndView("route/list");
	 * result.addObject("routes", routes);
	 * result.addObject("requestURI", "route/list.do");
	 * 
	 * return result;
	 * 
	 * }
	 * 
	 * @RequestMapping(value = "/display", method = RequestMethod.POST, params = "save")
	 * public ModelAndView save(@RequestParam final int routeID) {
	 * 
	 * ModelAndView result;
	 * Route route;
	 * 
	 * route = this.routeService.findOne(routeID);
	 * Assert.notNull(route);
	 * result = new ModelAndView("route/display");
	 * 
	 * result.addObject("route", route);
	 * 
	 * return result;
	 * }
	 * 
	 * @RequestMapping(value = "/search", method = RequestMethod.GET)
	 * public ModelAndView searchView() {
	 * final ModelAndView result;
	 * Finder finder;
	 * 
	 * finder = new Finder();
	 * result = new ModelAndView("route/search");
	 * result.addObject("finder", finder);
	 * 
	 * return result;
	 * }
	 * 
	 * @RequestMapping(value = "/search", method = RequestMethod.POST)
	 * public ModelAndView searchResult(@Valid Finder finder, BindingResult bindingResult) {
	 * ModelAndView result;
	 * Collection<Route> routes;
	 * 
	 * // routes = this.routeService.searchRoutes(finder);
	 * routes = this.routeService.findAll();
	 * 
	 * result = new ModelAndView("route/searchResults");
	 * result.addObject("routes", routes);
	 * 
	 * return result;
	 * }
	 */
}
