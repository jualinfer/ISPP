
package services;

import java.util.ArrayList;
import java.util.Collection;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import repositories.AdministratorRepository;
import security.Authority;
import security.UserAccount;
import security.UserAccountService;
import domain.Administrator;

@Service
@Transactional
public class AdministratorService {

	//managed repository
	@Autowired
	private AdministratorRepository	administratorRepository;

	//Supporting Services
	@Autowired
	private ActorService			actorService;
	@Autowired
	private UserAccountService		userAccountService;


	//CRUD

	public Administrator create() {
		final Administrator result;
		UserAccount ua;
		Authority authority;
		Collection<Authority> authorities;

		ua = this.userAccountService.create();
		ua.setUsername("");
		ua.setPassword("");
		ua.setEnabled(true);
		authority = new Authority();
		authority.setAuthority(Authority.ADMIN);
		authorities = new ArrayList<Authority>();
		authorities.add(authority);
		ua.setAuthorities(authorities);

		result = new Administrator();
		result.setUserAccount(ua);

		return result;
	}

	public Administrator findOne(final int adminId) {
		Administrator result;

		result = this.administratorRepository.findOne(adminId);

		return result;
	}

	public Collection<Administrator> findAll() {
		Collection<Administrator> result;

		result = this.administratorRepository.findAll();

		return result;
	}

	public Administrator save(final Administrator admin) {
		Assert.notNull(admin);

		Administrator result;

		result = (Administrator) this.actorService.save(admin);

		return result;
	}
	
	public Administrator saveUpdateNotifications(Administrator admin) {
		return (Administrator) actorService.save(admin);
	}

}
