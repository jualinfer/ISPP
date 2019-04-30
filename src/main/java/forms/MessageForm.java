package forms;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

import domain.MessagesThread;


public class MessageForm {
	
	private MessagesThread thread;
	private String content;
	
	public MessageForm() {
		super();
	}

	@Valid
	@NotNull
	public MessagesThread getThread() {
		return thread;
	}

	@NotNull
	@NotBlank
	public String getContent() {
		return content;
	}
	
	public void setThread(MessagesThread thread) {
		this.thread = thread;
	}
	
	public void setContent(String content) {
		this.content = content;
	}

}
