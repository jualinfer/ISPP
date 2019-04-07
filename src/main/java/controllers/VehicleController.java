
package controllers;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import services.ActorService;
import services.DriverService;
import services.VehicleService;
import domain.Actor;
import domain.Vehicle;

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

	@RequestMapping(value = "/list", method = RequestMethod.GET)
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

	}
}
