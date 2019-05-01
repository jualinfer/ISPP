
package services;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import repositories.CommentRepository;
import domain.Actor;
import domain.Comment;
import domain.Driver;
import domain.Passenger;
import domain.Route;
import forms.CommentForm;

@Service
@Transactional
public class CommentService {

	//managed repository
	@Autowired
	private CommentRepository	commentRepository;

	//Supporting Services
	@Autowired
	private ActorService		actorService;

	@Autowired
	private PassengerService	passengerService;

	@Autowired
	private DriverService		driverService;


	//CRUD 
	public Comment create() {
		Comment result;

		result = new Comment();

		return result;
	}

	public Comment findOne(int commentId) {
		Assert.isTrue(this.commentRepository.exists(commentId));

		Comment result;

		result = this.commentRepository.findOne(commentId);

		return result;

	}

	public Collection<Comment> findAll() {
		Collection<Comment> result;

		result = this.commentRepository.findAll();

		return result;
	}

	public Comment save(Comment comment) {
		this.validateComment(comment);

		Comment result;
		Driver driver;
		Passenger passenger;

		result = this.commentRepository.save(comment);

		// Update actor average Stars
		if (result.getFromDriver()) {
			passenger = result.getPassenger();
			passenger.getComments().add(result);
			passenger.setMediumStars(this.avgStarsFromPassenger(passenger.getId()));
			this.passengerService.save(passenger);

		} else {
			driver = result.getDriver();
			driver.getComments().add(result);
			driver.setMediumStars(this.avgStarsFromDriver(driver.getId()));
			this.driverService.save(driver);

		}

		return result;
	}

	private Double avgStarsFromDriver(int driverId) {
		Double res;

		res = this.commentRepository.avgStarsFromDriver(driverId);

		return res;
	}

	private Double avgStarsFromPassenger(int passengerId) {

		Double res;

		res = this.commentRepository.avgStarsFromPassenger(passengerId);

		return res;

	}

	public void validateComment(Comment comment) {
		Assert.notNull(comment);
		Driver driver;
		Collection<Passenger> passengers;
		Actor actor;

		// El driver y el passenger se deben corresponder con los de la ruta que aparezca en el comment
		driver = comment.getRoute().getDriver();
		passengers = this.passengerService.findPassengersAcceptedByRoute(comment.getRoute().getId());

		Assert.isTrue(driver.getId() == comment.getDriver().getId());
		Assert.isTrue(passengers.contains(comment.getPassenger()));

		actor = this.actorService.findByPrincipal();

		if (comment.getFromDriver()) {
			// Es un comentario que escribe el conductor de la ruta a un passenger de la misma
			Assert.isTrue(actor.getId() == comment.getDriver().getId());
			Assert.isNull(this.findCommentFromDriver(comment.getRoute().getId(), comment.getPassenger().getId(), actor.getId()));
		} else {
			// Es un comentario que escribe un passenger de la ruta al driver de la misma
			Assert.isTrue(passengers.contains(actor));
			Assert.isNull(this.findCommentFromPassenger(comment.getRoute().getId(), actor.getId(), comment.getDriver().getId()));
		}

	}

	public Collection<Comment> findCommentsMadeByPassenger(int passengerId) {
		Collection<Comment> result;

		result = this.commentRepository.findCommentsMadeByPassenger(passengerId);

		return result;
	}

	public Collection<Comment> findCommentsMadeByDriver(int driverId) {
		Collection<Comment> result;

		result = this.commentRepository.findCommentsMadeByDriver(driverId);

		return result;
	}

	public Collection<Comment> findCommentsMadeToPassenger(int passengerId) {
		Collection<Comment> result;

		result = this.commentRepository.findCommentsMadeToPassenger(passengerId);

		return result;
	}

	public Collection<Comment> findCommentsMadeToDriver(int driverId) {
		Collection<Comment> result;

		result = this.commentRepository.findCommentsMadeToDriver(driverId);

		return result;
	}

	public Comment findCommentFromDriver(int routeId, int passengerId, int driverId) {
		Comment result;

		result = this.commentRepository.findCommentFromDriver(routeId, passengerId, driverId);

		return result;
	}

	public Comment findCommentFromPassenger(int routeId, int passengerId, int driverId) {
		Comment result;

		result = this.commentRepository.findCommentFromPassenger(routeId, passengerId, driverId);

		return result;
	}

	public boolean canComment(Actor actor, Route route) {
		boolean result = false;
		Collection<Passenger> passengers;

		// Primero comprobamos si estamos en el rango de tiempo en el que se permitiría comentar para esta ruta:
		// Es decir, la ruta ha comenzado y ha pasado el tiempo estimado de la misma. Además no han pasado 24 horas desde ese momento.

		Calendar now = Calendar.getInstance();
		now.setTime(new Date());

		Calendar routeCommentPeriodStart = Calendar.getInstance();
		routeCommentPeriodStart.setTime(route.getDepartureDate());
		routeCommentPeriodStart.add(Calendar.MINUTE, route.getEstimatedDuration());

		if (now.before(routeCommentPeriodStart))
			return result;

		// Reutilizamos esta variable y ahora sería el fin del periodo:
		routeCommentPeriodStart.add(Calendar.HOUR, 24);

		if (now.after(routeCommentPeriodStart))
			return result;

		// Si se llega hasta aquí, le está permitido comentar, faltaria ver si es alguien de los passengers con reservations aceptadas o el driver
		if (actor instanceof Driver) {
			if (route.getDriver().getId() == actor.getId())
				result = true;
		} else {

			passengers = this.passengerService.findPassengersAcceptedByRoute(route.getId());
			if (passengers.contains(actor))
				// En caso de ser un pasenger, además comprobaremos si ya ha comentado o no a este driver para esta ruta
				if (this.findCommentFromPassenger(route.getId(), actor.getId(), route.getDriver().getId()) == null)
					result = true;
		}

		return result;
	}

	public Collection<Passenger> passengersToComment(Driver driver, int routeId) {
		Collection<Passenger> aux, result;
		result = new ArrayList<Passenger>();

		aux = this.passengerService.findPassengersAcceptedByRoute(routeId);

		for (Passenger passenger : aux)
			if (this.findCommentFromDriver(routeId, passenger.getId(), driver.getId()) == null)
				result.add(passenger);

		return result;
	}

	public Comment reconstruct(CommentForm commentForm, Integer passengerId) {
		Assert.notNull(commentForm);

		Comment result;
		Actor actor;

		result = new Comment();

		result.setRoute(commentForm.getRoute());
		result.setText(commentForm.getText());
		result.setStar(commentForm.getStar());
		result.setDate(new Date());
		result.setDriver(commentForm.getRoute().getDriver());

		actor = this.actorService.findByPrincipal();

		if (passengerId != null) {
			result.setPassenger(this.passengerService.findOne(passengerId));
			result.setFromDriver(true);
		} else {
			result.setPassenger((Passenger) actor);
			result.setFromDriver(false);
		}

		return result;

	}
}
