package services;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import utilities.AbstractTest;
import domain.Driver;
import domain.Route;
import domain.Vehicle;
import domain.VehicleType;

@ContextConfiguration(locations = { "classpath:spring/junit.xml" })
@RunWith(SpringJUnit4ClassRunner.class)
@Transactional
public class VehicleServiceTest extends AbstractTest {

	// Servicios bajo Testeo
	@Autowired
	private VehicleService vehicleService;

	@Autowired
	private DriverService driverService;
	@Autowired
	private ActorService actorService;

	@Test
	public void createVehicle() {

		final Object testingData[][] = {

				{ "driver1", "modelo1", "brand", "image", 1, VehicleType.BIKE,
						"plate", "description", 2, null, "driver1@gmail.com" },
				{ "driver1", "modelo1", "brand", "image", 1, VehicleType.CAR,
						"plate", "description", 2, null, "driver1@gmail.com" },
				{ "driver1", "modelo1", "brand", "image", 10, VehicleType.BIKE,
						"plate", "description", 2,
						IllegalArgumentException.class, "driver1@gmail.com" },
				{ "passenger31", "modelo1", "brand", "image", 1,
						VehicleType.CAR, "plate", "description", 2,
						ClassCastException.class, "passenger31@gmail.com" },
				{ "driver200", "modelo1", "brand", "image", 1,
						VehicleType.BIKE, "plate", "description", 2,
						NumberFormatException.class, "driver200@gmail.com" },

		};

		for (int i = 0; i < testingData.length; i++) {
			this.createVehicleTemplate((String) testingData[i][0],
					(String) testingData[i][1], (String) testingData[i][2],
					(String) testingData[i][3], (int) testingData[i][4],
					(VehicleType) testingData[i][5],
					(String) testingData[i][6], (String) testingData[i][7],
					(int) testingData[i][8], (Class<?>) testingData[i][9],
					(String) testingData[i][10]);
		}
	}

	public void createVehicleTemplate(String driverBean, String model,
			String vehicleBrand, String image, int seatsCapacity,
			VehicleType vehivleType, String plate, String description,
			int version, Class<?> expected, String userAccount) {
		Class<?> caught;
		Driver driver;
		Vehicle vehicle = new Vehicle();
		caught = null;

		try {
			driver = (Driver) this.actorService.findOne(this
					.getEntityId(driverBean));

			vehicle.setDescription(description);
			vehicle.setDriver(driver);
			vehicle.setImage(image);
			vehicle.setModel(model);
			vehicle.setPlate(plate);
			vehicle.setSeatsCapacity(seatsCapacity);
			vehicle.setType(vehivleType);
			vehicle.setVehicleBrand(vehicleBrand);
			vehicle.setVersion(version);

			this.authenticate(userAccount);

			this.vehicleService.save(vehicle);
		} catch (Throwable oops) {
			caught = oops.getClass();
		}

		this.authenticate(null);

		this.checkExceptions(expected, caught);
	}

	@Test
	public void deleteVehicle() {

		final Object testingData[][] = {

		{ "driver1", 1068, null, "driver1@gmail.com" },
		 { "driver1", 1068, IllegalArgumentException.class, "driver123@gmail.com" },

		};

		for (int i = 0; i < testingData.length; i++) {
			this.deleteVehicleTemplate((String) testingData[i][0],
					(int) testingData[i][1], (Class<?>) testingData[i][2],
					(String) testingData[i][3]);
		}
	}

	public void deleteVehicleTemplate(String driverBean, int id,
			Class<?> expected, String userAccount) {
		Class<?> caught;
		Driver driver;
		Vehicle vehicle = this.vehicleService.findOne(id);
		caught = null;

		try {
			driver = (Driver) this.actorService.findOne(this
					.getEntityId(driverBean));

			this.authenticate(userAccount);
			List<Route> routes = new ArrayList<Route>();
			vehicle.setRoutes(routes);
			this.vehicleService.delete(vehicle);
		} catch (Throwable oops) {
			caught = oops.getClass();
		}

		this.authenticate(null);

		this.checkExceptions(expected, caught);
	}
	
	
	
	@Test
	public void findVehiclesByDriver() {

		final Object testingData[][] = {

		{ 968,  null, "driver1@gmail.com" },
		 { 968, IllegalArgumentException.class, "driver123@gmail.com" },
		 { 11, IllegalArgumentException.class, "driver123@gmail.com" },

		};

		for (int i = 0; i < testingData.length; i++) {
			this.findVehiclesByDriverTemplate((int) testingData[i][0],
					 (Class<?>) testingData[i][1],
					(String) testingData[i][2]);
		}
	}

	public void findVehiclesByDriverTemplate(int id,
			Class<?> expected, String userAccount) {
		Class<?> caught;
		caught = null;

		try {

			this.authenticate(userAccount);
			this.vehicleService.findVehiclesByDriver(id);
		} catch (Throwable oops) {
			caught = oops.getClass();
		}

		this.authenticate(null);

		this.checkExceptions(expected, caught);
	}

}
