
package repositories;

import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import domain.Passenger;

@Repository
public interface PassengerRepository extends JpaRepository<Passenger, Integer> {

	@Query("select r.passenger from Reservation r where r.status = 1 and r.route.id = ?1")
	Collection<Passenger> findPassengersAcceptedByRoute(int routeId);

}
