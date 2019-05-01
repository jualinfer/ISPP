package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import repositories.ReservationRepository;
import domain.Reservation;

@Component
@Transactional
public class StringToReservationConverter extends StringToGenericConverter<Reservation, ReservationRepository> {

}