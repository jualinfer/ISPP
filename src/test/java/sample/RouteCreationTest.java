package sample;

import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;
import javax.validation.ConstraintViolationException;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.util.Assert;

import security.UserAccount;
import security.UserAccountService;
import services.ActorService;
import services.ControlPointService;
import services.DriverService;
import services.RouteService;
import services.VehicleService;
import utilities.AbstractTest;
import domain.ControlPoint;
import domain.Driver;
import domain.LuggageSize;
import domain.Route;
import domain.Vehicle;
import domain.VehicleType;
import forms.RouteForm;

@ContextConfiguration(locations = {
	"classpath:spring/junit.xml"
})
@RunWith(SpringJUnit4ClassRunner.class)
@Transactional
public class RouteCreationTest extends AbstractTest {
	
	@Autowired
	private UserAccountService	userAccountService;
	
	@Autowired
	private ActorService actorService;
	
	@Autowired
	private DriverService driverService;
	
	@Autowired
	private VehicleService vehicleService;
	
	@Autowired
	private RouteService routeService;
	
	@Autowired
	private ControlPointService cpService;
	
	private Driver driver;
	
	@Test
	public void WithoutIntermediateCPTest() {
		Calendar calendar = Calendar.getInstance();
//		calendar.set(2020, 10, 19, 18, 0, 0);
		calendar.add(Calendar.HOUR, 24);
		
		Route r = routeService.create();
		RouteForm rf = routeService.construct(r);
		
		rf.setAvailableSeats(3);
		rf.setDepartureDate(new Date(calendar.getTimeInMillis()));
		rf.setDetails("This route is awesome!");
		rf.setMaxLuggage(LuggageSize.MEDIUM);
		Vehicle vehicle = null;
		for (Vehicle v : driver.getVehicles()) {
			vehicle = v;
		}
		rf.setVehicle(vehicle);
		rf.getOrigin().setLocation("reina mercedes, sevilla, spain");
		rf.getDestination().setLocation("camas, sevilla, spain");
		
		r = routeService.reconstruct(rf, driver, null);
		routeService.calculaDuracion(r);
		r = routeService.save2(r);
		
		Assert.notNull(r);
		
		r = routeService.findOne(r.getId());
		
		Assert.notNull(r);
		Assert.isTrue(r.getDriver().getId() == driver.getId());
		Assert.isTrue(r.getAvailableSeats() == 3);
		Assert.isTrue(r.getDistance() > 0d);
		Assert.isTrue(r.getPricePerPassenger() >= 1.10d);
		Assert.isTrue(r.getDepartureDate().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(r.getOrigin().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(r.getDestination().equals("camas, sevilla, spain"));
		Assert.isTrue(r.getControlPoints().size() == 2);
		
		List<ControlPoint> cps = cpService.findByRoute(r);
		Collections.sort(cps, new ControlPointComparator());
		
		Assert.isTrue(cps.get(0).getArrivalOrder() == 0);
		Assert.isTrue(cps.get(0).getLocation().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(cps.get(0).getDistance() == 0d);
		Assert.isTrue(cps.get(0).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(cps.get(1).getArrivalOrder() == 1);
		Assert.isTrue(cps.get(1).getLocation().equals("camas, sevilla, spain"));
		Assert.isTrue(cps.get(1).getDistance() > 0d);
		Assert.isTrue(cps.get(1).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
	}
	
	@Test
	public void WithIntermediateCPTest() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.HOUR, 24);
		
		Route r = routeService.create();
		RouteForm rf = routeService.construct(r);
		
		rf.setAvailableSeats(2);
		rf.setDepartureDate(new Date(calendar.getTimeInMillis()));
		rf.setDetails("This route is awesome!");
		rf.setMaxLuggage(LuggageSize.NOTHING);
		Vehicle vehicle = null;
		for (Vehicle v : driver.getVehicles()) {
			vehicle = v;
		}
		rf.setVehicle(vehicle);
		rf.getOrigin().setLocation("reina mercedes, sevilla, spain");
		rf.getDestination().setLocation("valencina de la concepción, sevilla, spain");
		
		cpService.addControlPoint(rf);
		rf.getControlpoints().get(0).setLocation("camas, sevilla, spain");
		

		cpService.addControlPoint(rf);
		rf.getControlpoints().get(1).setLocation("santiponce, sevilla, spain");
		
		r = routeService.reconstruct(rf, driver, null);
		routeService.calculaDuracion(r);
		r = routeService.save2(r);
		
		Assert.notNull(r);
		
		r = routeService.findOne(r.getId());
		
		Assert.notNull(r);
		Assert.isTrue(r.getDriver().getId() == driver.getId());
		Assert.isTrue(r.getAvailableSeats() == 2);
		Assert.isTrue(r.getDepartureDate().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(r.getDistance() > 0d);
		Assert.isTrue(r.getPricePerPassenger() >= 1.10d);
		Assert.isTrue(r.getOrigin().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(r.getDestination().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(r.getControlPoints().size() == 4);
		
		List<ControlPoint> cps = cpService.findByRoute(r);
		Collections.sort(cps, new ControlPointComparator());
		
		Assert.isTrue(cps.get(0).getArrivalOrder() == 0);
		Assert.isTrue(cps.get(0).getLocation().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(cps.get(0).getDistance() == 0d);
		Assert.isTrue(cps.get(0).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(cps.get(1).getArrivalOrder() == 1);
		Assert.isTrue(cps.get(1).getLocation().equals("camas, sevilla, spain"));
		Assert.isTrue(cps.get(1).getDistance() > 0d);
		Assert.isTrue(cps.get(1).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(2).getArrivalOrder() == 2);
		Assert.isTrue(cps.get(2).getLocation().equals("santiponce, sevilla, spain"));
		Assert.isTrue(cps.get(2).getDistance() > 0d);
		Assert.isTrue(cps.get(2).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(3).getArrivalOrder() == 3);
		Assert.isTrue(cps.get(3).getLocation().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(cps.get(3).getDistance() > 0d);
		Assert.isTrue(cps.get(3).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
	}
	
	@Test
	public void WithIntermediateCPAndDeletionsTest() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.HOUR, 12);
		
		Route r = routeService.create();
		RouteForm rf = routeService.construct(r);
		
		rf.setAvailableSeats(1);
		rf.setDepartureDate(new Date(calendar.getTimeInMillis()));
		rf.setDetails("This route is awesome!");
		rf.setMaxLuggage(LuggageSize.SMALL);
		Vehicle vehicle = null;
		for (Vehicle v : driver.getVehicles()) {
			vehicle = v;
		}
		rf.setVehicle(vehicle);
		rf.getOrigin().setLocation("reina mercedes, sevilla, spain");
		rf.getDestination().setLocation("valencina de la concepción, sevilla, spain");
		
		cpService.addControlPoint(rf);
		rf.getControlpoints().get(0).setLocation("camas, sevilla, spain");

		cpService.addControlPoint(rf);
		rf.getControlpoints().get(1).setLocation("santiponce, sevilla, spain");
		
		cpService.removeControlPoint(rf, 0);
		
		r = routeService.reconstruct(rf, driver, null);
		routeService.calculaDuracion(r);
		r = routeService.save2(r);
		
		Assert.notNull(r);
		
		r = routeService.findOne(r.getId());
		
		Assert.notNull(r);
		Assert.isTrue(r.getDriver().getId() == driver.getId());
		Assert.isTrue(r.getAvailableSeats() == 1);
		Assert.isTrue(r.getDepartureDate().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(r.getDistance() > 0d);
		Assert.isTrue(r.getPricePerPassenger() >= 1.10d);
		Assert.isTrue(r.getOrigin().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(r.getDestination().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(r.getControlPoints().size() == 3);
		
		List<ControlPoint> cps = cpService.findByRoute(r);
		Collections.sort(cps, new ControlPointComparator());
		
		Assert.isTrue(cps.get(0).getArrivalOrder() == 0);
		Assert.isTrue(cps.get(0).getLocation().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(cps.get(0).getDistance() == 0d);
		Assert.isTrue(cps.get(0).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(cps.get(1).getArrivalOrder() == 1);
		Assert.isTrue(cps.get(1).getLocation().equals("santiponce, sevilla, spain"));
		Assert.isTrue(cps.get(1).getDistance() > 0d);
		Assert.isTrue(cps.get(1).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(2).getArrivalOrder() == 2);
		Assert.isTrue(cps.get(2).getLocation().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(cps.get(2).getDistance() > 0d);
		Assert.isTrue(cps.get(2).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
	}
	
	@Test(expected = NullPointerException.class)
	public void TooSoonDateErrorTest() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.MINUTE, 5);
		
		Route r = routeService.create();
		RouteForm rf = routeService.construct(r);
		
		rf.setAvailableSeats(2);
		rf.setDepartureDate(new Date(calendar.getTimeInMillis()));
		rf.setDetails("This route is awesome!");
		rf.setMaxLuggage(LuggageSize.NOTHING);
		Vehicle vehicle = null;
		for (Vehicle v : driver.getVehicles()) {
			vehicle = v;
		}
		rf.setVehicle(vehicle);
		rf.getOrigin().setLocation("reina mercedes, sevilla, spain");
		rf.getDestination().setLocation("valencina de la concepción, sevilla, spain");
		
		cpService.addControlPoint(rf);
		rf.getControlpoints().get(0).setLocation("camas, sevilla, spain");
		

		cpService.addControlPoint(rf);
		rf.getControlpoints().get(1).setLocation("santiponce, sevilla, spain");
		
		r = routeService.reconstruct(rf, driver, null);
		routeService.calculaDuracion(r);
		r = routeService.save2(r);
		
		Assert.notNull(r);
		
		r = routeService.findOne(r.getId());
		
		Assert.notNull(r);
		Assert.isTrue(r.getDriver().getId() == driver.getId());
		Assert.isTrue(r.getAvailableSeats() == 2);
		Assert.isTrue(r.getDepartureDate().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(r.getDistance() > 0d);
		Assert.isTrue(r.getPricePerPassenger() >= 1.10d);
		Assert.isTrue(r.getOrigin().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(r.getDestination().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(r.getControlPoints().size() == 4);
		
		List<ControlPoint> cps = cpService.findByRoute(r);
		Collections.sort(cps, new ControlPointComparator());
		
		Assert.isTrue(cps.get(0).getArrivalOrder() == 0);
		Assert.isTrue(cps.get(0).getLocation().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(cps.get(0).getDistance() == 0d);
		Assert.isTrue(cps.get(0).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(cps.get(1).getArrivalOrder() == 1);
		Assert.isTrue(cps.get(1).getLocation().equals("camas, sevilla, spain"));
		Assert.isTrue(cps.get(1).getDistance() > 0d);
		Assert.isTrue(cps.get(1).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(2).getArrivalOrder() == 2);
		Assert.isTrue(cps.get(2).getLocation().equals("santiponce, sevilla, spain"));
		Assert.isTrue(cps.get(2).getDistance() > 0d);
		Assert.isTrue(cps.get(2).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(3).getArrivalOrder() == 3);
		Assert.isTrue(cps.get(3).getLocation().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(cps.get(3).getDistance() > 0d);
		Assert.isTrue(cps.get(3).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
	}
	
	@Test(expected = NullPointerException.class)
	public void PastDateErrorTest() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.MINUTE, -5);
		
		Route r = routeService.create();
		RouteForm rf = routeService.construct(r);
		
		rf.setAvailableSeats(2);
		rf.setDepartureDate(new Date(calendar.getTimeInMillis()));
		rf.setDetails("This route is awesome!");
		rf.setMaxLuggage(LuggageSize.NOTHING);
		Vehicle vehicle = null;
		for (Vehicle v : driver.getVehicles()) {
			vehicle = v;
		}
		rf.setVehicle(vehicle);
		rf.getOrigin().setLocation("reina mercedes, sevilla, spain");
		rf.getDestination().setLocation("valencina de la concepción, sevilla, spain");
		
		cpService.addControlPoint(rf);
		rf.getControlpoints().get(0).setLocation("camas, sevilla, spain");
		

		cpService.addControlPoint(rf);
		rf.getControlpoints().get(1).setLocation("santiponce, sevilla, spain");
		
		r = routeService.reconstruct(rf, driver, null);
		routeService.calculaDuracion(r);
		r = routeService.save2(r);
		
		Assert.notNull(r);
		
		r = routeService.findOne(r.getId());
		
		Assert.notNull(r);
		Assert.isTrue(r.getDriver().getId() == driver.getId());
		Assert.isTrue(r.getAvailableSeats() == 2);
		Assert.isTrue(r.getDepartureDate().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(r.getDistance() > 0d);
		Assert.isTrue(r.getPricePerPassenger() >= 1.10d);
		Assert.isTrue(r.getOrigin().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(r.getDestination().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(r.getControlPoints().size() == 4);
		
		List<ControlPoint> cps = cpService.findByRoute(r);
		Collections.sort(cps, new ControlPointComparator());
		
		Assert.isTrue(cps.get(0).getArrivalOrder() == 0);
		Assert.isTrue(cps.get(0).getLocation().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(cps.get(0).getDistance() == 0d);
		Assert.isTrue(cps.get(0).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(cps.get(1).getArrivalOrder() == 1);
		Assert.isTrue(cps.get(1).getLocation().equals("camas, sevilla, spain"));
		Assert.isTrue(cps.get(1).getDistance() > 0d);
		Assert.isTrue(cps.get(1).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(2).getArrivalOrder() == 2);
		Assert.isTrue(cps.get(2).getLocation().equals("santiponce, sevilla, spain"));
		Assert.isTrue(cps.get(2).getDistance() > 0d);
		Assert.isTrue(cps.get(2).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(3).getArrivalOrder() == 3);
		Assert.isTrue(cps.get(3).getLocation().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(cps.get(3).getDistance() > 0d);
		Assert.isTrue(cps.get(3).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
	}
	
	@Test(expected = ConstraintViolationException.class)
	public void LowAvailableSeatsErrorTest() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.HOUR, 1);
		
		Route r = routeService.create();
		RouteForm rf = routeService.construct(r);
		
		rf.setAvailableSeats(0);
		rf.setDepartureDate(new Date(calendar.getTimeInMillis()));
		rf.setDetails("This route is awesome!");
		rf.setMaxLuggage(LuggageSize.NOTHING);
		Vehicle vehicle = null;
		for (Vehicle v : driver.getVehicles()) {
			vehicle = v;
		}
		rf.setVehicle(vehicle);
		rf.getOrigin().setLocation("reina mercedes, sevilla, spain");
		rf.getDestination().setLocation("valencina de la concepción, sevilla, spain");
		
		cpService.addControlPoint(rf);
		rf.getControlpoints().get(0).setLocation("camas, sevilla, spain");
		

		cpService.addControlPoint(rf);
		rf.getControlpoints().get(1).setLocation("santiponce, sevilla, spain");
		
		r = routeService.reconstruct(rf, driver, null);
		routeService.calculaDuracion(r);
		r = routeService.save2(r);
		
		Assert.notNull(r);
		
		r = routeService.findOne(r.getId());
		
		Assert.notNull(r);
		Assert.isTrue(r.getDriver().getId() == driver.getId());
		Assert.isTrue(r.getAvailableSeats() == 0);
		Assert.isTrue(r.getDepartureDate().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(r.getDistance() > 0d);
		Assert.isTrue(r.getPricePerPassenger() >= 1.10d);
		Assert.isTrue(r.getOrigin().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(r.getDestination().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(r.getControlPoints().size() == 4);
		
		List<ControlPoint> cps = cpService.findByRoute(r);
		Collections.sort(cps, new ControlPointComparator());
		
		Assert.isTrue(cps.get(0).getArrivalOrder() == 0);
		Assert.isTrue(cps.get(0).getLocation().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(cps.get(0).getDistance() == 0d);
		Assert.isTrue(cps.get(0).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(cps.get(1).getArrivalOrder() == 1);
		Assert.isTrue(cps.get(1).getLocation().equals("camas, sevilla, spain"));
		Assert.isTrue(cps.get(1).getDistance() > 0d);
		Assert.isTrue(cps.get(1).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(2).getArrivalOrder() == 2);
		Assert.isTrue(cps.get(2).getLocation().equals("santiponce, sevilla, spain"));
		Assert.isTrue(cps.get(2).getDistance() > 0d);
		Assert.isTrue(cps.get(2).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(3).getArrivalOrder() == 3);
		Assert.isTrue(cps.get(3).getLocation().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(cps.get(3).getDistance() > 0d);
		Assert.isTrue(cps.get(3).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
	}
	
	@Test(expected = NullPointerException.class)
	public void HighAvailableSeatsErrorTest() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.HOUR, 1);
		
		Route r = routeService.create();
		RouteForm rf = routeService.construct(r);
		
		rf.setAvailableSeats(6);
		rf.setDepartureDate(new Date(calendar.getTimeInMillis()));
		rf.setDetails("This route is awesome!");
		rf.setMaxLuggage(LuggageSize.NOTHING);
		Vehicle vehicle = null;
		for (Vehicle v : driver.getVehicles()) {
			vehicle = v;
		}
		rf.setVehicle(vehicle);
		rf.getOrigin().setLocation("reina mercedes, sevilla, spain");
		rf.getDestination().setLocation("valencina de la concepción, sevilla, spain");
		
		cpService.addControlPoint(rf);
		rf.getControlpoints().get(0).setLocation("camas, sevilla, spain");
		

		cpService.addControlPoint(rf);
		rf.getControlpoints().get(1).setLocation("santiponce, sevilla, spain");
		
		r = routeService.reconstruct(rf, driver, null);
		routeService.calculaDuracion(r);
		r = routeService.save2(r);
		
		Assert.notNull(r);
		
		r = routeService.findOne(r.getId());
		
		Assert.notNull(r);
		Assert.isTrue(r.getDriver().getId() == driver.getId());
		Assert.isTrue(r.getAvailableSeats() == 6);
		Assert.isTrue(r.getDepartureDate().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(r.getDistance() > 0d);
		Assert.isTrue(r.getPricePerPassenger() >= 1.10d);
		Assert.isTrue(r.getOrigin().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(r.getDestination().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(r.getControlPoints().size() == 4);
		
		List<ControlPoint> cps = cpService.findByRoute(r);
		Collections.sort(cps, new ControlPointComparator());
		
		Assert.isTrue(cps.get(0).getArrivalOrder() == 0);
		Assert.isTrue(cps.get(0).getLocation().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(cps.get(0).getDistance() == 0d);
		Assert.isTrue(cps.get(0).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(cps.get(1).getArrivalOrder() == 1);
		Assert.isTrue(cps.get(1).getLocation().equals("camas, sevilla, spain"));
		Assert.isTrue(cps.get(1).getDistance() > 0d);
		Assert.isTrue(cps.get(1).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(2).getArrivalOrder() == 2);
		Assert.isTrue(cps.get(2).getLocation().equals("santiponce, sevilla, spain"));
		Assert.isTrue(cps.get(2).getDistance() > 0d);
		Assert.isTrue(cps.get(2).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(3).getArrivalOrder() == 3);
		Assert.isTrue(cps.get(3).getLocation().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(cps.get(3).getDistance() > 0d);
		Assert.isTrue(cps.get(3).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
	}
	
	@Test(expected = ConstraintViolationException.class)
	public void NullMaxLuggageErrorTest() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.HOUR, 1);
		
		Route r = routeService.create();
		RouteForm rf = routeService.construct(r);
		
		rf.setAvailableSeats(2);
		rf.setDepartureDate(new Date(calendar.getTimeInMillis()));
		rf.setDetails("This route is awesome!");
		rf.setMaxLuggage(null);
		Vehicle vehicle = null;
		for (Vehicle v : driver.getVehicles()) {
			vehicle = v;
		}
		rf.setVehicle(vehicle);
		rf.getOrigin().setLocation("reina mercedes, sevilla, spain");
		rf.getDestination().setLocation("valencina de la concepción, sevilla, spain");
		
		cpService.addControlPoint(rf);
		rf.getControlpoints().get(0).setLocation("camas, sevilla, spain");
		

		cpService.addControlPoint(rf);
		rf.getControlpoints().get(1).setLocation("santiponce, sevilla, spain");
		
		r = routeService.reconstruct(rf, driver, null);
		routeService.calculaDuracion(r);
		r = routeService.save2(r);
		
		Assert.notNull(r);
		
		r = routeService.findOne(r.getId());
		
		Assert.notNull(r);
		Assert.isTrue(r.getDriver().getId() == driver.getId());
		Assert.isTrue(r.getAvailableSeats() == 2);
		Assert.isTrue(r.getDepartureDate().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(r.getDistance() > 0d);
		Assert.isTrue(r.getPricePerPassenger() >= 1.10d);
		Assert.isTrue(r.getOrigin().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(r.getDestination().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(r.getControlPoints().size() == 4);
		
		List<ControlPoint> cps = cpService.findByRoute(r);
		Collections.sort(cps, new ControlPointComparator());
		
		Assert.isTrue(cps.get(0).getArrivalOrder() == 0);
		Assert.isTrue(cps.get(0).getLocation().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(cps.get(0).getDistance() == 0d);
		Assert.isTrue(cps.get(0).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(cps.get(1).getArrivalOrder() == 1);
		Assert.isTrue(cps.get(1).getLocation().equals("camas, sevilla, spain"));
		Assert.isTrue(cps.get(1).getDistance() > 0d);
		Assert.isTrue(cps.get(1).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(2).getArrivalOrder() == 2);
		Assert.isTrue(cps.get(2).getLocation().equals("santiponce, sevilla, spain"));
		Assert.isTrue(cps.get(2).getDistance() > 0d);
		Assert.isTrue(cps.get(2).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(3).getArrivalOrder() == 3);
		Assert.isTrue(cps.get(3).getLocation().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(cps.get(3).getDistance() > 0d);
		Assert.isTrue(cps.get(3).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
	}
	
	@Test(expected = NullPointerException.class)
	public void NullVehicleErrorTest() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.HOUR, 3);
		
		Route r = routeService.create();
		RouteForm rf = routeService.construct(r);
		
		rf.setAvailableSeats(3);
		rf.setDepartureDate(new Date(calendar.getTimeInMillis()));
		rf.setDetails("This route is awesome!");
		rf.setMaxLuggage(LuggageSize.BIG);
		Vehicle vehicle = null;
//		for (Vehicle v : driver.getVehicles()) {
//			vehicle = v;
//		}
		rf.setVehicle(vehicle);
		rf.getOrigin().setLocation("reina mercedes, sevilla, spain");
		rf.getDestination().setLocation("valencina de la concepción, sevilla, spain");
		
		cpService.addControlPoint(rf);
		rf.getControlpoints().get(0).setLocation("camas, sevilla, spain");
		

		cpService.addControlPoint(rf);
		rf.getControlpoints().get(1).setLocation("santiponce, sevilla, spain");
		
		r = routeService.reconstruct(rf, driver, null);
		routeService.calculaDuracion(r);
		r = routeService.save2(r);
		
		Assert.notNull(r);
		
		r = routeService.findOne(r.getId());
		
		Assert.notNull(r);
		Assert.isTrue(r.getDriver().getId() == driver.getId());
		Assert.isTrue(r.getAvailableSeats() == 3);
		Assert.isTrue(r.getDepartureDate().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(r.getDistance() > 0d);
		Assert.isTrue(r.getPricePerPassenger() >= 1.10d);
		Assert.isTrue(r.getOrigin().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(r.getDestination().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(r.getControlPoints().size() == 4);
		
		List<ControlPoint> cps = cpService.findByRoute(r);
		Collections.sort(cps, new ControlPointComparator());
		
		Assert.isTrue(cps.get(0).getArrivalOrder() == 0);
		Assert.isTrue(cps.get(0).getLocation().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(cps.get(0).getDistance() == 0d);
		Assert.isTrue(cps.get(0).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(cps.get(1).getArrivalOrder() == 1);
		Assert.isTrue(cps.get(1).getLocation().equals("camas, sevilla, spain"));
		Assert.isTrue(cps.get(1).getDistance() > 0d);
		Assert.isTrue(cps.get(1).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(2).getArrivalOrder() == 2);
		Assert.isTrue(cps.get(2).getLocation().equals("santiponce, sevilla, spain"));
		Assert.isTrue(cps.get(2).getDistance() > 0d);
		Assert.isTrue(cps.get(2).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(3).getArrivalOrder() == 3);
		Assert.isTrue(cps.get(3).getLocation().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(cps.get(3).getDistance() > 0d);
		Assert.isTrue(cps.get(3).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
	}
	
	@Test(expected = ConstraintViolationException.class)
	public void NullOriginErrorTest() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.HOUR, 3);
		
		Route r = routeService.create();
		RouteForm rf = routeService.construct(r);
		
		rf.setAvailableSeats(3);
		rf.setDepartureDate(new Date(calendar.getTimeInMillis()));
		rf.setDetails("This route is awesome!");
		rf.setMaxLuggage(LuggageSize.BIG);
		Vehicle vehicle = null;
		for (Vehicle v : driver.getVehicles()) {
			vehicle = v;
		}
		rf.setVehicle(vehicle);
		rf.getOrigin().setLocation(null);
		rf.getDestination().setLocation("valencina de la concepción, sevilla, spain");
		
		cpService.addControlPoint(rf);
		rf.getControlpoints().get(0).setLocation("camas, sevilla, spain");
		

		cpService.addControlPoint(rf);
		rf.getControlpoints().get(1).setLocation("santiponce, sevilla, spain");
		
		r = routeService.reconstruct(rf, driver, null);
		routeService.calculaDuracion(r);
		r = routeService.save2(r);
		
		Assert.notNull(r);
		
		r = routeService.findOne(r.getId());
		
		Assert.notNull(r);
		Assert.isTrue(r.getDriver().getId() == driver.getId());
		Assert.isTrue(r.getAvailableSeats() == 3);
		Assert.isTrue(r.getDepartureDate().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(r.getDistance() > 0d);
		Assert.isTrue(r.getPricePerPassenger() >= 1.10d);
		Assert.isTrue(r.getOrigin().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(r.getDestination().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(r.getControlPoints().size() == 4);
		
		List<ControlPoint> cps = cpService.findByRoute(r);
		Collections.sort(cps, new ControlPointComparator());
		
		Assert.isTrue(cps.get(0).getArrivalOrder() == 0);
		Assert.isTrue(cps.get(0).getLocation().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(cps.get(0).getDistance() == 0d);
		Assert.isTrue(cps.get(0).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(cps.get(1).getArrivalOrder() == 1);
		Assert.isTrue(cps.get(1).getLocation().equals("camas, sevilla, spain"));
		Assert.isTrue(cps.get(1).getDistance() > 0d);
		Assert.isTrue(cps.get(1).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(2).getArrivalOrder() == 2);
		Assert.isTrue(cps.get(2).getLocation().equals("santiponce, sevilla, spain"));
		Assert.isTrue(cps.get(2).getDistance() > 0d);
		Assert.isTrue(cps.get(2).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(3).getArrivalOrder() == 3);
		Assert.isTrue(cps.get(3).getLocation().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(cps.get(3).getDistance() > 0d);
		Assert.isTrue(cps.get(3).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
	}
	
	@Test(expected = ConstraintViolationException.class)
	public void BlankOriginErrorTest() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.HOUR, 3);
		
		Route r = routeService.create();
		RouteForm rf = routeService.construct(r);
		
		rf.setAvailableSeats(3);
		rf.setDepartureDate(new Date(calendar.getTimeInMillis()));
		rf.setDetails("This route is awesome!");
		rf.setMaxLuggage(LuggageSize.BIG);
		Vehicle vehicle = null;
		for (Vehicle v : driver.getVehicles()) {
			vehicle = v;
		}
		rf.setVehicle(vehicle);
		rf.getOrigin().setLocation("   ");
		rf.getDestination().setLocation("valencina de la concepción, sevilla, spain");
		
		cpService.addControlPoint(rf);
		rf.getControlpoints().get(0).setLocation("camas, sevilla, spain");
		

		cpService.addControlPoint(rf);
		rf.getControlpoints().get(1).setLocation("santiponce, sevilla, spain");
		
		r = routeService.reconstruct(rf, driver, null);
		routeService.calculaDuracion(r);
		r = routeService.save2(r);
		
		Assert.notNull(r);
		
		r = routeService.findOne(r.getId());
		
		Assert.notNull(r);
		Assert.isTrue(r.getDriver().getId() == driver.getId());
		Assert.isTrue(r.getAvailableSeats() == 3);
		Assert.isTrue(r.getDepartureDate().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(r.getDistance() > 0d);
		Assert.isTrue(r.getPricePerPassenger() >= 1.10d);
		Assert.isTrue(r.getOrigin().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(r.getDestination().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(r.getControlPoints().size() == 4);
		
		List<ControlPoint> cps = cpService.findByRoute(r);
		Collections.sort(cps, new ControlPointComparator());
		
		Assert.isTrue(cps.get(0).getArrivalOrder() == 0);
		Assert.isTrue(cps.get(0).getLocation().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(cps.get(0).getDistance() == 0d);
		Assert.isTrue(cps.get(0).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(cps.get(1).getArrivalOrder() == 1);
		Assert.isTrue(cps.get(1).getLocation().equals("camas, sevilla, spain"));
		Assert.isTrue(cps.get(1).getDistance() > 0d);
		Assert.isTrue(cps.get(1).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(2).getArrivalOrder() == 2);
		Assert.isTrue(cps.get(2).getLocation().equals("santiponce, sevilla, spain"));
		Assert.isTrue(cps.get(2).getDistance() > 0d);
		Assert.isTrue(cps.get(2).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(3).getArrivalOrder() == 3);
		Assert.isTrue(cps.get(3).getLocation().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(cps.get(3).getDistance() > 0d);
		Assert.isTrue(cps.get(3).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
	}
	
	@Test(expected = ConstraintViolationException.class)
	public void NullDestinationErrorTest() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.HOUR, 3);
		
		Route r = routeService.create();
		RouteForm rf = routeService.construct(r);
		
		rf.setAvailableSeats(3);
		rf.setDepartureDate(new Date(calendar.getTimeInMillis()));
		rf.setDetails("This route is awesome!");
		rf.setMaxLuggage(LuggageSize.BIG);
		Vehicle vehicle = null;
		for (Vehicle v : driver.getVehicles()) {
			vehicle = v;
		}
		rf.setVehicle(vehicle);
		rf.getOrigin().setLocation("reina mercedes, sevilla, spain");
		rf.getDestination().setLocation(null);
		
		cpService.addControlPoint(rf);
		rf.getControlpoints().get(0).setLocation("camas, sevilla, spain");
		

		cpService.addControlPoint(rf);
		rf.getControlpoints().get(1).setLocation("santiponce, sevilla, spain");
		
		r = routeService.reconstruct(rf, driver, null);
		routeService.calculaDuracion(r);
		r = routeService.save2(r);
		
		Assert.notNull(r);
		
		r = routeService.findOne(r.getId());
		
		Assert.notNull(r);
		Assert.isTrue(r.getDriver().getId() == driver.getId());
		Assert.isTrue(r.getAvailableSeats() == 3);
		Assert.isTrue(r.getDepartureDate().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(r.getDistance() > 0d);
		Assert.isTrue(r.getPricePerPassenger() >= 1.10d);
		Assert.isTrue(r.getOrigin().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(r.getDestination().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(r.getControlPoints().size() == 4);
		
		List<ControlPoint> cps = cpService.findByRoute(r);
		Collections.sort(cps, new ControlPointComparator());
		
		Assert.isTrue(cps.get(0).getArrivalOrder() == 0);
		Assert.isTrue(cps.get(0).getLocation().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(cps.get(0).getDistance() == 0d);
		Assert.isTrue(cps.get(0).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(cps.get(1).getArrivalOrder() == 1);
		Assert.isTrue(cps.get(1).getLocation().equals("camas, sevilla, spain"));
		Assert.isTrue(cps.get(1).getDistance() > 0d);
		Assert.isTrue(cps.get(1).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(2).getArrivalOrder() == 2);
		Assert.isTrue(cps.get(2).getLocation().equals("santiponce, sevilla, spain"));
		Assert.isTrue(cps.get(2).getDistance() > 0d);
		Assert.isTrue(cps.get(2).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(3).getArrivalOrder() == 3);
		Assert.isTrue(cps.get(3).getLocation().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(cps.get(3).getDistance() > 0d);
		Assert.isTrue(cps.get(3).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
	}
	
	@Test(expected = ConstraintViolationException.class)
	public void BlankDestinationErrorTest() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.HOUR, 3);
		
		Route r = routeService.create();
		RouteForm rf = routeService.construct(r);
		
		rf.setAvailableSeats(3);
		rf.setDepartureDate(new Date(calendar.getTimeInMillis()));
		rf.setDetails("This route is awesome!");
		rf.setMaxLuggage(LuggageSize.BIG);
		Vehicle vehicle = null;
		for (Vehicle v : driver.getVehicles()) {
			vehicle = v;
		}
		rf.setVehicle(vehicle);
		rf.getOrigin().setLocation("reina mercedes, sevilla, spain");
		rf.getDestination().setLocation("     ");
		
		cpService.addControlPoint(rf);
		rf.getControlpoints().get(0).setLocation("camas, sevilla, spain");
		

		cpService.addControlPoint(rf);
		rf.getControlpoints().get(1).setLocation("santiponce, sevilla, spain");
		
		r = routeService.reconstruct(rf, driver, null);
		routeService.calculaDuracion(r);
		r = routeService.save2(r);
		
		Assert.notNull(r);
		
		r = routeService.findOne(r.getId());
		
		Assert.notNull(r);
		Assert.isTrue(r.getDriver().getId() == driver.getId());
		Assert.isTrue(r.getAvailableSeats() == 3);
		Assert.isTrue(r.getDepartureDate().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(r.getDistance() > 0d);
		Assert.isTrue(r.getPricePerPassenger() >= 1.10d);
		Assert.isTrue(r.getOrigin().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(r.getDestination().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(r.getControlPoints().size() == 4);
		
		List<ControlPoint> cps = cpService.findByRoute(r);
		Collections.sort(cps, new ControlPointComparator());
		
		Assert.isTrue(cps.get(0).getArrivalOrder() == 0);
		Assert.isTrue(cps.get(0).getLocation().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(cps.get(0).getDistance() == 0d);
		Assert.isTrue(cps.get(0).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(cps.get(1).getArrivalOrder() == 1);
		Assert.isTrue(cps.get(1).getLocation().equals("camas, sevilla, spain"));
		Assert.isTrue(cps.get(1).getDistance() > 0d);
		Assert.isTrue(cps.get(1).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(2).getArrivalOrder() == 2);
		Assert.isTrue(cps.get(2).getLocation().equals("santiponce, sevilla, spain"));
		Assert.isTrue(cps.get(2).getDistance() > 0d);
		Assert.isTrue(cps.get(2).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(3).getArrivalOrder() == 3);
		Assert.isTrue(cps.get(3).getLocation().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(cps.get(3).getDistance() > 0d);
		Assert.isTrue(cps.get(3).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
	}
	
	@Test(expected = ConstraintViolationException.class)
	public void NullControlPointErrorTest() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.HOUR, 1);
		
		Route r = routeService.create();
		RouteForm rf = routeService.construct(r);
		
		rf.setAvailableSeats(2);
		rf.setDepartureDate(new Date(calendar.getTimeInMillis()));
		rf.setDetails("This route is awesome!");
		rf.setMaxLuggage(LuggageSize.MEDIUM);
		Vehicle vehicle = null;
		for (Vehicle v : driver.getVehicles()) {
			vehicle = v;
		}
		rf.setVehicle(vehicle);
		rf.getOrigin().setLocation("reina mercedes, sevilla, spain");
		rf.getDestination().setLocation("valencina de la concepción, sevilla, spain");
		
		cpService.addControlPoint(rf);
		rf.getControlpoints().get(0).setLocation(null);
		

		cpService.addControlPoint(rf);
		rf.getControlpoints().get(1).setLocation(null);
		
		r = routeService.reconstruct(rf, driver, null);
		routeService.calculaDuracion(r);
		r = routeService.save2(r);
		
		Assert.notNull(r);
		
		r = routeService.findOne(r.getId());
		
		Assert.notNull(r);
		Assert.isTrue(r.getDriver().getId() == driver.getId());
		Assert.isTrue(r.getAvailableSeats() == 2);
		Assert.isTrue(r.getDepartureDate().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(r.getDistance() > 0d);
		Assert.isTrue(r.getPricePerPassenger() >= 1.10d);
		Assert.isTrue(r.getOrigin().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(r.getDestination().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(r.getControlPoints().size() == 4);
		
		List<ControlPoint> cps = cpService.findByRoute(r);
		Collections.sort(cps, new ControlPointComparator());
		
		Assert.isTrue(cps.get(0).getArrivalOrder() == 0);
		Assert.isTrue(cps.get(0).getLocation().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(cps.get(0).getDistance() == 0d);
		Assert.isTrue(cps.get(0).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(cps.get(1).getArrivalOrder() == 1);
		Assert.isTrue(cps.get(1).getLocation().equals("camas, sevilla, spain"));
		Assert.isTrue(cps.get(1).getDistance() > 0d);
		Assert.isTrue(cps.get(1).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(2).getArrivalOrder() == 2);
		Assert.isTrue(cps.get(2).getLocation().equals("santiponce, sevilla, spain"));
		Assert.isTrue(cps.get(2).getDistance() > 0d);
		Assert.isTrue(cps.get(2).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(3).getArrivalOrder() == 3);
		Assert.isTrue(cps.get(3).getLocation().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(cps.get(3).getDistance() > 0d);
		Assert.isTrue(cps.get(3).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
	}
	
	@Test(expected = ConstraintViolationException.class)
	public void BlankControlPointErrorTest() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.HOUR, 1);
		
		Route r = routeService.create();
		RouteForm rf = routeService.construct(r);
		
		rf.setAvailableSeats(2);
		rf.setDepartureDate(new Date(calendar.getTimeInMillis()));
		rf.setDetails("This route is awesome!");
		rf.setMaxLuggage(LuggageSize.MEDIUM);
		Vehicle vehicle = null;
		for (Vehicle v : driver.getVehicles()) {
			vehicle = v;
		}
		rf.setVehicle(vehicle);
		rf.getOrigin().setLocation("reina mercedes, sevilla, spain");
		rf.getDestination().setLocation("valencina de la concepción, sevilla, spain");
		
		cpService.addControlPoint(rf);
		rf.getControlpoints().get(0).setLocation("    ");
		

		cpService.addControlPoint(rf);
		rf.getControlpoints().get(1).setLocation("     ");
		
		r = routeService.reconstruct(rf, driver, null);
		routeService.calculaDuracion(r);
		r = routeService.save2(r);
		
		Assert.notNull(r);
		
		r = routeService.findOne(r.getId());
		
		Assert.notNull(r);
		Assert.isTrue(r.getDriver().getId() == driver.getId());
		Assert.isTrue(r.getAvailableSeats() == 2);
		Assert.isTrue(r.getDepartureDate().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(r.getDistance() > 0d);
		Assert.isTrue(r.getPricePerPassenger() >= 1.10d);
		Assert.isTrue(r.getOrigin().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(r.getDestination().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(r.getControlPoints().size() == 4);
		
		List<ControlPoint> cps = cpService.findByRoute(r);
		Collections.sort(cps, new ControlPointComparator());
		
		Assert.isTrue(cps.get(0).getArrivalOrder() == 0);
		Assert.isTrue(cps.get(0).getLocation().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(cps.get(0).getDistance() == 0d);
		Assert.isTrue(cps.get(0).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(cps.get(1).getArrivalOrder() == 1);
		Assert.isTrue(cps.get(1).getLocation().equals("camas, sevilla, spain"));
		Assert.isTrue(cps.get(1).getDistance() > 0d);
		Assert.isTrue(cps.get(1).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(2).getArrivalOrder() == 2);
		Assert.isTrue(cps.get(2).getLocation().equals("santiponce, sevilla, spain"));
		Assert.isTrue(cps.get(2).getDistance() > 0d);
		Assert.isTrue(cps.get(2).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(3).getArrivalOrder() == 3);
		Assert.isTrue(cps.get(3).getLocation().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(cps.get(3).getDistance() > 0d);
		Assert.isTrue(cps.get(3).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
	}
	
	@Test(expected = ConstraintViolationException.class)
	public void UnderMinimumPricePerPassengerErrorTest() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.HOUR, 16);
		
		Route r = routeService.create();
		RouteForm rf = routeService.construct(r);
		
		rf.setAvailableSeats(2);
		rf.setDepartureDate(new Date(calendar.getTimeInMillis()));
		rf.setDetails("This route is awesome!");
		rf.setMaxLuggage(LuggageSize.NOTHING);
		Vehicle vehicle = null;
		for (Vehicle v : driver.getVehicles()) {
			vehicle = v;
		}
		rf.setVehicle(vehicle);
		rf.getOrigin().setLocation("reina mercedes, sevilla, spain");
		rf.getDestination().setLocation("valencina de la concepción, sevilla, spain");
		
		cpService.addControlPoint(rf);
		rf.getControlpoints().get(0).setLocation("camas, sevilla, spain");
		

		cpService.addControlPoint(rf);
		rf.getControlpoints().get(1).setLocation("santiponce, sevilla, spain");
		
		r = routeService.reconstruct(rf, driver, null);
		routeService.calculaDuracion(r);
		r.setPricePerPassenger(0d);
		r = routeService.save2(r);
		
		Assert.notNull(r);
		
		r = routeService.findOne(r.getId());
		
		Assert.notNull(r);
		Assert.isTrue(r.getDriver().getId() == driver.getId());
		Assert.isTrue(r.getAvailableSeats() == 2);
		Assert.isTrue(r.getDepartureDate().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(r.getDistance() > 0d);
		Assert.isTrue(r.getPricePerPassenger() >= 1.10d);
		Assert.isTrue(r.getOrigin().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(r.getDestination().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(r.getControlPoints().size() == 4);
		
		List<ControlPoint> cps = cpService.findByRoute(r);
		Collections.sort(cps, new ControlPointComparator());
		
		Assert.isTrue(cps.get(0).getArrivalOrder() == 0);
		Assert.isTrue(cps.get(0).getLocation().equals("reina mercedes, sevilla, spain"));
		Assert.isTrue(cps.get(0).getDistance() == 0d);
		Assert.isTrue(cps.get(0).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) == 0);
		Assert.isTrue(cps.get(1).getArrivalOrder() == 1);
		Assert.isTrue(cps.get(1).getLocation().equals("camas, sevilla, spain"));
		Assert.isTrue(cps.get(1).getDistance() > 0d);
		Assert.isTrue(cps.get(1).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(2).getArrivalOrder() == 2);
		Assert.isTrue(cps.get(2).getLocation().equals("santiponce, sevilla, spain"));
		Assert.isTrue(cps.get(2).getDistance() > 0d);
		Assert.isTrue(cps.get(2).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
		Assert.isTrue(cps.get(3).getArrivalOrder() == 3);
		Assert.isTrue(cps.get(3).getLocation().equals("valencina de la concepción, sevilla, spain"));
		Assert.isTrue(cps.get(3).getDistance() > 0d);
		Assert.isTrue(cps.get(3).getArrivalTime().compareTo(new Date(calendar.getTimeInMillis())) > 0);
	}
	
	@Override
	@Before
	public void setUp() {
		Driver driver = driverService.create();
		driver.setBankAccountNumber("ES6621000418401234567891");
		driver.setCash(0.0d);
		driver.setChilds(false);
		driver.setCity("Seville");
		driver.setCountry("Spain");
		driver.setImage("");
		driver.setMediumStars(0.0d);
		driver.setMusic(false);
		driver.setName("John");
		driver.setNewAlerts(0);
		driver.setNewMessages(0);
		driver.setNumberOfTrips(0);
		driver.setPets(false);
		driver.setPhone("665443322");
		driver.setSmoke(false);
		driver.setSurname("Cena");
		driver.getUserAccount().setUsername("test1@gmail.com");
		driver.getUserAccount().setPassword("asd");
		driver.setUserAccount(hashSavePassword(driver.getUserAccount()));
		driver = driverService.save(driver);

		super.authenticate("test1@gmail.com");
		
		Vehicle vehicle = vehicleService.create();
		vehicle.setDriver(driver);
		vehicle.setDescription("Test vehicle");
		vehicle.setImage("");
		vehicle.setModel("Clio");
		vehicle.setPlate("AA1111AAA");
		vehicle.setSeatsCapacity(4);
		vehicle.setType(VehicleType.CAR);
		vehicle.setVehicleBrand("Renault");
		vehicle = vehicleService.save(vehicle);
		
		driver.getVehicles().add(vehicle);
		
		this.driver = (Driver) actorService.findByPrincipal();
		Assert.notNull(this.driver);
	}
	
	@Override
	@After
	public void tearDown() {
		super.unauthenticate();
	}
	
	private UserAccount hashSavePassword(final UserAccount userAccount) {
		Md5PasswordEncoder encoder = new Md5PasswordEncoder();
		userAccount.setPassword(encoder.encodePassword(userAccount.getPassword(), null));
		return userAccountService.save(userAccount);
	}
	
	private class ControlPointComparator implements Comparator<ControlPoint> {

		@Override
		public int compare(ControlPoint o1, ControlPoint o2) {
			return o1.getArrivalOrder().compareTo(o2.getArrivalOrder());
		}
		
	}
	
}
