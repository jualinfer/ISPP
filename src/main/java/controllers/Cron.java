
package controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import services.ReservationService;
import services.RouteService;

@Configuration
@ComponentScan("com.lynas")
@EnableScheduling
public class Cron {

	@SuppressWarnings("resource")
	public static void main(String[] args) {
		new AnnotationConfigApplicationContext(Cron.class).getBean(Cron.class);
	}
}

@Component
class Scheduller {

	@Autowired
	private RouteService		routeService;

	@Autowired
	private ReservationService	reservationService;


	@Scheduled(cron = "0 0/30 * * * *")
	public void cronCompleteRoutes() {
		System.out.println("Entrando en cronCompleteRoutes");
		this.routeService.cronCompleteRoutes();
	}

	@Scheduled(cron = "0 0/30 * * * *")
	@Transactional
	public void cronRejectedRequest() {
		System.out.println("Entrando en cronRejectedRequest");
		this.reservationService.cronRejectedRequest();
	}

}
