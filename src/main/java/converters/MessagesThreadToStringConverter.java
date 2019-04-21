package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import domain.MessagesThread;

@Component
@Transactional
public class MessagesThreadToStringConverter extends GenericToStringConverter<MessagesThread> {

}