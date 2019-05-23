
package repositories;

import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import domain.ControlPoint;

@Repository
public interface ControlPointRepository extends JpaRepository<ControlPoint, Integer> {

	@Query("select cp from ControlPoint cp where cp.route.id = ?1")
	Collection<ControlPoint> findByRouteId(int routeId);
	
}
