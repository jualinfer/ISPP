
package services;

import java.util.Collection;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import repositories.ActorRepository;
import security.LoginService;
import security.UserAccount;
import security.UserAccountService;
import domain.Actor;

@Service
@Transactional
public class ActorService {

	//Managed Repositories
	@Autowired
	private ActorRepository	actorRepository;
	
	@Autowired
	private UserAccountService uaService;


	// Supported Services ---------------------------------

	//Constructor

	public ActorService() {
		super();
	}

	//CRUD Methods

	public Actor findOne(final int actorId) {
		Assert.isTrue(actorId != 0);

		Actor result;

		result = this.actorRepository.findOne(actorId);

		return result;
	}

	public Collection<Actor> findAll() {
		Collection<Actor> result;

		result = this.actorRepository.findAll();

		return result;
	}

	public Actor save(final Actor actor) {
		Assert.notNull(actor);
		Assert.notNull(actor.getName());
		Assert.notNull(actor.getSurname());

		final Actor result;

		//Tenemos que comprobar si el actor es nuevo, o lo estamos editando

		//Si es nuevo...
		if (actor.getId() == 0) {
			UserAccount userAccount;
			userAccount = actor.getUserAccount();

			Assert.notNull(userAccount.getUsername());
			Assert.notNull(userAccount.getPassword());

			result = this.actorRepository.save(actor);
			
			userAccount = result.getUserAccount();
			
			if (userAccount != null && userAccount.getActor() == null) {
				userAccount.setActor(result);
				userAccount = uaService.save(userAccount);
			}
		} else {
			final UserAccount principal, userAccount;
			final UserAccount savedUserAccount;
			final Md5PasswordEncoder encoder;

			//			principal = LoginService.getPrincipal();
			//			userAccount = actor.getUserAccount();
			//
			//			Assert.notNull(principal); //Comprobamos que hay un Actor logeado en el sistema, que puede o no ser el mismo que queremos guardar

			//savedUserAccount = this.userAccountService.save(userAccount);
			//Assert.notNull(savedUserAccount);
			result = this.actorRepository.save(actor);
		}

		this.actorRepository.flush();

		return result;
	}

	// Complex business rules -----------------------------

	public Actor findByUserAccount(final UserAccount userAccount) {
		Assert.notNull(userAccount);

		Actor result;

		result = this.actorRepository.findByUserAccount(userAccount);

		return result;
	}

	public Actor findByPrincipal() {
		final UserAccount userAccount = LoginService.getPrincipal();
		Assert.notNull(userAccount);
		final Actor a = this.actorRepository.findByUserAccountId(userAccount.getId());
		return a;
	}

}
