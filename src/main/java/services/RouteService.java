
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
	private ReservationService	reservationService;


	//Simple CRUD methods

	public Route create() {
		final Route r = new Route();

		final Driver d = (Driver) this.actorService.findByPrincipal();
		r.setDriver(d);
		r.setIsCancelled(false);
		r.setReservations(new ArrayList<Reservation>());
		r.setControlPoints(new ArrayList<ControlPoint>());
		r.setDaysRepeat("");
		r.setEstimatedDuration(1);

		return r;
	}

	public Route findOne(final int id) {
		Assert.notNull(id);

		return this.routeRepository.findOne(id);
	}

	public Collection<Route> findAll() {
		return this.routeRepository.findAll();
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

		return saved;
	}

	public Route save2(final Route r, final BindingResult binding) {
		Assert.notNull(r);
		Double distance = 0.0;
		Double price = 0.0;
		final Date date = new Date();
		Driver driver;
		Assert.isTrue(r.getDepartureDate().after(date));

		//Assertion that the user modifying this task has the correct privilege.

		if (this.actorService.findByPrincipal() instanceof Driver)
			Assert.isTrue(this.actorService.findByPrincipal().getId() == r.getDriver().getId());
		//Assertion that the avaliable seats  isn't a bigger value than the vehicle capacity

		driver = r.getDriver();
		boolean keepGoing = true;
		if (r.getAvailableSeats() >= r.getVehicle().getSeatsCapacity()) {
			binding.rejectValue("availableSeats", "route.error.seatsCapacity");
			keepGoing = false;
		}
		if (!r.getDepartureDate().after(new Date(new Date().getTime() + 900000l))) {
			binding.rejectValue("departureDate", "route.error.dateTooSoon");
			keepGoing = false;
		}
		if (r.getVehicle().getDriver().getId() != driver.getId()) {
			binding.rejectValue("vehicle", "route.error.incorrectVehicle");
			keepGoing = false;
		}

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
		Route saved = null;
		if (keepGoing) {
			final String origin = r.getOrigin();
			final String destination = r.getDestination();
			distance = this.getDistance(origin, destination);
			price = this.getPrice(distance);
			r.setPricePerPassenger(price);
			r.setDistance(distance);

			saved = this.routeRepository.save(saved);
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

}
