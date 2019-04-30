package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import repositories.ActorRepository;
import domain.Actor;

@Component
@Transactional
public class StringToActorConverter extends StringToGenericConverter<Actor, ActorRepository> {

}
