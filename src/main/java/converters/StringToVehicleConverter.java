package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import repositories.VehicleRepository;
import domain.Vehicle;

@Component
@Transactional
public class StringToVehicleConverter extends StringToGenericConverter<Vehicle, VehicleRepository> {

}