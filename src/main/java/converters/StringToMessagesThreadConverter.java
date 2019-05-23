package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import repositories.MessagesThreadRepository;
import domain.MessagesThread;

@Component
@Transactional
public class StringToMessagesThreadConverter extends StringToGenericConverter<MessagesThread, MessagesThreadRepository>{

}