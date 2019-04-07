
package services;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.decimal4j.util.DoubleRounder;
import org.joda.time.LocalTime;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;

import repositories.RouteRepository;
import domain.ControlPoint;
import domain.Driver;
import domain.Finder;
import domain.LuggageSize;
import domain.Reservation;
import domain.ReservationStatus;
import domain.Route;
import domain.VehicleType;
import forms.ControlPointFormCreate;
import forms.RouteForm;

@Service
@Transactional
public class RouteService {

	//Managed repository

	@Autowired
	private RouteRepository		routeRepository;

	//Supporting services

	@Autowired
	private ActorService		actorService;

	@Autowired
	private ControlPointService	controlPointService;

	@Autowired
	private ReservationService	reservationService;
	@Autowired
	private DriverService	driverService;

	//Simple CRUD methods

	public Route create() {
		final Route r = new Route();

		//		final Driver d = (Driver) this.actorService.findByPrincipal();
		//		r.setDriver(d);
		r.setAvailableSeats(1);
		r.setDistance(0d);
		r.setIsCancelled(false);
		r.setReservations(new ArrayList<Reservation>());
		r.setControlPoints(new ArrayList<ControlPoint>());
		r.setDaysRepeat("");
		r.setEstimatedDuration(1);
		r.setMaxLuggage(LuggageSize.NOTHING);
		r.setPricePerPassenger(1.10d);

		return r;
	}
	public Route findOne(final int id) {
		Assert.notNull(id);

		return this.routeRepository.findOne(id);
	}

	public Collection<Route> findAll() {
		return this.routeRepository.findAll();
	}

	public Route save2(final Route r) {
		Assert.notNull(r);
		final Route saved = this.routeRepository.save(r);
		//		saved.setControlPoints(r.getControlPoints());

		for (ControlPoint cp : r.getControlPoints()) {
			cp.setRoute(saved);
			cp = this.controlPointService.save2(cp);
		}

		this.routeRepository.flush();
		this.controlPointService.flush();
		return saved;
	}

	public Route save(final Route r) {
		Assert.notNull(r);
		Double distance = 0.0;
		Double price = 0.0;
		final Date date = new Date();
		Assert.isTrue(r.getDepartureDate().after(date));

		//Assertion that the user modifying this task has the correct privilege.

		if (this.actorService.findByPrincipal() instanceof Driver)
			Assert.isTrue(this.actorService.findByPrincipal().getId() == r.getDriver().getId());
		//Assertion that the avaliable seats  isn't a bigger value than the vehicle capacity
		Assert.isTrue(r.getAvailableSeats() < r.getVehicle().getSeatsCapacity());
		//
		//		if (r.getId() == 0 || r.getControlPoints().size() < 2) {
		//			r.setDestination("NONE");
		//			r.setOrigin("NONE");
		//		} else if (r.getControlPoints().size() >= 2) {
		//			List<ControlPoint> cps = new ArrayList<ControlPoint>(r.getControlPoints());
		//			Collections.sort(cps);
		//
		//			for (int a = 0; a < r.getControlPoints().size() - 1; a++) {
		//				long diffInMillies = cps.get(a + 1).getArrivalTime().getTime() - cps.get(a).getArrivalTime().getTime();
		//				estimatedDuration = (int) (estimatedDuration + TimeUnit.MINUTES.convert(diffInMillies, TimeUnit.MINUTES));
		//				distance = distance + this.getDistance(cps.get(a).getLocation(), cps.get(a + 1).getLocation());
		//			}
		//			price = this.getPrice(distance);
		//
		//			r.setOrigin(cps.get(0).getLocation());
		//			r.setDestination(cps.get(cps.size() - 1).getLocation());
		//		}
		final String origin = r.getOrigin();
		final String destination = r.getDestination();
		distance = this.getDistance(origin, destination);
		price = this.getPrice(distance);
		r.setPricePerPassenger(price);
		r.setDistance(distance);
		final Route saved = this.routeRepository.save(r);
		
		if (this.actorService.findByPrincipal() instanceof Driver){
			Driver driver = saved.getDriver();
			
			Collection<Route> routes = driver.getRoutes();
			routes.add(saved);
			driver.setRoutes(routes);
			this.driverService.save(driver);
			
		}
		

		return saved;
	}

