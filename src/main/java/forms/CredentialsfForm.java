
package forms;

import javax.validation.constraints.Min;

import org.hibernate.validator.constraints.NotBlank;

public class CredentialsfForm {

	public CredentialsfForm() {
		super();
	}

	private int	id;
	private String  password;
	private String  repeatPassword;

	@Min(0)
	public int getId() {
		return this.id;
	}
	public void setId(final int id) {
		this.id = id;
	}
	
	@NotBlank
	public String getRepeatPassword() {
		return repeatPassword;
	}
	public void setRepeatPassword(String repeatPassword) {
		this.repeatPassword = repeatPassword;
	}
	
	@NotBlank
	public String getPassword() {
		return password;
	}

	@NotBlank
	public void setPassword(String password) {
		this.password = password;
	}

}
