
package repositories;

import java.util.Collection;
import java.util.Date;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import domain.ReservationStatus;
import domain.Route;

@Repository
public interface RouteRepository extends JpaRepository<Route, Integer> {

	@Query("select r from Route r join r.reservations res where res.passenger.id=?1 and res.status != ?2 and res.status != ?3 and r.isCancelled = FALSE and res in(select res2 from res.passenger.reservations res2)")
	Collection<Route> findActiveRoutesByPassenger(int passengerId, ReservationStatus statusCancelled, ReservationStatus statusRejected);	//Cuando se llame desde el servicio se le pasará como parametro el estado de reserva cancelada Y denegada

	@Query("select r from Route r where r.driver.id=?1 and r.departureDate>?2 and r.isCancelled = FALSE ")
	Collection<Route> findActiveRoutesByDriver(int driverId, Date now);	//Cuando se llame desde el servicio se le pasará como parametro la fecha y hora actual

	@Query(value = "select * from Route where (is_cancelled = false) and (departure_date > now()) and (available_seats >= ?1)", nativeQuery = true)
	Collection<Route> searchRoutes(int availableSeats);
	
	@Query("select distinct r from Route r join r.controlPoints cp where r.isCancelled = false and r.departureDate > CURRENT_TIMESTAMP and lower(cp.location) like %?1% and cp.arrivalOrder != 0 and r.availableSeats >= ?2")
	Collection<Route> search(String destination, int availableSeats);
	
	@Query("select r from Route r where r.departureDate < CURRENT_TIMESTAMP and r.isCancelled = false")
	Collection<Route> findStartedRoutes();

}
