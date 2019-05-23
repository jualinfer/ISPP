package services;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import repositories.MessageRepository;
import domain.Actor;
import domain.Message;
import domain.MessagesThread;
import forms.MessageForm;

@Service
@Transactional
public class MessageService {
	
	//Managed repository
	
	@Autowired
	private MessageRepository messageRepository;
	
	//Supporting services
	
	@Autowired
	private MessagesThreadService mtService;
	
	
	public Message save(Message message) {
		Message result = messageRepository.saveAndFlush(message);
		mtService.updateLastMessage(result);
		return result;
	}
	
	public MessageForm construct(MessagesThread thread) {
		MessageForm result = new MessageForm();
		result.setThread(thread);
		return result;
	}
	
	public Message reconstruct(MessageForm form, Actor sender) {
		Message result = new Message();
		if (sender.getId() == form.getThread().getParticipantA().getId()) {
			result.setFromAtoB(true);
		}
		else if (sender.getId() == form.getThread().getParticipantB().getId()){
			result.setFromAtoB(false);
		}
		else {
			Assert.isTrue(false, "Sender is not a participant of the thread.");
		}
		result.setThread(form.getThread());
		result.setContent(form.getContent());
		result.setIssueDate(new Date());
		return result;
	}

}
