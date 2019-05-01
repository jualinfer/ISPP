
package repositories;

import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import domain.Reservation;
import domain.ReservationStatus;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Integer> {

	@Query("select r from Reservation r where r.passenger.id=?1")
	Collection<Reservation> findReservationsByPassenger(int passengerId);

	@Query("select r from Reservation r where r.route.id=?1")
	Collection<Reservation> findReservationsByRoute(int routeId);
	
	@Query("select r from Reservation r where r.route.id=?1 and r.status=?2")
	Collection<Reservation> findReservationsByRouteAndStatus(int routeId, ReservationStatus status);
	
	@Query("select r from Reservation r where r.route.id=?1 and r.passenger.id=?2")
	Collection<Reservation> findReservationsByRouteAndPassenger(int routeId, int passengerId);
	
	@Query("select r from Reservation r where r.route.id=?1 and (r.status=?2 or r.status=?3)")
	Collection<Reservation> findReservationsByRouteAndStatusPendingOrAccepted(int routeId, ReservationStatus pending, ReservationStatus accepted);
	
}
