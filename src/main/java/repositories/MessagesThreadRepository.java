
package repositories;

import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import domain.MessagesThread;

@Repository
public interface MessagesThreadRepository extends JpaRepository<MessagesThread, Integer> {

	//	@Query("select distinct mt from MessagesThread mt join mt.messages m where ((mt.participantA.id = ?1 and m.fromAtoB = false and m.read = ?2) or (mt.participantB.id = ?1 and m.fromAtoB = true and m.read = ?2)) and mt.closed = ?3")
	//	Collection<MessagesThread> findMessagesThreadFromParticipantAndState(int participantId, boolean read, boolean closed);

	//	@Query("select mt from MessagesThread mt where mt.route.id = ?1 and ((mt.participantA.id = ?2 and mt.participantB.id = ?3) or (mt.participantA.id = ?3 and mt.participantB.id = ?2))")
	//	Collection<MessagesThread> findMessagesThreadFromParticipantsAndRoute(int routeId, int participant1Id, int participant2Id);

	@Query("select mt from MessagesThread mt where mt.reportedUser is null and (mt.participantA.id = ?1 or mt.participantB.id = ?1) order by mt.lastMessage.issueDate desc")
	Collection<MessagesThread> findMessagesThreadFromParticipant(int participantId);

	@Query("select mt from MessagesThread mt where mt.reportedUser is null and mt.newMessages > 0 and ((mt.participantA.id = ?1 and mt.lastMessage.fromAtoB = false) or (mt.participantB.id = ?1 and mt.lastMessage.fromAtoB = true)) order by mt.lastMessage.issueDate desc")
	Collection<MessagesThread> findUnreadMessagesThreadFromParticipant(int participantId);

	@Query("select mt from MessagesThread mt where mt.reportedUser is null and mt.newMessages = 0 and (mt.participantA.id = ?1 or mt.participantB.id = ?1) order by mt.lastMessage.issueDate desc")
	Collection<MessagesThread> findReadMessagesThreadFromParticipant(int participantId);

	@Query("select mt from MessagesThread mt where mt.route.id = ?1 and ((mt.participantA.id = ?2 and mt.participantB.id = ?3) or (mt.participantA.id = ?3 and mt.participantB.id = ?2))")
	MessagesThread findMessagesThreadFromParticipantsAndRoute(int routeId, int participant1Id, int participant2Id);

	@Query("select mt from MessagesThread mt where mt.route.id = ?1 and mt.reportedUser.id = ?3 and (mt.participantA.id = ?2 or mt.participantB.id = ?2)")
	MessagesThread findReportsThreadFromParticipantsAndRoute(int routeId, int reportingUserId, int reportedUserId);
	
	@Query("select mt from MessagesThread mt where mt.route.id = ?1 and mt.reportedUser != null")
	Collection<MessagesThread> findReportsThreadFromRoute(int routeId);

	@Query("select mt from MessagesThread mt where mt.reportedUser is not null and (mt.participantA.id = ?1 or mt.participantB.id = ?1) order by mt.lastMessage.issueDate desc")
	Collection<MessagesThread> findReportsThreadFromParticipant(int participantId);
	
}