	public void cancel(final Route route) {
		Assert.notNull(route);
		Assert.notNull(route.getDriver());

		// Comprobar que el usuario conectado es el propietario de la ruta
		Assert.isTrue(this.actorService.findByPrincipal().getId() == route.getDriver().getId());
		// Comprobar que la ruta no ha sido previamente cancelada
		Assert.isTrue(!route.getIsCancelled());
		// Comprobar que la ruta no ha comenzado o finalizado
		Assert.isTrue(route.getDepartureDate().after(new Date()));

		// Cancelar solicitudes pendientes y aceptadas
		this.reservationService.autoReject(route);

		route.setIsCancelled(true);

		this.routeRepository.save(route);
	}

	public void delete(final Route r) {

		Assert.notNull(r);

		//Assertion that the user deleting this task has the correct privilege.
		Assert.isTrue(this.actorService.findByPrincipal().getId() == r.getDriver().getId());

		this.routeRepository.delete(r);
	}

	//	public void delete2(Route route) {
	//		Assert.notNull(route);
	//
	//		//Assertion that the user deleting this note has the correct privilege.
	//
	//		Assert.isTrue(this.actorService.findByPrincipal().getId() == route.getDriver().getId());
	//		//Also, we delete the reservations related with the deleted route
	//		if (!(route.getReservations().isEmpty()))
	//			for (Reservation r : route.getReservations())
	//				this.reservationService.delete(r);
	//
	//		this.routeRepository.delete(route);
	//	}

	public Double getDistance(final String origin, final String destination) {
		Double value = 0.0;
		try {
			final String url = "https://maps.googleapis.com/maps/api/directions/json?origin=" + origin.replaceAll(" ", "+") + "&destination=" + destination.replaceAll(" ", "+") + "&key=AIzaSyAKoI-jZJQyPjIp1XGUSsbWh47JBix7qws";
			final URL obj = new URL(url);
			final HttpURLConnection con = (HttpURLConnection) obj.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("User-Agent", "Mozilla/5.0");
			//	final BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			final BufferedReader in = new BufferedReader(new InputStreamReader(((HttpURLConnection) (new URL(url)).openConnection()).getInputStream(), Charset.forName("UTF-8")));
			String inputLine;
			final StringBuffer response = new StringBuffer();
			while ((inputLine = in.readLine()) != null)
				response.append(inputLine);
			in.close();

			final JSONObject myResponse = new JSONObject(response.toString());

			final JSONArray routes = myResponse.getJSONArray("routes");
			final JSONObject obj1 = routes.getJSONObject(0);
			final JSONArray dst = obj1.getJSONArray("legs");
			final JSONObject obj2 = dst.getJSONObject(0);
			final JSONObject obj3 = obj2.getJSONObject("distance");
			value = obj3.getDouble("value");
			value = value / 1000;
		} catch (final Exception e) {
			e.printStackTrace();
		}
		return DoubleRounder.round(value, 2);

	}

	public Double getPrice(final Double distance) {
		Double price = 0.0;
		final Double price3km = 0.33;
		final Double profit = 0.10;
		if (distance < 9.0)
			price = 1 + profit;
		else {
			final String str = String.valueOf(distance / 3);
			final Integer intNumber = Integer.parseInt(str.substring(0, str.indexOf('.')));
			price = intNumber * price3km + profit;

		}
		return DoubleRounder.round(price, 2);
	}

	//Finder 

