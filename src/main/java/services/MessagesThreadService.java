package services;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import repositories.MessagesThreadRepository;
import domain.Actor;
import domain.Administrator;
import domain.Message;
import domain.MessagesThread;
import domain.Route;
import forms.ThreadForm;

@Service
@Transactional
public class MessagesThreadService {
	
	//Managed repository
	
	@Autowired
	private MessagesThreadRepository mtRepository;
	
	//Supporting services
	
	@Autowired
	private MessageService messageService;
	
	@Autowired
	private AdministratorService administratorService;
	
	@Autowired
	private ActorService actorService;
	
	public MessagesThread saveNew(MessagesThread thread, String messageContent) {
		MessagesThread result = mtRepository.saveAndFlush(thread);
		Message message = new Message();
		message.setThread(result);
		message.setFromAtoB(true);
		message.setContent(messageContent);
		message.setIssueDate(new Date());
		message = messageService.save(message);
//		Collection<Message> messages = new ArrayList<Message>();
//		messages.add(message);
//		result.setMessages(messages);
		return result;
	}
	
	public MessagesThread updateLastMessage(Message lastMessage) {
		MessagesThread thread = lastMessage.getThread(); 
		thread.setLastMessage(lastMessage);
		thread.setNewMessages(thread.getNewMessages() + 1);
		Actor user = actorService.findByPrincipal();
		if (user.getNewMessages() == null) {
			user.setNewMessages(0);
		}
		user.setNewMessages(user.getNewMessages() + 1);
		user = actorService.save(user);
		if (thread.getMessages() == null) {
			Collection<Message> messages = new ArrayList<Message>();
			messages.add(lastMessage);
			thread.setMessages(messages);
		}
		else {
			boolean found = false;
			for(Message m : thread.getMessages()) {
				if (m.getId() == lastMessage.getId()) {
					found = true;
					break;
				}
			}
			if (!found) {
				thread.getMessages().add(lastMessage);
			}
		}
		return mtRepository.saveAndFlush(thread);
	}
	
	public MessagesThread updateReadNewMessages(MessagesThread thread) {
		Actor user = actorService.findByPrincipal();
		if (user.getNewMessages() == null) {
			user.setNewMessages(0);
		}
		user.setNewMessages(user.getNewMessages() - thread.getNewMessages());
		user = actorService.save(user);
		thread.setNewMessages(0);
		return mtRepository.saveAndFlush(thread);
	}
	
	public MessagesThread findOne(int threadId) {
		return mtRepository.findOne(threadId);
	}
	
	public MessagesThread findMessagesThreadFromParticipantsAndRoute(int routeId, int participant1Id, int participant2Id) {
		return mtRepository.findMessagesThreadFromParticipantsAndRoute(routeId, participant1Id, participant2Id);
	}

	public Collection<MessagesThread> findMessagesThreadFromParticipant(int participantId) {
		return mtRepository.findMessagesThreadFromParticipant(participantId);
	}
	
	public ThreadForm construct(Route route, Actor user) {
		ThreadForm result = new ThreadForm();
		result.setRoute(route);
		result.setUser(user);
		return result;
	}
	
	public MessagesThread reconstruct(ThreadForm form, Actor participantA, boolean isReport) {
		MessagesThread result = new MessagesThread();
		result.setRoute(form.getRoute());
		result.setParticipantA(participantA);
		if (isReport) {
			Collection<Administrator> admins = administratorService.findAll();
			if (!admins.isEmpty()) {
				for (Administrator admin : admins) {
					result.setParticipantB(admin);
				}
				result.setReportedUser(form.getUser());
			}
			else {
				throw new IllegalStateException("There is no admin account");
			}
		}
		else {
			result.setParticipantB(form.getUser());
		}
		result.setNewMessages(0);
		result.setClosed(false);
		return result;
	}

}
