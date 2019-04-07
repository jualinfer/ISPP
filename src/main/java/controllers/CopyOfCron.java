package controllers;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Configuration
@ComponentScan("com.lynas")
@EnableScheduling
public class CopyOfCron {
	
	public static void main(String[] args) {
        new AnnotationConfigApplicationContext(CopyOfCron.class).getBean(CopyOfCron.class);
    }
}


@Component
class Scheduller{

    @Scheduled(cron = "*/5 * * * * *")
    public void m1(){
        System.out.println("every 5 sec : "+System.nanoTime());
    }

    @Scheduled(fixedRate = 2000)
    public void m2(){
        System.out.println("every 2 sec : "+System.nanoTime());
    }
	
}
