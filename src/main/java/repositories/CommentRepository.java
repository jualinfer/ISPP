
package repositories;

import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import domain.Comment;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Integer> {

	@Query("select c from Comment c where c.fromDriver = false and c.passenger.id = ?1")
	Collection<Comment> findCommentsMadeByPassenger(int passengerId);

	@Query("select c from Comment c where c.fromDriver = true and c.driver.id = ?1")
	Collection<Comment> findCommentsMadeByDriver(int driverId);

	@Query("select c from Comment c where c.fromDriver = true and c.passenger.id = ?1")
	Collection<Comment> findCommentsMadeToPassenger(int passengerId);

	@Query("select c from Comment c where c.fromDriver = false and c.driver.id = ?1")
	Collection<Comment> findCommentsMadeToDriver(int driverId);

	@Query(value = "select cast(avg(c.star) as decimal(16,2)) from Comment c where c.from_driver = false and driver = ?1", nativeQuery = true)
	Double avgStarsFromDriver(int driverId);

	@Query(value = "select cast(avg(c.star) as decimal(16,2)) from Comment c where c.from_driver = true and passenger = ?1", nativeQuery = true)
	Double avgStarsFromPassenger(int passengerId);

	@Query("select c from Comment c where c.fromDriver = true and c.route.id = ?1 and c.passenger.id = ?2 and c.driver.id = ?3")
	Comment findCommentFromDriver(int routeId, int passengerId, int driverId);

	@Query("select c from Comment c where c.fromDriver = false and c.route.id = ?1 and c.passenger.id = ?2 and c.driver.id = ?3")
	Comment findCommentFromPassenger(int routeId, int passengerId, int driverId);

}
