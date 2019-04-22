package repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import domain.MessagesThread;

@Repository
public interface MessagesThreadRepository extends JpaRepository<MessagesThread, Integer> {

//	@Query("select distinct m from MessagesThread m join fetch m.messages me where ((m.participantA = ?1 and me.AtoB = false and me.read = ?2) or (m.participantB = ?1 and me.AtoB = true and me.read = ?2)) and m.closed = ?3")
//	Collection<MessagesThread> findMessagesThreadFromParticipantAndState(int participantId, boolean read, boolean closed);
	
}
