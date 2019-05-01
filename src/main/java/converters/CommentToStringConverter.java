package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import domain.Comment;

@Component
@Transactional
public class CommentToStringConverter extends GenericToStringConverter<Comment> {
	
}