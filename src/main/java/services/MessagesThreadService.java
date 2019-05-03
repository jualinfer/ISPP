
package services;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import repositories.MessagesThreadRepository;
import security.UserAccount;
import security.UserAccountService;
import utilities.StripeConfig;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Payout;
import com.stripe.model.Refund;

import domain.Actor;
import domain.Message;
import domain.MessagesThread;
import domain.Passenger;
import domain.Reservation;
import domain.ReservationStatus;
import domain.Route;
import forms.ThreadForm;

@Service
@Transactional
public class MessagesThreadService {

	//Managed repository

	@Autowired
	private MessagesThreadRepository	mtRepository;

	//Supporting services

	@Autowired
	private MessageService				messageService;

	@Autowired
	private AdministratorService		administratorService;

	@Autowired
	private DriverService				driverService;

	@Autowired
	private PassengerService			passengerService;

	@Autowired
	private ActorService				actorService;

	@Autowired
	private UserAccountService			uaService;

	@Autowired
	private RouteService				routeService;
	
	@Autowired
	private ReservationService			reservationService;


	/*
	 * public boolean validMessageData(Actor sendingUser, Actor receivingUser, Route route) {
	 * boolean result = false;
	 * if (sendingUser.getId() != receivingUser.getId()) {
	 * MessagesThread reportThread = mtRepository.findMessagesThreadFromParticipantsAndRoute(route.getId(), sendingUser.getId(), receivingUser.getId());
	 * if (reportThread == null) {
	 * if (route.getDepartureDate().before(new Date())) {
	 * // La ruta ya comenzó
	 * }
	 * else {
	 * // La ruta aún no ha empezado
	 * if (receivingUser.getId() == route.getDriver().getId()) {
	 * result = true;
	 * }
	 * else {
	 *
	 * }
	 * }
	 * }
	 * }
	 * else {
	 * result = true;
	 * }
	 * return result;
	 * }
	 */

	public MessagesThread saveNew(final MessagesThread thread, final String messageContent) {
		final MessagesThread result = this.mtRepository.saveAndFlush(thread);
		Message message = new Message();
		message.setThread(result);
		message.setFromAtoB(true);
		message.setContent(messageContent);
		message.setIssueDate(new Date());
		message = this.messageService.save(message);
		return result;
	}

	public MessagesThread updateLastMessage(final Message lastMessage) {
		final MessagesThread thread = lastMessage.getThread();
		thread.setLastMessage(lastMessage);
		thread.setNewMessages(thread.getNewMessages() + 1);
		final Actor currentUser = this.actorService.findByPrincipal();
		Actor user = null;
		if (currentUser.getId() == thread.getParticipantA().getId())
			user = thread.getParticipantB();
		else
			user = thread.getParticipantA();
		if (user.getNewMessages() == null)
			user.setNewMessages(0);
		user.setNewMessages(user.getNewMessages() + 1);
		user = this.actorService.save(user);
		if (thread.getMessages() == null) {
			final Collection<Message> messages = new ArrayList<Message>();
			messages.add(lastMessage);
			thread.setMessages(messages);
		} else {
			boolean found = false;
			for (final Message m : thread.getMessages())
				if (m.getId() == lastMessage.getId()) {
					found = true;
					break;
				}
			if (!found)
				thread.getMessages().add(lastMessage);
		}
		return this.mtRepository.saveAndFlush(thread);
	}

	public MessagesThread updateReadNewMessages(final MessagesThread thread) {
		Actor user = this.actorService.findByPrincipal();
		if (user.getNewMessages() == null)
			user.setNewMessages(0);
		user.setNewMessages(user.getNewMessages() - thread.getNewMessages());
		user = this.actorService.save(user);
		thread.setNewMessages(0);
		return this.mtRepository.saveAndFlush(thread);
	}

	public MessagesThread findOne(final int threadId) {
		return this.mtRepository.findOne(threadId);
	}

	public MessagesThread findMessagesThreadFromParticipantsAndRoute(final int routeId, final int participant1Id, final int participant2Id) {
		return this.mtRepository.findMessagesThreadFromParticipantsAndRoute(routeId, participant1Id, participant2Id);
	}

	public Collection<MessagesThread> findMessagesThreadFromParticipant(final int participantId) {
		return this.mtRepository.findMessagesThreadFromParticipant(participantId);
	}

	// REPORTS ----------------------------------------------------------------------------------
	
	public Collection<MessagesThread> findReportsThreadFromParticipant(int participantId) {
		return mtRepository.findReportsThreadFromParticipant(participantId);
	}

	public MessagesThread findReportsThreadFromParticipantsAndRoute(final int routeId, final int reportingUserId, final int reportedUserId) {
		return this.mtRepository.findReportsThreadFromParticipantsAndRoute(routeId, reportingUserId, reportedUserId);
	}
	
