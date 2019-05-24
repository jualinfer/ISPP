
package controllers;

import java.util.Collection;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import security.UserAccount;
import services.ActorService;
import services.CommentService;
import services.PassengerService;
import services.ReservationService;
import services.RouteService;
import domain.Actor;
import domain.Comment;
import domain.Passenger;
import domain.Reservation;
import domain.ReservationStatus;
import domain.Route;
import forms.CredentialsfForm;

@Controller
@RequestMapping("/passenger")
public class PassegerController extends AbstractController {

	// Services ---------------------------------
	@Autowired
	private PassengerService	passengerService;

	@Autowired
	private ActorService		actorService;

	@Autowired
	private RouteService		routeService;

	@Autowired
	private ReservationService	reservationService;

	@Autowired
	private CommentService		commentService;


	// Constructor ------------------------------
	public PassegerController() {
		super();
	}

	// Displaying -------------------------------
	@RequestMapping(value = "/display", method = RequestMethod.GET)
	public ModelAndView display(@RequestParam final int passengerId) {
		Assert.notNull(passengerId);

		ModelAndView result;
		Passenger passenger;
		Collection<Comment> comments;

		passenger = this.passengerService.findOne(passengerId);
		comments = this.commentService.findCommentsMadeToPassenger(passengerId);
		result = new ModelAndView("passenger/display");
		result.addObject("passenger", passenger);
		result.addObject("comments", comments);

		return result;
	}

	@RequestMapping(value = "/displayPrincipal", method = RequestMethod.GET)
	public ModelAndView displayPrincipal() {
		ModelAndView result;
		Passenger passenger;
		Actor principal;
		Collection<Comment> comments;

		principal = this.actorService.findByPrincipal();
		Assert.isTrue(principal instanceof Passenger);
		passenger = (Passenger) principal;
		comments = this.commentService.findCommentsMadeToPassenger(passenger.getId());
		result = new ModelAndView("passenger/display");
		result.addObject("passenger", passenger);
		result.addObject("passengerConnected", passenger);
		result.addObject("comments", comments);
		result.addObject("isPrincipal", true);

		return result;
	}

	// Creation -----------------------------------------------------------
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public ModelAndView create() {
		ModelAndView result;
		Passenger passenger;

		passenger = this.passengerService.create();

		result = this.createEditModelAndView(passenger, "passenger/create");

		return result;
	}

	@RequestMapping(value = "/create", method = RequestMethod.POST, params = "save")
	public ModelAndView save2(@Valid final Passenger passenger, final BindingResult binding) {
		ModelAndView result;
		UserAccount userAccount;
		if (binding.hasErrors()) {
			System.out.println(binding.getAllErrors().toString());
			result = this.createEditModelAndView(passenger, "passenger/create");
		} else
			try {
				userAccount = super.hashSavePassword(passenger.getUserAccount());
				passenger.setUserAccount(userAccount);
				this.passengerService.save(passenger);
				result = new ModelAndView("redirect:/security/login.do");
			}
			catch (IllegalArgumentException ex) {
				result = this.createEditModelAndView(passenger, "passenger/create", "passenger.error.email");
			}
			catch (final Throwable oops) {
				result = this.createEditModelAndView(passenger, "passenger/create", "passenger.commit.error");
			}
		return result;
	}
	// Edition -----------------------------------------------------------
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public ModelAndView edit() {
		ModelAndView result;
		Passenger passenger;
		String requestURI;

		requestURI = "passenger/edit.do";
		passenger = (Passenger) this.actorService.findByPrincipal();

		result = this.createEditModelAndView(passenger, "passenger/edit");
		result.addObject("requestURI", requestURI);
		return result;
	}
	@RequestMapping(value = "/edit", method = RequestMethod.POST, params = "save")
	public ModelAndView save(final Passenger passenger, final BindingResult binding) {
		ModelAndView result;

		Passenger passengerReconstruct;

		passengerReconstruct = this.passengerService.reconstruct(passenger, binding);

		if (binding.hasErrors()) {
			System.out.println(binding.getAllErrors());
			result = this.createEditModelAndView(passenger, "passenger/edit");
		} else
			try {
				this.passengerService.save(passengerReconstruct);
				result = new ModelAndView("redirect:/passenger/display.do?passengerId=" + passengerReconstruct.getId());
			} catch (final Throwable oops) {
				result = this.createEditModelAndView(passenger, "passenger.commit.error");
			}
		return result;
	}