	public Collection<Route> searchRoutes(final Finder finder) {

		this.validateFinder(finder);

		Collection<Route> queryResult, finalResult;

		final Date departureDate = finder.getDepartureDate();
		final LocalTime timeStart = finder.getOriginTime();
		final LocalTime timeEnds = finder.getDestinationTime();
		final Integer availableSeats = finder.getAvailableSeats();
		final Boolean pets = finder.getPets();
		final Boolean childs = finder.getChilds();
		final Boolean smoke = finder.getSmoke();
		final Boolean music = finder.getMusic();
		final LuggageSize luggageSize = finder.getLuggageSize();
		VehicleType vehicleType = null;

		final Integer vehicleTypeInteger = finder.getVehicleType();

		if (vehicleTypeInteger != 0)
			vehicleType = finder.getVehicleTypeById(vehicleTypeInteger);

		// En los set de origin y destination, se ponen como "" o lo que sea en minusculas
		final String origin = finder.getOrigin();
		final String destination = finder.getDestination();

		final Calendar departureDateFinder = Calendar.getInstance();

		if (departureDate != null)
			departureDateFinder.setTime(departureDate);

		// Buscamos todas las rutas no canceladas futuras
		queryResult = this.routeRepository.searchRoutes(availableSeats);
		finalResult = new ArrayList<Route>();

		final Calendar rutaActual = Calendar.getInstance();

		for (final Route r : queryResult) {

			rutaActual.setTime(r.getDepartureDate());

			// Primero filtramos por FECHA Y HORA:
			if (departureDate != null && rutaActual.get(Calendar.DAY_OF_YEAR) != departureDateFinder.get(Calendar.DAY_OF_YEAR))
				continue;

			final LocalTime departureTime = LocalTime.fromDateFields(r.getDepartureDate());

			if (timeStart != null && departureTime.isBefore(timeStart))
				// Si la hora de inicio de la ruta es anterior a la del finder, ignorar esta ruta
				continue;

			if (timeEnds != null && departureTime.isAfter(timeEnds))
				//Si la hora de fin de la ruta es posterior a la del finder, ignorar esta ruta
				continue;

			// Luego por origen y destino:

			if (origin != "" && !r.getOrigin().toLowerCase().contains(origin))
				continue;

			if (destination != "" && !r.getDestination().toLowerCase().contains(destination))
				continue;

			// Después smoke, pets, childs, music

			final Driver driver = r.getDriver();

			if (smoke && !driver.getSmoke())
				continue;

			if (pets && !driver.getPets())
				continue;

			if (childs && !driver.getChilds())
				continue;

			if (music && !driver.getMusic())
				continue;

			// Y por ultimo LuggageSize y VehicleType
			if (vehicleType != null && r.getVehicle().getType() != vehicleType)
				continue;

			if (luggageSize != null && r.getMaxLuggage().getId() < luggageSize.getId())
				continue;

			finalResult.add(r);

		}

		return finalResult;
	}
	private void validateFinder(final Finder finder) {

		Assert.notNull(finder);

		// Origen o destino deben estar presentes
		Assert.isTrue(!finder.getDestination().isEmpty());

		// La hora minima de salida debe ser inferior a la hora máxima de salida
		if (finder.getOriginTime() != null && finder.getDestinationTime() != null)
			Assert.isTrue((finder.getOriginTime().isBefore(finder.getDestinationTime())));

		//Solamente podemos buscar rutas que sean del día actual hasta el futuro
		if (finder.getDepartureDate() != null) {
			final Calendar de = Calendar.getInstance();
			final Calendar now = Calendar.getInstance();
			de.setTime(finder.getDepartureDate());
			now.setTime(new Date());
			Assert.isTrue(de.get(Calendar.DAY_OF_YEAR) >= now.get(Calendar.DAY_OF_YEAR));
		}
	}

	public Collection<Route> findActiveRoutesByPassenger(final int passengerId) {
		Assert.isTrue(passengerId != 0);

		Collection<Route> routes, result;
		final Date now = new Date();

		routes = this.routeRepository.findActiveRoutesByPassenger(passengerId, ReservationStatus.CANCELLED, ReservationStatus.REJECTED);
		result = new ArrayList<Route>();
		for (final Route r : routes) {
			final Calendar date = Calendar.getInstance();
			date.setTime(r.getDepartureDate());
			final long departureDateMilis = date.getTimeInMillis();
			final Date arrivalDate = new Date(departureDateMilis + (r.getEstimatedDuration() * 60000));
			if (arrivalDate.after(now))
				result.add(r);
		}

		return result;
	}

	public Collection<Route> findActiveRoutesByDriver(final int driverId, final Date now) {
		Assert.isTrue(driverId != 0);
		Assert.notNull(now);

		Collection<Route> result;

		result = this.routeRepository.findActiveRoutesByDriver(driverId, now);

		return result;
	}

	// Construct

	public RouteForm construct(final Route route) {
		Assert.notNull(route);
		final RouteForm routeForm = new RouteForm();
		routeForm.setId(route.getId());
		routeForm.setAvailableSeats(route.getAvailableSeats());
		if (route.getControlPoints().isEmpty()) {
			routeForm.setOrigin(this.controlPointService.constructCreate(this.controlPointService.create(), route));
			final ControlPoint cp = this.controlPointService.create();
			cp.setArrivalOrder(1);
			ControlPointFormCreate cpfc = this.controlPointService.constructCreate(cp, route);
			cpfc.setEstimatedTime(1);
			routeForm.setDestination(cpfc);
			routeForm.setControlpoints(new ArrayList<ControlPointFormCreate>());
		} else {
			final LinkedList<ControlPoint> cps = new LinkedList<ControlPoint>(route.getControlPoints());
			routeForm.setOrigin(this.controlPointService.constructCreate(cps.removeFirst(), route));
			routeForm.setDestination(this.controlPointService.constructCreate(cps.removeLast(), route));
			routeForm.setControlpoints(new ArrayList<ControlPointFormCreate>());

			for (final ControlPoint cp : cps) {
				routeForm.getControlpoints().add(this.controlPointService.constructCreate(cp, route));
			}
		}
		routeForm.setDepartureDate(route.getDepartureDate());
		routeForm.setDetails(route.getDetails());
		routeForm.setDistance(route.getDistance());
		routeForm.setMaxLuggage(route.getMaxLuggage());
		routeForm.setPricePerPassenger(route.getPricePerPassenger());
		routeForm.setVehicle(route.getVehicle());

		return routeForm;
	}

