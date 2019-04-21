package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import domain.Message;

@Component
@Transactional
public class MessageToStringConverter extends GenericToStringConverter<Message> {

}