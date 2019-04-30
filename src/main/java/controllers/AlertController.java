
package controllers;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import services.AlertService;
import domain.Alert;

@Controller
@RequestMapping("alert")
public class AlertController extends AbstractController {

	//Services

	@Autowired
	private AlertService	alertService;


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

}
