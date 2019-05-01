package controllers;

import java.util.Collection;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import services.ActorService;
import services.MessageService;
import services.MessagesThreadService;
import services.RouteService;
import domain.Actor;
import domain.Message;
import domain.MessagesThread;
import domain.Route;
import forms.MessageForm;
import forms.ThreadForm;

@Controller
@RequestMapping("/thread")
public class MessagesThreadController extends AbstractController {
	
	// Services ---------------------------------
	@Autowired
	private MessagesThreadService mtService;
	
	@Autowired
	private MessageService messageService;

	@Autowired
	private ActorService actorService;
	
	@Autowired
	private RouteService routeService;

	// Constructor ------------------------------
	public MessagesThreadController() {
		super();
	}
	
	// Messages ---------------------------------
	
	@RequestMapping(value = "/message/list", method = RequestMethod.GET)
	public ModelAndView messageThreadList() {
		Actor user = actorService.findByPrincipal();
		Collection<MessagesThread> threads = mtService.findMessagesThreadFromParticipant(user.getId());
		ModelAndView result = new ModelAndView("thread/message/list");
		result.addObject("threads", threads);
		result.addObject("connectedUser", user);
		return result;
	}
	
	@RequestMapping(value = "/message/view", method = RequestMethod.GET)
	public ModelAndView messageThreadView(@RequestParam final int threadId) {
		Assert.notNull(threadId);
		
		Actor sender = actorService.findByPrincipal();
		
		ModelAndView result;
		MessagesThread thread = mtService.findOne(threadId);
		if (thread != null && (thread.getParticipantA().getId() == sender.getId() ||
			thread.getParticipantB().getId() == sender.getId())) {
			result = addMessageThreadModelAndView(messageService.construct(thread), false);
		}
		else {
			// Error, redirigir a 403
			result = new ModelAndView("redirect:/misc/403.do");
		}
		return result;
	}
	
	@RequestMapping(value = "/message/create", method = RequestMethod.GET)
	public ModelAndView messageCreate(@RequestParam final int userId, @RequestParam final int routeId) {
		Assert.notNull(userId);
		Assert.notNull(routeId);
		
		Route route = routeService.findOne(routeId);
		Actor sender = actorService.findByPrincipal();
		Actor receiver = actorService.findOne(userId);
		
		ModelAndView result;
		if (receiver == null || route == null || receiver.getId() == sender.getId()) {
			// Error, redirigir a 403
			result = new ModelAndView("redirect:/misc/403.do");
		}
		else {
			MessagesThread thread = mtService.findMessagesThreadFromParticipantsAndRoute(route.getId(), sender.getId(), receiver.getId());
			if (thread == null) {
				// Redirigir a la vista de creación
				result = createThreadModelAndView(mtService.construct(route, receiver), false);
			}
			else {
				// Existe ya una conversación, redirigir al hilo en sí
				result = addMessageThreadModelAndView(messageService.construct(thread), false);
			}
		}
		return result;
	}
	
	@RequestMapping(value = "/message/create", method = RequestMethod.POST)
	public ModelAndView messageThreadCreate(@ModelAttribute(value = "threadForm") @Valid final ThreadForm threadForm, BindingResult binding) {
		ModelAndView result = null;
		if (binding.hasErrors()) {
			result = createThreadModelAndView(threadForm, false);
		}
		else {
			Actor sender = actorService.findByPrincipal();
			MessagesThread thread = mtService.findMessagesThreadFromParticipantsAndRoute(threadForm.getRoute().getId(), sender.getId(), threadForm.getUser().getId());
			if (thread == null && threadForm.getUser().getId() != sender.getId()) {
				try {
					thread = mtService.reconstruct(threadForm, sender, false);
					thread = mtService.saveNew(thread, threadForm.getMessage());
					result = addMessageThreadModelAndView(messageService.construct(thread), false);
				}
				catch (Throwable oops) {
					oops.printStackTrace();
					result = createThreadModelAndView(threadForm, false, "thread.commit.error");
				}
			}
			else {
				// Error, redirigir a 403
				result = new ModelAndView("redirect:/misc/403.do");
			}
		}
		return result;
	}
	
	@RequestMapping(value = "/message/add", method = RequestMethod.POST)
	public ModelAndView messageAdd(@ModelAttribute(value = "messageForm") @Valid final MessageForm messageForm, BindingResult binding) {
		ModelAndView result = null;
		if (binding.hasErrors()) {
			result = addMessageThreadModelAndView(messageForm, false);
		}
		else {
			Actor sender = actorService.findByPrincipal();
			try {
				Message message = messageService.reconstruct(messageForm, sender);
				message = messageService.save(message);
				result = addMessageThreadModelAndView(messageService.construct(message.getThread()), false);
			}
			catch (Throwable oops) {
				oops.printStackTrace();
				// Error, redirigir a 403
				result = new ModelAndView("redirect:/misc/403.do");
			}
		}
		return result;
	}
	
	// Reports ----------------------------------

