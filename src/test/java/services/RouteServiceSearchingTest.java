
package services;

import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.transaction.Transactional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.util.Assert;

import utilities.AbstractTest;
import domain.Finder;
import domain.LuggageSize;
import domain.Route;

@ContextConfiguration(locations = {
	"classpath:spring/junit.xml"
})
@RunWith(SpringJUnit4ClassRunner.class)
@Transactional
public class RouteServiceSearchingTest extends AbstractTest {

	// Servicios bajo Testeo
	@Autowired
	private RouteService	routeService;

	@Autowired
	private ActorService	actorService;


	@Override
	public void setUp() {
		Route route1, route2, route3, route10;
		Date newDate;

		//Ponemos en la ruta2 el mismo origen y destino
		route2 = this.routeService.findOne(this.getEntityId("route2"));
		route2.setOrigin("Avenida del Cid, Sevilla");

		route1 = this.routeService.findOne(this.getEntityId("route1"));
		route3 = this.routeService.findOne(this.getEntityId("route3"));
		route10 = this.routeService.findOne(this.getEntityId("route10"));

		newDate = new Date(new Date().getTime() + 10000000);

		route1.setDepartureDate(newDate);
		route3.setDepartureDate(newDate);
		route10.setDepartureDate(newDate);

	}

	@Test
	public void RouteSearch() {
		// Test del método de búsqueda de rutas a partir de un Finder
		Finder finder;
		Date date1, date2, date3;

		date1 = new GregorianCalendar(2019, Calendar.JUNE, 4, 12, 36).getTime();
		date2 = new GregorianCalendar(2019, Calendar.JUNE, 6, 12, 36).getTime();
		date3 = new GregorianCalendar(2019, Calendar.JUNE, 4, 12, 21).getTime();

		final Object testingData[][] = {
			{
				null, null, "calle falsa 1234", 1, null, null, null, null, null, null, null, null, null
			// Dest. F
			}, {
				"route1", null, "avenida", 1, null, null, null, null, null, null, null, null, null
			// Dest. + Seats T
			}, {
				"route1", IllegalArgumentException.class, "avenida", 5, null, null, null, null, null, null, null, null, null
			// Seats F
			}, {
				"route3", IllegalArgumentException.class, "wololo", 1, null, null, null, null, null, null, null, null, null
			// Res. F
			}, {
				"route1", null, "avenida", 1, "felipe", null, null, null, null, null, null, null, null
			// Orig. V
			}, {
				"route1", IllegalArgumentException.class, "avenida", 1, "avenida", null, null, null, null, null, null, null, null
			//Orig. F
			}, {
				"route2", null, "avenida", 1, "avenida", null, null, null, null, null, null, null, null
			// Dest. = Orig. V
			}, {
				"route1", null, "avenida", 1, null, false, null, null, null, null, null, null, null
			// Childs V
			}, {
				"route1", null, "avenida", 1, null, null, false, null, null, null, null, null, null
			// Music V
			}, {
				"route1", null, "avenida", 1, null, null, null, true, null, null, null, null, null
			// Pets V
			}, {
				"route1", null, "avenida", 1, null, null, null, null, true, null, null, null, null
			// Smoke V
			}, {
				"route1", null, "avenida", 1, null, false, false, true, true, null, null, null, null
			// los 4 anteriores juntos V
			}, {
				"route1", null, "avenida", 1, null, null, null, null, null, 1, null, null, null
			// Car V
			}, {
				"route1", IllegalArgumentException.class, "avenida", 1, null, null, null, null, null, 2, null, null, null
			// Bike F
			}, {
				"route10", IllegalArgumentException.class, "avenida", 1, null, null, null, null, null, 1, null, null, null
			// Car F
			}, {
				"route10", null, "avenida", 1, null, null, null, null, null, 2, null, null, null
			// Bike V
			}, {
				"route1", null, "avenida", 1, null, null, null, null, null, null, null, null, LuggageSize.NOTHING
			// Luggage T
			}, {
				"route1", IllegalArgumentException.class, "avenida", 1, null, null, null, null, null, null, null, null, LuggageSize.SMALL
			// Luggage F
			}, {
				"route1", IllegalArgumentException.class, "avenida", 1, null, null, null, null, null, null, null, null, LuggageSize.BIG
			// Luggage F
			}, {
				"route3", null, "reina", 1, null, null, null, null, null, null, null, null, LuggageSize.BIG
			// Luggage T
			}, {
				"route1", null, "avenida", 1, null, null, null, null, null, null, null, date1, null
			// Arrival Time T
			}, {
				"route1", IllegalArgumentException.class, "avenida", 1, null, null, null, null, null, null, null, date2, null
			// Arrival Time F
			}, {
				"route1", null, "avenida", 1, "felipe", null, null, null, null, null, date3, null, null
			// Departure Time T
			}, {
				"route1", IllegalArgumentException.class, "avenida", 1, "felipe", null, null, null, null, null, date2, null, null
			// Departure Time F
			}
		};

		for (int i = 0; i < testingData.length; i++) {
			finder = new Finder();

			// Formamos el finder con los datos que queramos, los campos obligatorios son el destino y los asientos(min 1)
			finder.setDestination((String) testingData[i][2]);
			finder.setAvailableSeats((Integer) testingData[i][3]);

			finder.setOrigin((String) testingData[i][4]);

			finder.setChilds((Boolean) testingData[i][5]);
			finder.setMusic((Boolean) testingData[i][6]);
			finder.setPets((Boolean) testingData[i][7]);
			finder.setSmoke((Boolean) testingData[i][8]);

			finder.setVehicleType((Integer) testingData[i][9]);
			finder.setLuggageSize((LuggageSize) testingData[i][12]);

			finder.setDepartureDate((Date) testingData[i][10]);
			finder.setArrivalDate((Date) testingData[i][11]);

			this.RouteSearchTemplate(finder, (String) testingData[i][0], (Class<?>) testingData[i][1]);
		}
	}
	public void RouteSearchTemplate(Finder finder, String routeBean, Class<?> expected) {

		Class<?> caught;
		Collection<Route> result;
		Route route;

		caught = null;

		try {
			result = this.routeService.searchRoutes(finder);

			if (routeBean != null) {
				route = this.routeService.findOne(this.getEntityId(routeBean));

				Assert.isTrue(result.contains(route));
			} else {
				Assert.isTrue(result.size() == 0);
			}
		} catch (Throwable oops) {
			caught = oops.getClass();
		}

		this.checkExceptions(expected, caught);

	}

}
