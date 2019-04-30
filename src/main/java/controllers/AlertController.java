
package controllers;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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

}
