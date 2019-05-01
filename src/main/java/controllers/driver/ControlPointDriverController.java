
package controllers.driver;

import java.util.ArrayList;

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

import services.ActorService;
import services.ControlPointService;
import controllers.AbstractController;
import domain.ControlPoint;
import forms.ControlPointFormCreate;
import forms.RouteForm;

@Controller
@RequestMapping("/controlpoint/driver")
public class ControlPointDriverController extends AbstractController {

	// Services ---------------------------------------------------------------
	@Autowired
	private ActorService	actorService;

	@Autowired
	private ControlPointService controlPointService;
	@Autowired
	private RouteDriverController routeController;


	// Constructors -----------------------------------------------------------
	public ControlPointDriverController() {
		super();
	}

	@RequestMapping(value="/add", method=RequestMethod.POST)
	public ModelAndView add(@ModelAttribute(value="route") RouteForm routeForm, BindingResult binding) {
		ModelAndView result;
		if (binding.hasErrors()) {
			System.out.println("Binding errors on 'controlpoint.add': "+binding.getAllErrors());
		}
		
		if (routeForm.getControlpoints() == null) {
			routeForm.setControlpoints(new ArrayList<ControlPointFormCreate>());
		}
		
		ControlPointFormCreate cp = controlPointService.constructCreate(controlPointService.create(), null);
		cp.setArrivalOrder(routeForm.getControlpoints().size()+1);
		cp.setEstimatedTime(1);
		routeForm.getControlpoints().add(cp);
		routeForm.getDestination().setArrivalOrder(routeForm.getControlpoints().size()+1);
		
		result = routeController.createEditModelAndView(routeForm, null);
		
		return result;
	}
	
	@RequestMapping(value="/remove", method=RequestMethod.POST)
	public ModelAndView remove(@ModelAttribute(value="route") RouteForm routeForm, BindingResult binding,
		@RequestParam Integer index) {
		ModelAndView result;
		System.out.println("es index null?? "+index);
		System.out.println("es cp null?? "+Boolean.toString(routeForm.getControlpoints() == null));
		if (routeForm.getControlpoints() != null) {
			System.out.println("size: "+routeForm.getControlpoints().size());
		}
		if (index != null && index > -1 && routeForm.getControlpoints() != null &&
			routeForm.getControlpoints().size()-1 >= index) {
			ControlPointFormCreate  cp;
			for (int i = index; i < routeForm.getControlpoints().size() - 1; i++) {
				System.out.println("index: "+i);
				cp = routeForm.getControlpoints().get(i);
				System.out.println("index: "+i+" cp null?? "+Boolean.toString(cp == null));
				cp.setArrivalOrder(cp.getArrivalOrder() - 1);
			}
			routeForm.getControlpoints().remove((int)index);
			System.out.println("destination null?? "+Boolean.toString(routeForm.getDestination() == null));
			routeForm.getDestination().setArrivalOrder(routeForm.getDestination().getArrivalOrder() - 1);
		}
		
		result = routeController.createEditModelAndView(routeForm, null);
		
		return result;
	}
	
	// Creation ---------------------------------------------------------------
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public ModelAndView create(@RequestParam final int routeId) {
		ModelAndView result;
		ControlPoint controlpoint;
		
//		controlpoint = this.controlPointService.create(routeId);
		controlpoint = null;
		//Assert.isTrue(controlpoint.getRoute().getReservations().isEmpty());

		result = this.createEditModelAndView(controlpoint);

		return result;
	}
	

	@RequestMapping(value = "/edit", method = RequestMethod.POST, params = "save")
	public ModelAndView save(@Valid final ControlPoint controlpoint, final BindingResult binding) {
		
		Assert.isTrue(controlpoint.getRoute().getDriver().getId() == this.actorService.findByPrincipal().getId());
		
		
		ModelAndView result;		
		if (binding.hasErrors()){
			System.out.println(binding.getAllErrors());
			result = this.createEditModelAndView(controlpoint);
		}
		else{
			try {
				this.controlPointService.save(controlpoint);
				result = new ModelAndView("redirect:/controlpoint/list.do?routeId="+ controlpoint.getRoute().getId());
			} catch (final Throwable oops) {
				oops.printStackTrace();
				result = this.createEditModelAndView(controlpoint, "controlpoint.commit.error");
			}
		}
		return result;
	}

	// Ancilliary methods ----------------------------------------------------------------
	private ModelAndView createEditModelAndView(final ControlPoint controlpoint) {
		ModelAndView result;

		result = this.createEditModelAndView(controlpoint, null);

		return result;
	}

	private ModelAndView createEditModelAndView(final ControlPoint controlpoint, final String message) {
		ModelAndView result;
		String requestURI;

		requestURI = "controlpoint/driver/edit.do";
		result = new ModelAndView("controlpoint/driver/create");
		result.addObject("controlpoint", controlpoint);
		result.addObject("message", message);
		result.addObject("requestURI", requestURI);

		return result;
	}
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
