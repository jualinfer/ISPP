package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import repositories.PassengerRepository;
import domain.Passenger;

@Component
@Transactional
public class StringToPassengerConverter extends StringToGenericConverter<Passenger, PassengerRepository> {

}