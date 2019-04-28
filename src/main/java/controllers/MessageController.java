package controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import services.ActorService;
import services.MessageService;


@Controller
@RequestMapping("/thread")
public class MessageController extends AbstractController {
	
	// Services ---------------------------------
	@Autowired
	private MessageService messageService;
	
	@Autowired
	private ActorService actorService;

	// Constructor ------------------------------
	public MessageController() {
		super();
	}

}
