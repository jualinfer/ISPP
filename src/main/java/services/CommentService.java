
package services;

import java.util.Collection;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import repositories.CommentRepository;
import security.UserAccountService;
import domain.Comment;
import domain.Driver;
import domain.Passenger;

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
	private UserAccountService	userAccountService;

	@Autowired
	private PassengerService	passengerService;


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

		result = this.save(comment);

		return result;
	}

	public void validateComment(Comment comment) {
		Assert.notNull(comment);
		Driver driver;
		Collection<Passenger> passengers;

		// El driver y el passenger se deben corresponder con los de la ruta que aparezca en el comment
		driver = comment.getRoute().getDriver();
		passengers = this.passengerService.findPassengersAcceptedByRoute(comment.getRoute().getId());

		Assert.isTrue(driver.getId() == comment.getDriver().getId());
		Assert.isTrue(passengers.contains(comment.getPassenger()));

		if (comment.getFromDriver()) {
			// Es un comentario que escribe el conductor de la ruta a un passenger de la misma
			Assert.isTrue(this.actorService.findByPrincipal().getId() == comment.getDriver().getId());
		} else {
			// Es un comentario que escribe un passenger de la ruta a un driver de la misma
			Assert.isTrue(passengers.contains(this.actorService.findByPrincipal()));
		}

		// TODO: terminar
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
}