	public Route reconstruct(RouteForm routeForm, Driver driver, BindingResult binding) {
		Assert.notNull(driver);
		Assert.notNull(routeForm);
//		Assert.notNull(routeForm.getOrigin());
//		Assert.notNull(routeForm.getDestination());
//		Assert.notNull(routeForm.getVehicle());
//		Assert.isTrue(routeForm.getAvailableSeats() < routeForm.getVehicle().getSeatsCapacity());
//		Assert.isTrue(routeForm.getDepartureDate().after(new Date(new Date().getTime() + 960000l))); // 16 minutos en ms
//		Assert.isTrue(routeForm.getVehicle().getDriver().getId() == driver.getId());
		boolean keepGoing = true;
		if (routeForm.getAvailableSeats() >= routeForm.getVehicle().getSeatsCapacity()) {
			binding.rejectValue("availableSeats", "route.error.seatsCapacity");
			keepGoing = false;
		}
		if (!routeForm.getDepartureDate().after(new Date(new Date().getTime() + 900000l))) {
			binding.rejectValue("departureDate", "route.error.dateTooSoon");
			keepGoing = false;
		}
		if (routeForm.getVehicle().getDriver().getId() != driver.getId()) {
			binding.rejectValue("vehicle", "route.error.incorrectVehicle");
			keepGoing = false;
		}
		
		Route result = null;
		if (keepGoing) {
			List<ControlPointFormCreate> cps = new ArrayList<ControlPointFormCreate>();
			cps.add(routeForm.getOrigin());
			if (routeForm.getControlpoints() != null) {
				for (ControlPointFormCreate cp : routeForm.getControlpoints()) {
					cps.add(cp);
				}
			}
			cps.add(routeForm.getDestination());
			List<ControlPoint> controlPoints = this.controlPointService.reconstructCreate(cps, routeForm.getDepartureDate());
	
			double routeDistance = 0d;
			for (ControlPoint cp : controlPoints) {
				routeDistance += cp.getDistance();
			}
	
			int estimatedDuration = 0;
			for (ControlPointFormCreate cp : cps) {
				estimatedDuration += cp.getEstimatedTime();
			}
			/*
			 * for (ControlPoint cp : controlPoints) {
			 * routeDistance += cp.getDistance();
			 * if (lastTime != 0l) {
			 * estimatedDuration += TimeUnit.MINUTES.convert(cp.getArrivalTime().getTime() - lastTime, TimeUnit.MILLISECONDS);
			 * }
			 * lastTime = cp.getArrivalTime().getTime();
			 * }
			 */
	
			double pricePerPassenger = 1.10d;
			if (routeDistance > 9d) {
				pricePerPassenger += Math.floor(routeDistance - 9d) * 0.11d;
			}
			pricePerPassenger = DoubleRounder.round(pricePerPassenger, 2);
	
			result = this.create();
	
			result.setAvailableSeats(routeForm.getAvailableSeats());
			result.setDaysRepeat(null);
			result.setDepartureDate(routeForm.getDepartureDate());
			result.setDetails(routeForm.getDetails());
			result.setDriver(driver);
			result.setId(0);
			result.setIsCancelled(false);
			result.setVehicle(routeForm.getVehicle());
			result.setVersion(0);
	
			result.setControlPoints(controlPoints);
			//		result.setDestination(controlPoints.last().getLocation());
			result.setDestination(controlPoints.get(controlPoints.size() - 1).getLocation());
			result.setDistance(routeDistance);
			result.setEstimatedDuration(estimatedDuration);
			//		result.setOrigin(controlPoints.first().getLocation());
			result.setOrigin(controlPoints.get(0).getLocation());
			result.setPricePerPassenger(pricePerPassenger);
			result.setReservations(null);
		}

		return result;
	}

}
