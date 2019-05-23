
package forms;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Range;

import domain.Route;

public class CommentForm {

	public CommentForm() {
		super();
	}


	private Route	route;
	private String	text;
	private Double	star;


	@NotNull
	@Valid
	public Route getRoute() {
		return this.route;
	}

	public void setRoute(Route route) {
		this.route = route;
	}

	@NotBlank
	public String getText() {
		return this.text;
	}

	@NotNull
	@Range(min = 0, max = 5)
	public Double getStar() {
		return this.star;
	}

	public void setStar(Double star) {
		this.star = star;
	}

	public void setText(String text) {
		this.text = text;
	}

}
