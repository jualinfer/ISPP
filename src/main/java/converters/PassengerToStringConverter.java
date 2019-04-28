package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import domain.Passenger;

@Component
@Transactional
public class PassengerToStringConverter extends GenericToStringConverter<Passenger> {

}