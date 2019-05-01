package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import repositories.CommentRepository;
import domain.Comment;

@Component
@Transactional
public class StringToCommentConverter extends StringToGenericConverter<Comment, CommentRepository> {

}