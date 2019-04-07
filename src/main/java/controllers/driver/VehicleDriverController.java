
package controllers.driver;

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

import services.ActorService;
import services.DriverService;
import services.VehicleService;
import controllers.AbstractController;
import domain.Actor;
import domain.Driver;
import domain.Vehicle;

@Controller
@RequestMapping("/vehicle/driver")
public class VehicleDriverController extends AbstractController {

	// Services ---------------------------------------------------------------
	@Autowired
	private ActorService	actorService;
	@Autowired
	private DriverService	driverService;
	@Autowired
	private VehicleService	vehicleService;


	// Constructors -----------------------------------------------------------
	public VehicleDriverController() {
		super();
	}

	// Create -------------------------------------

	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public ModelAndView create() {
		ModelAndView result;
		Actor principal;
		Driver driver;
		Vehicle vehicle;

		principal = this.actorService.findByPrincipal();
		Assert.isTrue(principal instanceof Driver);
		driver = (Driver) principal;

		vehicle = this.vehicleService.create();
		vehicle.setDriver(driver);

		result = this.createEditModelAndView(vehicle);

		return result;
	}

	// Edit -------------------------------------

	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public ModelAndView edit(@RequestParam final int vehicleId) {
		ModelAndView result;
		Actor principal;
		Vehicle vehicle;

		vehicle = this.vehicleService.findOne(vehicleId);
		principal = this.actorService.findByPrincipal();
		Assert.isTrue(principal instanceof Driver && principal.getId() == vehicle.getDriver().getId());

		result = this.createEditModelAndView(vehicle);

		return result;
	}

	//Save--------------------------------

	@RequestMapping(value = "/edit", method = RequestMethod.POST, params = "save")
	public ModelAndView save(@Valid final Vehicle vehicle, final BindingResult binding) {
		ModelAndView result;
		Driver driver;
		Vehicle saved;

		for (final ObjectError asd : binding.getAllErrors())
			System.out.println(asd);

		if (binding.hasErrors())
			result = this.createEditModelAndView(vehicle);
		else
			try {
				saved = this.vehicleService.save(vehicle);
				driver = saved.getDriver();
				result = new ModelAndView("redirect:/vehicle/list.do?driverId=" + driver.getId());
			} catch (final Throwable oops) {
				oops.printStackTrace();
				result = this.createEditModelAndView(vehicle, "vehicle.commit.error");
			}

		return result;
	}

	// Edit Photo-------------------------------------

	//	@RequestMapping(value = "/editPhoto", method = RequestMethod.GET)
	//	public ModelAndView editPhoto(@RequestParam final int vehicleId) {
	//		ModelAndView result;
	//		Actor principal;
	//		final Driver driver;
	//		Vehicle vehicle;
	//
	//		vehicle = this.vehicleService.findOne(vehicleId);
	//		principal = this.actorService.findByPrincipal();
	//		Assert.isTrue(principal instanceof Driver && principal.getId() == vehicle.getDriver().getId());
	//
	//		result = new ModelAndView("vehicle/driver/editPhoto");
	//		result.addObject("vehicle", vehicle);
	//		return result;
	//	}
	//
	//	//Save Photo--------------------------------
	//
	//	@RequestMapping(value = "/editPhoto", method = RequestMethod.POST, params = "save")
	//	public ModelAndView savePhoto(@Valid final Vehicle vehicle, final BindingResult binding) {
	//		ModelAndView result;
	//
	//		for (final ObjectError asd : binding.getAllErrors())
	//			System.out.println(asd);
	//
	//		if (binding.hasErrors())
	//			result = this.createEditModelAndView(vehicle);
	//		else
	//			try {
	//				this.vehicleService.savePhoto(vehicle);
	//				result = new ModelAndView("redirect:edit.do?vehicleId=" + vehicle.getId());
	//			} catch (final Throwable oops) {
	//				oops.printStackTrace();
	//				result = new ModelAndView("redirect:editPhoto.do?vehicleId=" + vehicle.getId());
	//				result.addObject("message", "vehicle.commit.error");
	//			}
	//
	//		return result;
	//	}

	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public ModelAndView delete(@RequestParam final int vehicleId) {
		ModelAndView result;
		Driver driver;
		Vehicle vehicle;

		vehicle = this.vehicleService.findOne(vehicleId);
		driver = vehicle.getDriver();

		this.vehicleService.delete(vehicle);
		result = new ModelAndView("redirect:/vehicle/list.do?driverId=" + driver.getId());

		return result;

	}

	//Ancilliary methods

	private ModelAndView createEditModelAndView(final Vehicle vehicle) {
		ModelAndView result;

		result = this.createEditModelAndView(vehicle, null);

		return result;
	}

	private ModelAndView createEditModelAndView(final Vehicle vehicle, final String message) {
		ModelAndView result;

		result = new ModelAndView("vehicle/driver/edit");
		result.addObject("vehicle", vehicle);
		result.addObject("message", message);
		result.addObject("driver", vehicle.getDriver());

		return result;
	}

}
