package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import domain.Actor;

@Component
@Transactional
public class ActorToStringConverter extends GenericToStringConverter<Actor> {

}
