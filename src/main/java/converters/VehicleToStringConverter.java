package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import domain.Vehicle;

@Component
@Transactional
public class VehicleToStringConverter extends GenericToStringConverter<Vehicle> {

}