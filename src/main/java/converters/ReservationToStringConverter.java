package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import domain.Reservation;

@Component
@Transactional
public class ReservationToStringConverter extends GenericToStringConverter<Reservation> {

}