	public Collection<MessagesThread> findReportsThreadFromRoute(int routeId) {
		Collection<MessagesThread> res = new ArrayList<MessagesThread>();
		res.addAll(mtRepository.findReportsThreadFromRoute(routeId));
		return res;
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

	public boolean canReport(final Actor user, final Route route) {
		boolean result = false;
		//		Date finishDate = new Date(route.getDepartureDate().getTime() + route.getEstimatedDuration() * 60000);
		//		Date maxDate = new Date(finishDate.getTime());

		final Calendar now = Calendar.getInstance();
		now.setTime(new Date());

		final Calendar finishDate = Calendar.getInstance();
		finishDate.setTime(route.getDepartureDate());
		finishDate.add(Calendar.MINUTE, route.getEstimatedDuration());

		final Calendar maxDate = Calendar.getInstance();
		maxDate.setTime(route.getDepartureDate());
		maxDate.add(Calendar.MINUTE, route.getEstimatedDuration());
		maxDate.add(Calendar.HOUR, 24);

		if (now.after(finishDate) && now.before(maxDate))
			if (user.getId() == route.getDriver().getId())
				result = true;
			else
				for (final Reservation r : route.getReservations())
					if (r.getStatus() == ReservationStatus.ACCEPTED && r.getPassenger().getId() == user.getId()) {
						result = true;
						break;
					}
		return result;
	}

	public MessagesThread closeAndSaveReport(MessagesThread thread, final boolean refund) {
		thread.setClosed(true);
		Actor driver, passenger;
		if (thread.getReportedUser().getId() == thread.getRoute().getDriver().getId()) {
			driver = thread.getReportedUser();
			passenger = thread.getParticipantA();
		} else {
			driver = thread.getParticipantA();
			passenger = thread.getReportedUser();
		}
		if (refund) {
			// TODO Hay que devolver el dinero al passenger

			//Primero obtenemos la reserva en si para obtener su chargeId
			final Passenger passenger2 = (Passenger) passenger;
			Reservation currentReservation = null;

			for (final Reservation res : thread.getRoute().getReservations())
				if (passenger2.getReservations().contains(res)) {
					currentReservation = res;
					break;
				}

			//Como las reservas que ya están en BBDD no tienen chargeId comprobamos que no sea null (por tanto de momento solo funcionaria con reservas nuevas)
			if (currentReservation != null && currentReservation.getChargeId() != null)
				//Procedemos al rembolso
				try {
					Stripe.apiKey = StripeConfig.SECRET_KEY;
					final Map<String, Object> params = new HashMap<>();
					params.put("charge", currentReservation.getChargeId());
					final Refund refund2 = Refund.create(params);
					currentReservation.setPaymentResolved(true);
					currentReservation = reservationService.save2(currentReservation);
				} catch (final StripeException e) {
					e.printStackTrace();
				}
		} else {
			// TODO Hay que hacerle la transferencia al driver

			//Primero obtenemos la reserva en si para obtener su precio
			final Passenger passenger2 = (Passenger) passenger;
			Reservation currentReservation = null;

			for (final Reservation res : thread.getRoute().getReservations())
				if (passenger2.getReservations().contains(res)) {
					currentReservation = res;
					break;
				}

			try {
				Stripe.apiKey = StripeConfig.SECRET_KEY;
				//payout
				final Map<String, Object> payoutParams = new HashMap<String, Object>();
				final Double reservPrice = currentReservation.getPrice() * 100;
				payoutParams.put("amount", Integer.toString(reservPrice.intValue()));
				payoutParams.put("currency", StripeConfig.CURRENCY);
				//			payoutParams.put("destination", bankAccount.getId());
				Payout.create(payoutParams);
				currentReservation.setPaymentResolved(true);
				currentReservation = reservationService.save2(currentReservation);
			} catch (final StripeException e) {
				e.printStackTrace();
			}
		}
		thread = this.mtRepository.saveAndFlush(thread);
		return thread;
	}

	// CONSTRUCT & RECONSTRUCT --------------------------------------------------------------

	public ThreadForm construct(final Route route, final Actor user) {
		final ThreadForm result = new ThreadForm();
		result.setRoute(route);
		result.setUser(user);
		return result;
	}

	public MessagesThread reconstruct(final ThreadForm form, final Actor participantA, final boolean isReport) {
		final MessagesThread result = new MessagesThread();
		result.setRoute(form.getRoute());
		result.setParticipantA(participantA);
		if (isReport) {
			final UserAccount adminAccount = this.uaService.findByUsername("admin@gmail.com");
			if (adminAccount != null) {
				final Actor admin = this.actorService.findByUserAccount(adminAccount);
				if (admin != null) {
					result.setParticipantB(admin);
					result.setReportedUser(form.getUser());
				} else
					throw new IllegalStateException("There is an admin account but not an admin actor");
			} else
				throw new IllegalStateException("There is no admin account");
		} else
			result.setParticipantB(form.getUser());
		result.setNewMessages(0);
		result.setClosed(false);
		return result;
	}

}
