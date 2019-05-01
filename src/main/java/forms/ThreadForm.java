package forms;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

import domain.Actor;
import domain.Route;


public class ThreadForm {
	
	private Route route;
	private Actor user;
	private String message;
	
	public ThreadForm() {
		super();
	}
	
	@Valid
	@NotNull
	public Route getRoute() {
		return route;
	}
	
	@Valid
	@NotNull
	public Actor getUser() {
		return user;
	}

	@NotNull
	@NotBlank
	public String getMessage() {
		return message;
	}
	
	public void setRoute(Route route) {
		this.route = route;
	}
	
	public void setUser(Actor user) {
		this.user = user;
	}
	
	public void setMessage(String message) {
		this.message = message;
	}

}