	@RequestMapping(value = "/report/view", method = RequestMethod.GET)
	public ModelAndView reportThreadView(@RequestParam final int threadId) {
		Assert.notNull(threadId);
		
		Actor sender = actorService.findByPrincipal();
		
		ModelAndView result;
		MessagesThread thread = mtService.findOne(threadId);
		if (thread != null && (thread.getParticipantA().getId() == sender.getId() ||
			thread.getParticipantB().getId() == sender.getId())) {
			result = addMessageThreadModelAndView(messageService.construct(thread), true);
		}
		else {
			// Error, redirigir a 403
			result = new ModelAndView("redirect:/misc/403.do");
		}
		return result;
	}
	
	@RequestMapping(value = "/report/create", method = RequestMethod.GET)
	public ModelAndView reportCreate(@RequestParam final int userId, @RequestParam final int routeId) {
		Assert.notNull(userId);
		Assert.notNull(routeId);
		
		Actor reportingUser = actorService.findByPrincipal();
		Actor reportedUser = actorService.findOne(userId);
		Route route = routeService.findOne(routeId);
		
		ModelAndView result;
		if (reportedUser == null || route == null || reportingUser.getId() == reportedUser.getId()) {
			// Error, redirigir a 403
			result = new ModelAndView("redirect:/misc/403.do");
		}
		else {
			MessagesThread thread = mtService.findReportsThreadFromParticipantsAndRoute(route.getId(), reportingUser.getId(), reportedUser.getId());
			if (thread == null) {
				// Redirigir a la vista de creación
				result = createThreadModelAndView(mtService.construct(route, reportedUser), true);
			}
			else {
				// Existe ya un reporte, redirigir al hilo en sí
				result = null;
				result = addMessageThreadModelAndView(messageService.construct(thread), true);
			}
		}
		
		return result;
	}
	
	@RequestMapping(value = "/report/create", method = RequestMethod.POST)
	public ModelAndView reportThreadCreate(@ModelAttribute(value = "threadForm") @Valid final ThreadForm threadForm, BindingResult binding) {
		ModelAndView result = null;
		if (binding.hasErrors()) {
			result = createThreadModelAndView(threadForm, false);
		}
		else {
			Actor reportingUser = actorService.findByPrincipal();
			MessagesThread thread = mtService.findReportsThreadFromParticipantsAndRoute(threadForm.getRoute().getId(), reportingUser.getId(), threadForm.getUser().getId());
			if (thread == null && threadForm.getUser().getId() != reportingUser.getId()) {
				try {
					thread = mtService.reconstruct(threadForm, reportingUser, true);
					thread = mtService.saveNew(thread, threadForm.getMessage());
					result = addMessageThreadModelAndView(messageService.construct(thread), true);
				}
				catch (Throwable oops) {
					oops.printStackTrace();
					result = createThreadModelAndView(threadForm, false, "thread.commit.error");
				}
			}
			else {
				// Error, redirigir a 403
				result = new ModelAndView("redirect:/misc/403.do");
			}
		}
		return result;
	}
	
	// Ancillary Methods ---------------------------------------------------------------------
	
	private ModelAndView createThreadModelAndView(ThreadForm form, boolean isReport) {
		return createThreadModelAndView(form, isReport, null);
	}
	
	private ModelAndView createThreadModelAndView(ThreadForm form, boolean isReport, String message) {
		ModelAndView result;
		if (isReport) {
			result = new ModelAndView("thread/report/create");
			result.addObject("requestURI", "thread/report/create.do");
		}
		else {
			result = new ModelAndView("thread/message/create");
			result.addObject("requestURI", "thread/message/create.do");
		}
		result.addObject("threadForm", form);
		result.addObject("isReport", isReport);
		result.addObject("message", message);
		
		return result;
	}
	
	private ModelAndView addMessageThreadModelAndView(MessageForm form, boolean isReport) {
		return addMessageThreadModelAndView(form, isReport, null);
	}
	
	private ModelAndView addMessageThreadModelAndView(MessageForm form, boolean isReport, String message) {
		MessagesThread thread = form.getThread();
		// Cuando se accede a una conversación que tiene nuevos mensajes para el usuario conectado,
		// se tiene que actualizar el número de nuevos mensajes a cero en dicha conversación en el
		// momento que se accede a la misma
		int newMessages = thread.getNewMessages();
		if (thread.getNewMessages() > 0) {
			Actor user = actorService.findByPrincipal();
			if ((thread.getLastMessage().getFromAtoB() && user.getId() == thread.getParticipantB().getId()) ||
				(!thread.getLastMessage().getFromAtoB() && user.getId() == thread.getParticipantA().getId())) {
				thread = mtService.updateReadNewMessages(thread);
			}
		}
		ModelAndView result;
		if (isReport) {
			result = new ModelAndView("thread/report/view");
			result.addObject("requestURI", "thread/report/add.do");
		}
		else {
			result = new ModelAndView("thread/message/view");
			result.addObject("requestURI", "thread/message/add.do");
		}
		result.addObject("thread", thread);
		result.addObject("newMessages", newMessages);
		result.addObject("messageForm", form);
		result.addObject("isReport", isReport);
		result.addObject("message", message);
		
		return result;
	}

}
