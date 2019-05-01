package services;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import repositories.MessagesThreadRepository;
import security.UserAccount;
import security.UserAccountService;
import domain.Actor;
import domain.Message;
import domain.MessagesThread;
import domain.Reservation;
import domain.ReservationStatus;
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
	private DriverService driverService;
	
	@Autowired
	private PassengerService passengerService;
	
	@Autowired
	private ActorService actorService;
	
	@Autowired
	private UserAccountService uaService;
	
	@Autowired
	private RouteService routeService;
	
	/*public boolean validMessageData(Actor sendingUser, Actor receivingUser, Route route) {
		boolean result = false;
		if (sendingUser.getId() != receivingUser.getId()) {
			MessagesThread reportThread = mtRepository.findMessagesThreadFromParticipantsAndRoute(route.getId(), sendingUser.getId(), receivingUser.getId());
			if (reportThread == null) {
				if (route.getDepartureDate().before(new Date())) {
					// La ruta ya comenzó
				}
				else {
					// La ruta aún no ha empezado
					if (receivingUser.getId() == route.getDriver().getId()) {
						result = true;
					}
					else {
						
					}
				}
			}
		}
		else {
			result = true;
		}
		return result;
	}*/
	
	public MessagesThread saveNew(MessagesThread thread, String messageContent) {
		MessagesThread result = mtRepository.saveAndFlush(thread);
		Message message = new Message();
		message.setThread(result);
		message.setFromAtoB(true);
		message.setContent(messageContent);
		message.setIssueDate(new Date());
		message = messageService.save(message);
		return result;
	}
	
	public MessagesThread updateLastMessage(Message lastMessage) {
		MessagesThread thread = lastMessage.getThread(); 
		thread.setLastMessage(lastMessage);
		thread.setNewMessages(thread.getNewMessages() + 1);
		Actor currentUser = actorService.findByPrincipal();
		Actor user = null;
		if (currentUser.getId() == thread.getParticipantA().getId()) {
			user = thread.getParticipantB();
		}
		else {
			user = thread.getParticipantA();
		}		
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
	
	// REPORTS ----------------------------------------------------------------------------------
	
	public MessagesThread findReportsThreadFromParticipantsAndRoute(int routeId, int reportingUserId, int reportedUserId) {
		return mtRepository.findReportsThreadFromParticipantsAndRoute(routeId, reportingUserId, reportedUserId);
	}
	
	public Collection<MessagesThread> findReportsThreadFromParticipant(int participantId) {
		return mtRepository.findReportsThreadFromParticipant(participantId);
	}
	
	/*public boolean validReportData(Actor reportingUser, Actor reportedUser, Route route) {
		boolean result = false;
		if (reportingUser.getId() != reportedUser.getId()) {
			MessagesThread reportThread = mtRepository.findReportsThreadFromParticipantsAndRoute(route.getId(), reportingUser.getId(), reportedUser.getId());
			if (reportThread == null) {
				Date finishDate = new Date(route.getDepartureDate().getTime() + route.getEstimatedDuration() * 60000);
				if (finishDate.before(new Date())) {
					if (reportingUser.getId() == route.getDriver().getId()) {
						for (Reservation reservation : route.getReservations()) {
							if (reservation.getPassenger().getId() == reportedUser.getId()) {
								result = true;
								break;
							}
						}
					}
					else if (reportedUser.getId() == route.getDriver().getId()) {
						for (Reservation reservation : route.getReservations()) {
							if (reservation.getPassenger().getId() == reportingUser.getId()) {
								result = true;
								break;
							}
						}
					}
				}
			}
		}
		else {
			result = true;
		}
		return result;
	}*/
	
	public boolean canReport(Actor user, Route route) {
		boolean result = false;
//		Date finishDate = new Date(route.getDepartureDate().getTime() + route.getEstimatedDuration() * 60000);
//		Date maxDate = new Date(finishDate.getTime());
		
		Calendar now = Calendar.getInstance();
		now.setTime(new Date());
		
		Calendar finishDate = Calendar.getInstance();
		finishDate.setTime(route.getDepartureDate());
		finishDate.add(Calendar.MINUTE, route.getEstimatedDuration());
		
		Calendar maxDate = Calendar.getInstance();
		maxDate.setTime(route.getDepartureDate());
		maxDate.add(Calendar.MINUTE, route.getEstimatedDuration());
		maxDate.add(Calendar.HOUR, 24);
		
		if (now.after(finishDate) && now.before(maxDate)) {
			if (user.getId() == route.getDriver().getId()) {
				result = true;
			}
			else {
				for (Reservation r : route.getReservations()) {
					if (r.getStatus() == ReservationStatus.ACCEPTED && r.getPassenger().getId() == user.getId()) {
						result = true;
						break;
					}
				}
			}
		}
		return result;
	}
	
	public MessagesThread closeAndSaveReport(MessagesThread thread, boolean refund) {
		thread.setClosed(true);
		Actor driver, passenger;
		if (thread.getReportedUser().getId() == thread.getRoute().getDriver().getId()) {
			driver = thread.getReportedUser();
			passenger = thread.getParticipantA();
		}
		else {
			driver = thread.getParticipantA();
			passenger = thread.getReportedUser();
		}
		if (refund) {
			// TODO Hay que devolver el dinero al passenger
		}
		else {
			// TODO Hay que hacerle la transferencia al driver 
		}
		thread = mtRepository.saveAndFlush(thread);
		return thread;
	}
	
	// CONSTRUCT & RECONSTRUCT --------------------------------------------------------------
	
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
			UserAccount adminAccount = uaService.findByUsername("admin@gmail.com");
			if (adminAccount != null) {
				Actor admin = actorService.findByUserAccount(adminAccount);
				if (admin != null) {
					result.setParticipantB(admin);
					result.setReportedUser(form.getUser());
				}
				else {
					throw new IllegalStateException("There is an admin account but not an admin actor");
				}
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
