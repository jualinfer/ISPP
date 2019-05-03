
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
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.decimal4j.util.DoubleRounder;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;

import repositories.RouteRepository;
import utilities.StripeConfig;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Payout;
import com.stripe.model.Refund;

import domain.Alert;
import domain.ControlPoint;
import domain.Driver;
import domain.Finder;
import domain.LuggageSize;
import domain.MessagesThread;
import domain.Passenger;
import domain.Reservation;
import domain.ReservationStatus;
import domain.Route;
import domain.TypeAlert;
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
	private DriverService		driverService;

	@Autowired
	private AlertService		alertService;
	
	@Autowired
	private MessagesThreadService		messagesThreadService;
	
	@Autowired
	private PassengerService		passengerService;
	
	private StripeConfig		stripeConfig;
	
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

	public Finder createFinder() {
		final Finder result = new Finder();
		result.setAvailableSeats(1);
		//		result.setDepartureDate(new Date(new Date().getTime() + 600000));
		return result;
	}

	public Route findOne(final int id) {
		Assert.isTrue(id > 0);
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

		if (this.actorService.findByPrincipal() instanceof Driver) {
			final Driver driver = saved.getDriver();

			final Collection<Route> routes = driver.getRoutes();
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
		if (this.actorService.findByPrincipal() instanceof Driver)
			Assert.isTrue(this.actorService.findByPrincipal().getId() == route.getDriver().getId());
		// Comprobar que la ruta no ha sido previamente cancelada
		Assert.isTrue(!route.getIsCancelled());
		// Comprobar que la ruta no ha comenzado o finalizado
		Assert.isTrue(route.getDepartureDate().after(new Date()));

		// Cancelar solicitudes pendientes y aceptadas
		this.reservationService.autoReject(route);

		route.setIsCancelled(true);

		//We create an alert
		final Collection<Reservation> reservations = route.getReservations();
		for (final Reservation r : reservations) {
			final Passenger p = r.getPassenger();
			final Alert alert = this.alertService.create();
			alert.setReceiver(p);
			alert.setTypeAlert(TypeAlert.CANCELLATION_ROUTE);
			alert.setRelatedRoute(route);

			this.alertService.save(alert);
		}

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

	public Integer getDurationMinutes(final String origin, final String destination) {
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
			final JSONObject obj3 = obj2.getJSONObject("duration");
			value = obj3.getDouble("value");
			value = value / 60;
		} catch (final Exception e) {
			e.printStackTrace();
		}
		return value.intValue();
	}
	/*
	 * public Double getPrice(final Double distance) {
	 * Double price = 0.0;
	 * final Double price3km = 0.33;
	 * final Double profit = 0.10;
	 * if (distance < 9.0)
	 * price = 1 + profit;
	 * else {
	 * final String str = String.valueOf(distance / 3);
	 * final Integer intNumber = Integer.parseInt(str.substring(0, str.indexOf('.')));
	 * price = intNumber * price3km + profit;
	 * 
	 * }
	 * return DoubleRounder.round(price, 2);
	 * }
	 */

	public Double getPrice(final double distance) {
		Assert.isTrue(distance >= 0);
		double result = 1.1d;
		if (distance > 9d)
			result += (distance - 9d) * 0.11d;
		return DoubleRounder.round(result, 2);
	}

	public Integer getCurrentAvailableSeats(final int routeId) {
		return this.getCurrentAvailableSeats(this.findOne(routeId));
	}

	public Integer getCurrentAvailableSeats(final Route route) {
		Assert.notNull(route);
		Assert.isTrue(route.getId() > 0);
		final Collection<Reservation> reservations = this.reservationService.findReservationsByRouteAndStatus(route.getId(), ReservationStatus.ACCEPTED);
		int occupiedSeats = 0;
		for (final Reservation r : reservations)
			occupiedSeats += r.getSeat();
		return route.getAvailableSeats() - occupiedSeats;
	}

	//Finder

	public Collection<Route> searchRoutes(final Finder finder, final BindingResult binding) {
		Assert.notNull(finder);
		Assert.notNull(binding);

		Collection<Route> queryResult = null;
		queryResult = this.routeRepository.search(finder.getDestination(), finder.getAvailableSeats());
		final Collection<Route> result = new ArrayList<Route>();

		for (final Route r : queryResult) {
			// Filtrar por preferencias
			if (finder.getChilds() && !r.getDriver().getChilds())
				continue;
			if (finder.getMusic() && !r.getDriver().getMusic())
				continue;
			if (finder.getPets() && !r.getDriver().getPets())
				continue;
			if (finder.getSmoke() && !r.getDriver().getSmoke())
				continue;

			// Filtrar por vehículo
			if (finder.getVehicleType() != null) {
				if (finder.getVehicleType() == 1 && r.getVehicle().getType() != VehicleType.CAR)
					continue;
				if (finder.getVehicleType() == 2 && r.getVehicle().getType() != VehicleType.BIKE)
					continue;
			}

			// Filtrar por tamaño del equipaje
			if (finder.getLuggageSize() != null && r.getMaxLuggage().getId() < finder.getLuggageSize().getId())
				continue;

			// Filtrar por asientos disponibles
			int availableSeats = r.getAvailableSeats();
			for (final Reservation re : r.getReservations())
				if (re.getStatus() == ReservationStatus.ACCEPTED)
					availableSeats -= re.getSeat();
			if (availableSeats < finder.getAvailableSeats())
				continue;

			// Obtener el controlpoint de destino
			final String destinationLocation = finder.getDestination().trim().toLowerCase();
			ControlPoint destination = null;
			for (final ControlPoint cp : r.getControlPoints())
				if (cp.getLocation().toLowerCase().contains(destinationLocation))
					destination = cp;

			// Filtrar por fecha y hora de llegada
			if (finder.getArrivalDate() != null) {
				final Date minTime = new Date(finder.getArrivalDate().getTime() - 900000);
				final Date maxTime = new Date(finder.getArrivalDate().getTime() + 900000);
				if (destination.getArrivalTime().before(minTime) || destination.getArrivalTime().after(maxTime))
					continue;
			}

			// Filtrar por origen
			ControlPoint origin = null;
			if (finder.getOrigin() != null && !finder.getOrigin().trim().isEmpty()) {
				final String originLocation = finder.getOrigin().trim().toLowerCase();
				for (final ControlPoint cp : r.getControlPoints())
					if (cp.getLocation().toLowerCase().contains(originLocation)) {
						origin = cp;
						break;
					}
				// No existe la ubicación de origen en la ruta, o es una parada posterior al destino
				if (origin == null || destination.getArrivalOrder() <= origin.getArrivalOrder())
					continue;
			}

			// Filtrar por fecha de salida
			if (finder.getDepartureDate() != null && origin != null) {
				final Date minTime = new Date(finder.getDepartureDate().getTime() - 900000);
				final Date maxTime = new Date(finder.getDepartureDate().getTime() + 900000);
				if (origin.getArrivalTime().before(minTime) || origin.getArrivalTime().after(maxTime))
					continue;
			}

			result.add(r);
		}

		return result;
	}

	/*
	 * public Collection<Route> searchRoutes2(final Finder finder) {
	 * 
	 * this.validateFinder(finder);
	 * 
	 * Collection<Route> queryResult, finalResult;
	 * 
	 * final Date departureDate = finder.getDepartureDate();
	 * final LocalTime timeStart = finder.getOriginTime();
	 * final LocalTime timeEnds = finder.getDestinationTime();
	 * final Integer availableSeats = finder.getAvailableSeats();
	 * final Boolean pets = finder.getPets();
	 * final Boolean childs = finder.getChilds();
	 * final Boolean smoke = finder.getSmoke();
	 * final Boolean music = finder.getMusic();
	 * final LuggageSize luggageSize = finder.getLuggageSize();
	 * VehicleType vehicleType = null;
	 * 
	 * final Integer vehicleTypeInteger = finder.getVehicleType();
	 * 
	 * if (vehicleTypeInteger != 0)
	 * vehicleType = finder.getVehicleTypeById(vehicleTypeInteger);
	 * 
	 * // En los set de origin y destination, se ponen como "" o lo que sea en minusculas
	 * final String origin = finder.getOrigin();
	 * final String destination = finder.getDestination();
	 * 
	 * final Calendar departureDateFinder = Calendar.getInstance();
	 * 
	 * if (departureDate != null)
	 * departureDateFinder.setTime(departureDate);
	 * 
	 * // Buscamos todas las rutas no canceladas futuras
	 * queryResult = this.routeRepository.searchRoutes(availableSeats);
	 * finalResult = new ArrayList<Route>();
	 * 
	 * final Calendar rutaActual = Calendar.getInstance();
	 * 
	 * for (final Route r : queryResult) {
	 * 
	 * rutaActual.setTime(r.getDepartureDate());
	 * 
	 * // Primero filtramos por FECHA Y HORA:
	 * if (departureDate != null && rutaActual.get(Calendar.DAY_OF_YEAR) != departureDateFinder.get(Calendar.DAY_OF_YEAR))
	 * continue;
	 * 
	 * final LocalTime departureTime = LocalTime.fromDateFields(r.getDepartureDate());
	 * 
	 * if (timeStart != null && departureTime.isBefore(timeStart))
	 * // Si la hora de inicio de la ruta es anterior a la del finder, ignorar esta ruta
	 * continue;
	 * 
	 * if (timeEnds != null && departureTime.isAfter(timeEnds))
	 * //Si la hora de fin de la ruta es posterior a la del finder, ignorar esta ruta
	 * continue;
	 * 
	 * // Luego por origen y destino:
	 * 
	 * if (origin != "" && !r.getOrigin().toLowerCase().contains(origin))
	 * continue;
	 * 
	 * if (destination != "" && !r.getDestination().toLowerCase().contains(destination))
	 * continue;
	 * 
	 * // Después smoke, pets, childs, music
	 * 
	 * final Driver driver = r.getDriver();
	 * 
	 * if (smoke && !driver.getSmoke())
	 * continue;
	 * 
	 * if (pets && !driver.getPets())
	 * continue;
	 * 
	 * if (childs && !driver.getChilds())
	 * continue;
	 * 
	 * if (music && !driver.getMusic())
	 * continue;
	 * 
	 * // Y por ultimo LuggageSize y VehicleType
	 * if (vehicleType != null && r.getVehicle().getType() != vehicleType)
	 * continue;
	 * 
	 * if (luggageSize != null && r.getMaxLuggage().getId() < luggageSize.getId())
	 * continue;
	 * 
	 * finalResult.add(r);
	 * 
	 * }
	 * 
	 * return finalResult;
	 * }
	 * 
	 * private void validateFinder(final Finder finder) {
	 * 
	 * Assert.notNull(finder);
	 * 
	 * // Origen o destino deben estar presentes
	 * Assert.isTrue(!finder.getDestination().isEmpty());
	 * 
	 * // La hora minima de salida debe ser inferior a la hora máxima de salida
	 * if (finder.getOriginTime() != null && finder.getDestinationTime() != null)
	 * Assert.isTrue((finder.getOriginTime().isBefore(finder.getDestinationTime())));
	 * 
	 * //Solamente podemos buscar rutas que sean del día actual hasta el futuro
	 * if (finder.getDepartureDate() != null) {
	 * final Calendar de = Calendar.getInstance();
	 * final Calendar now = Calendar.getInstance();
	 * de.setTime(finder.getDepartureDate());
	 * now.setTime(new Date());
	 * Assert.isTrue(de.get(Calendar.DAY_OF_YEAR) >= now.get(Calendar.DAY_OF_YEAR));
	 * }
	 * }
	 */

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
	
	public Collection<Route> findFinalizedRoutes(final Date now) {
		Assert.notNull(now);

		Collection<Route> result;

		result = this.routeRepository.findFinalizedRoutes(now);

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
			final ControlPointFormCreate cpfc = this.controlPointService.constructCreate(cp, route);
			cpfc.setEstimatedTime(1);
			routeForm.setDestination(cpfc);
			routeForm.setControlpoints(new ArrayList<ControlPointFormCreate>());
		} else {
			final LinkedList<ControlPoint> cps = new LinkedList<ControlPoint>(route.getControlPoints());
			routeForm.setOrigin(this.controlPointService.constructCreate(cps.removeFirst(), route));
			routeForm.setDestination(this.controlPointService.constructCreate(cps.removeLast(), route));
			routeForm.setControlpoints(new ArrayList<ControlPointFormCreate>());

			for (final ControlPoint cp : cps)
				routeForm.getControlpoints().add(this.controlPointService.constructCreate(cp, route));
		}
		routeForm.setDepartureDate(route.getDepartureDate());
		routeForm.setDetails(route.getDetails());
		routeForm.setDistance(route.getDistance());
		routeForm.setMaxLuggage(route.getMaxLuggage());
		routeForm.setPricePerPassenger(route.getPricePerPassenger());
		routeForm.setVehicle(route.getVehicle());

		return routeForm;
	}

	public Route reconstruct(final RouteForm routeForm, final Driver driver, final BindingResult binding) {
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
			final List<ControlPointFormCreate> cps = new ArrayList<ControlPointFormCreate>();
			cps.add(routeForm.getOrigin());
			if (routeForm.getControlpoints() != null)
				for (final ControlPointFormCreate cp : routeForm.getControlpoints())
					cps.add(cp);
			cps.add(routeForm.getDestination());
			final List<ControlPoint> controlPoints = this.controlPointService.reconstructCreate(cps, routeForm.getDepartureDate());

			Double routeDistance = 0d;
			for (final ControlPoint cp : controlPoints)
				routeDistance += cp.getDistance();
			routeDistance = DoubleRounder.round(routeDistance, 2);

			Integer estimatedDuration = 0;
			for (final ControlPointFormCreate cp : cps)
				estimatedDuration += cp.getEstimatedTime();

			final double pricePerPassenger = this.getPrice(routeDistance);

			result = this.create();

			result.setAvailableSeats(routeForm.getAvailableSeats());
			result.setDaysRepeat(null);
			result.setDepartureDate(routeForm.getDepartureDate());
			result.setMaxLuggage(routeForm.getMaxLuggage());
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
	
	public void cronCompleteRoutes(){
//		try {
			Date now = new Date();
			Reservation reservation = null;
	    	Long millisPerDay =  24 * 60 * 60 * 1000L;
	    	Collection<Route> completedAfterDayRoutes = new ArrayList<Route>();
	    	
	    	//Obtenemos las rutas completadas 
	    	Collection<Route> completedRoutes = findFinalizedRoutes(new Date());
	    	
	    	//De las rutas completadas sacamos las que ya hayan pasado 24h 
	    	for(Route route: completedRoutes){
	    		Calendar departureDate = Calendar.getInstance();
	    		departureDate.setTime(route.getDepartureDate());
	    		Integer estimatedDuration = route.getEstimatedDuration();
	    		
	    		departureDate.add(Calendar.MINUTE, estimatedDuration);
	    		Date completedDate = departureDate.getTime();
	    		
	    		boolean moreThanDay = Math.abs(now.getTime() - completedDate.getTime()) > millisPerDay;
	    		if(moreThanDay){
	    			completedAfterDayRoutes.add(route);
	    		}
	    	}
	    	
	    	for(Route route: completedAfterDayRoutes){
	    		Collection<Passenger> passengersByRoute = new ArrayList<Passenger>();
	    		
	    		passengersByRoute.addAll(passengerService.findPassengersAcceptedByRoute(route.getId()));
	    		
	    		//Comprobamos si los passengers han abierto algún report al driver y obtenemos las reservas que no se han pagado todavía
	    		for(Passenger passenger: passengersByRoute){
	    			boolean driverNoPickedMe = false;
	    			List<Reservation> reservationOfPassenger = new ArrayList<Reservation>();
	    			MessagesThread report = messagesThreadService.findReportsThreadFromParticipantsAndRoute(
	    					route.getId(), passenger.getId(), route.getDriver().getId());
	    			
	    			reservationOfPassenger.addAll(reservationService.findReservationsByRoutePassengerAndNotPaymentResolved(
	    					route.getId(), passenger.getId()));
	    			
	    			if(!reservationOfPassenger.isEmpty()){
	    				reservation = reservationOfPassenger.get(0);
	    				driverNoPickedMe = reservation.isDriverNoPickedMe();
	    			}
	
	    			//En caso de que el passenger no haya creado ningún report y le hayan recogido se realiza el pago al driver
	    			//En caso de que el passenger no haya creado ningún report y no le hayan recogido se realiza la devolución del pago al passenger
	    			if(report == null && reservation != null){
//	    				Stripe.apiKey = StripeConfig.SECRET_KEY;
//	    				if(!driverNoPickedMe){
//	    					//SE REALIZA EL PAGO AL DRIVER (PAYOUT)
//	    					final Map<String, Object> payoutParams = new HashMap<String, Object>();
//	    					final Double reservPrice = reservation.getPrice() * 100;
//	    					payoutParams.put("amount", Integer.toString(reservPrice.intValue()));
//	    					payoutParams.put("currency", StripeConfig.CURRENCY);
//
//	    					Payout.create(payoutParams);
//	    				}else{
//	    					//SE REALIZA LA DEVOLUCIÓN DEL PAGO AL PASSENGER (REFOUND)
//	    					final Map<String, Object> params = new HashMap<>();
//	    					params.put("charge", reservation.getChargeId());
//	    					final Refund refund2 = Refund.create(params);
//	    				}
//	    				reservation.setPaymentResolved(true);
//	    				reservationService.saveCron(reservation);
	        		}
    			}
			}
//		}catch (StripeException e) {
//			e.printStackTrace();
//		}
	}
}
