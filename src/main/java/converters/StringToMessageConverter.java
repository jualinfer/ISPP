package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import repositories.MessageRepository;
import domain.Message;

@Component
@Transactional
public class StringToMessageConverter extends StringToGenericConverter<Message, MessageRepository> {

}