	// Edition Credentials-----------------------------------------------------------
	@RequestMapping(value = "/editCredentials", method = RequestMethod.GET)
	public ModelAndView editCredentials() {
		ModelAndView res = null;

		final Passenger passenger = (Passenger) this.actorService.findByPrincipal();
		final CredentialsfForm credentialsfForm = this.passengerService.constructCredential(passenger);

		res = this.createEditModelAndViewEditCredentials(credentialsfForm);
		res.addObject("credentialsfForm", credentialsfForm);

		return res;
	}

	@RequestMapping(value = "/editCredentials", method = RequestMethod.POST, params = "save")
	public ModelAndView editCredentials(@Valid final CredentialsfForm credentialsfForm, final BindingResult binding) {
		ModelAndView res;
		Passenger passenger;

		if (binding.hasErrors())
			res = this.createEditModelAndViewEditCredentials(credentialsfForm, "passenger.params.error");
		else if (!credentialsfForm.getRepeatPassword().equals(credentialsfForm.getPassword()))
			res = this.createEditModelAndViewEditCredentials(credentialsfForm, "passenger.commit.errorPassword");
		else
			try {
				passenger = this.passengerService.reconstructCredential(credentialsfForm, binding);
				this.passengerService.saveCredentials(passenger);
				res = new ModelAndView("redirect:/j_spring_security_logout");
			} catch (final Throwable oops) {
				res = this.createEditModelAndViewEditCredentials(credentialsfForm, "passenger.commit.error");
			}

		return res;
	}

	//Darse de baja

	@RequestMapping(value = "/unsubscribe", method = RequestMethod.GET)
	public ModelAndView unsubscribe() {

		ModelAndView result;
		Passenger passenger;
		Passenger passengerLogged;
		Actor principal;

		principal = this.actorService.findByPrincipal();
		Assert.isTrue(principal instanceof Passenger);
		passenger = (Passenger) principal;
		passengerLogged = (Passenger) this.actorService.findByPrincipal();

		if (passenger.equals(passengerLogged)) {

			final UserAccount ua = passenger.getUserAccount();

			try {

				for (final Route r : this.routeService.findActiveRoutesByPassenger(passenger.getId()))
					for (final Reservation re : this.reservationService.findReservationsByRouteAndPassenger(r.getId(), passenger.getId())) {
						re.setStatus(ReservationStatus.CANCELLED);
						this.reservationService.save2(re);
					}

				ua.setEnabled(false);
				passenger.setUserAccount(ua);
				passenger.setName("deleted");
				passenger.setSurname("deleted");
				passenger.setCountry("deleted");
				passenger.setCity("deleted");
				passenger.setBankAccountNumber("ES7748382522549520946697");
				passenger.setCash(0.0);
				passenger.setMediumStars(0.0);
				passenger.setPhone("600000000");
				passenger.setImage("https://cdn.pixabay.com/photo/2016/03/10/16/33/icons-1248706_960_720.png");
				this.passengerService.save(passenger);

				result = new ModelAndView("redirect:/j_spring_security_logout");
			} catch (final Throwable e) {
				e.printStackTrace();
				result = new ModelAndView("redirect:/passenger/displayPrincipal.do");
			}
		} else
			result = new ModelAndView("redirect:/passenger/displayPrincipal.do");
		return result;
	}

	// Ancilliary methods -----------------------------------------------------------
	private ModelAndView createEditModelAndView(final Passenger passenger, final String model) {
		ModelAndView result;

		result = this.createEditModelAndView(passenger, model, null);

		return result;

	}

	private ModelAndView createEditModelAndView(final Passenger passenger, final String model, final String message) {
		ModelAndView result;

		result = new ModelAndView(model);
		result.addObject("passenger", passenger);
		result.addObject("message", message);

		return result;
	}

	protected ModelAndView createEditModelAndViewEditCredentials(final CredentialsfForm credentialsfForm) {
		ModelAndView result;

		result = this.createEditModelAndViewEditCredentials(credentialsfForm, null);

		return result;
	}

	protected ModelAndView createEditModelAndViewEditCredentials(final CredentialsfForm credentialsfForm, final String message) {
		ModelAndView result;

		result = new ModelAndView("passenger/editCredentials");
		result.addObject("credentialsfForm", credentialsfForm);
		result.addObject("message", message);
		result.addObject("requestURI", "passenger/editCredentials.do");

		return result;
	}

}
