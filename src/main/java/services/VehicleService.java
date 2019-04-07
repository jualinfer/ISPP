
package services;

import java.util.ArrayList;
import java.util.Collection;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import repositories.VehicleRepository;
import domain.Actor;
import domain.Driver;
import domain.Vehicle;
import domain.VehicleType;

@Service
@Transactional
public class VehicleService {

	//Managed repository

	@Autowired
	private VehicleRepository	vehicleRepository;

	//Supporting Services

	@Autowired
	private ActorService		actorService;
	@Autowired
	private RouteService		routeService;

	@Autowired
	private DriverService		driverService;


	//Constructor
	public VehicleService() {
		super();
	}

	//CRUD

	public Vehicle create() {
		Vehicle result;

		result = new Vehicle();
		result.setSeatsCapacity(2);
		result.setType(VehicleType.CAR);

		return result;
	}

	public Collection<Vehicle> findAll() {
		Collection<Vehicle> result;

		result = this.vehicleRepository.findAll();

		return result;
	}

	public Vehicle findOne(final int vehicleId) {
		Assert.isTrue(vehicleId != 0);

		Vehicle result;

		result = this.vehicleRepository.findOne(vehicleId);

		return result;
	}

	public Vehicle save(final Vehicle vehicle) {
		Assert.notNull(vehicle);
		Assert.notNull(vehicle.getModel());
		Assert.isTrue(!vehicle.getModel().isEmpty());
		Assert.notNull(vehicle.getVehicleBrand());
		Assert.isTrue(!vehicle.getVehicleBrand().isEmpty());
		Assert.notNull(vehicle.getSeatsCapacity());
		Assert.isTrue(vehicle.getSeatsCapacity() > 0);
		Assert.notNull(vehicle.getType());
		Assert.notNull(vehicle.getPlate());
		Assert.isTrue(!vehicle.getPlate().isEmpty());
		Assert.notNull(vehicle.getDriver());

		Vehicle result;
		Actor principal;

		//Comprobamos que hay un usuario registrado
		principal = this.actorService.findByPrincipal();
		Assert.notNull(principal);

		result = this.vehicleRepository.save(vehicle);

		return result;
	}

	//	public void savePhoto(final Vehicle vehicle) {
	//		Assert.notNull(vehicle);
	//
	//		Actor principal;
	//
	//		//Comprobamos que hay un usuario registrado y es el conductor del vehiculo
	//		principal = this.actorService.findByPrincipal();
	//		Assert.notNull(principal);
	//		Assert.isTrue(principal.getId() == vehicle.getDriver().getId());
	//	}

	public void delete(final Vehicle vehicle) {
		Actor principal;
		Driver driver;
		final Collection<Vehicle> vehiclesDriver;

		//Comprobamos que el usuario registrado es el conductor del vehiculo
		driver = vehicle.getDriver();
		principal = this.actorService.findByPrincipal();
		Assert.notNull(principal);
		Assert.isTrue(principal instanceof Driver);
		Assert.isTrue(principal.getId() == driver.getId());

		//Comprobamos que no se elimina estando asignado a una ruta
		Assert.isTrue(vehicle.getRoutes().isEmpty());

		//Si se borra el vehiculo, se elimina de la lista de vehiculos del conductor
		vehiclesDriver = driver.getVehicles();
		vehiclesDriver.remove(vehicle);
		this.driverService.save(driver);

		this.vehicleRepository.delete(vehicle);
	}

	//Other business methods

	public Collection<Vehicle> findVehiclesByDriver(final int driverId) {
		Assert.isTrue(driverId != 0);

		Collection<Vehicle> result;
		Driver driver;

		result = new ArrayList<Vehicle>();
		driver = this.driverService.findOne(driverId);
		if (!driver.getVehicles().isEmpty())
			result = this.vehicleRepository.findVehiclesByDriver(driverId);

		return result;
	}

}
