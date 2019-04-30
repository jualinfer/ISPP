
package controllers;

import java.util.Collection;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import services.ActorService;
import services.AlertService;
import domain.Alert;

@Controller
@RequestMapping("alert")
public class AlertController extends AbstractController {

	//Services

	@Autowired
	private AlertService	alertService;

	@Autowired
	private ActorService	actorService;


	//Listing all actor alerts

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView list(@RequestParam(required = false) final int actorId) {
		final ModelAndView result;
		final Collection<Alert> alerts;

		alerts = this.alertService.listByActor(actorId);

		result = new ModelAndView("alert/list");
		result.addObject("alerts", alerts);
		result.addObject("requestURI", "alert/list.do");

		return result;
	}
	//Delete
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public ModelAndView delete(@RequestParam final int varId) {
		final ModelAndView result;
		Alert alert;
		Collection<Alert> alerts;

		alert = this.alertService.findOne(varId);

		this.alertService.delete(alert);

		result = new ModelAndView("alert/list");

		alerts = this.alertService.listByActor(this.actorService.findByPrincipal().getId());

		result.addObject("alerts", alerts);
		result.addObject("requestURI", "alert/actor/list");

		return result;
	}

	// Edit -------------------------------------

	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public ModelAndView edit(@RequestParam final int alertId) {
		ModelAndView result;
		Alert alert;

		alert = this.alertService.findOne(alertId);

		result = this.createEditModelAndView(alert);

		return result;
	}

	//Save--------------------------------

	@RequestMapping(value = "/edit", method = RequestMethod.POST, params = "save")
	public ModelAndView save(@Valid final Alert alert, final BindingResult binding) {
		ModelAndView result;
		Alert saved;

		for (final ObjectError asd : binding.getAllErrors())
			System.out.println(asd);

		if (binding.hasErrors())
			result = this.createEditModelAndView(alert);
		else
			try {
				saved = this.alertService.save(alert);
				result = new ModelAndView("redirect:/alert/driver/list.do");
			} catch (final Throwable oops) {
				oops.printStackTrace();
				result = this.createEditModelAndView(alert, "alert.commit.error");
			}

		return result;
	}
	//Seen
	@RequestMapping(value = "/alertSeen", method = RequestMethod.GET)
	public ModelAndView alertSeen(@RequestParam final int varId) {
		final ModelAndView result;
		Alert alert;
		Collection<Alert> alerts;

		alert = this.alertService.findOne(varId);

		this.alertService.alertSeen(alert);

		result = new ModelAndView("alert/list");

		alerts = this.alertService.listByActor(this.actorService.findByPrincipal().getId());

		result.addObject("alerts", alerts);
		result.addObject("requestURI", "alert/actor/list");

		return result;
	}
	//Ancilliary methods

	private ModelAndView createEditModelAndView(final Alert alert) {
		ModelAndView result;

		result = this.createEditModelAndView(alert, null);

		return result;
	}

	private ModelAndView createEditModelAndView(final Alert alert, final String message) {
		ModelAndView result;

		result = new ModelAndView("alert/administrator/edit");
		result.addObject("alert", alert);
		result.addObject("message", message);

		return result;
	}
}
