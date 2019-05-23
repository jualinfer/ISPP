
package forms;

import javax.validation.constraints.Min;

public class FormObject {

	public FormObject() {
		super();
	}


	private int	id;


	@Min(0)
	public int getId() {
		return this.id;
	}

	public void setId(final int id) {
		this.id = id;
	}

}
