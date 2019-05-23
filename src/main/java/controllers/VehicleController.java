
package controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import services.ActorService;
import services.DriverService;
import services.VehicleService;

@Controller
@RequestMapping("/vehicle")
public class VehicleController extends AbstractController {

	// Services ---------------------------------------------------------------
	@Autowired
	private DriverService	driverService;
	@Autowired
	private ActorService	actorService;
	@Autowired
	private VehicleService	vehicleService;


	// Constructors -----------------------------------------------------------
	public VehicleController() {
		super();
	}

	// Listing -------------------------------------

	/*@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView list(@RequestParam final int driverId) {
		ModelAndView result;
		final Collection<Vehicle> vehicles;
		Actor principal;

		principal = this.actorService.findByPrincipal();
		vehicles = this.vehicleService.findVehiclesByDriver(driverId);

		result = new ModelAndView("vehicle/list");
		result.addObject("vehicles", vehicles);
		result.addObject("principal", principal);
		result.addObject("driverId", driverId);
		result.addObject("requestURI", "vehicle/list.do");

		return result;

	}*/
}
