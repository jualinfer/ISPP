package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import repositories.ControlPointRepository;
import domain.ControlPoint;

@Component
@Transactional
public class StringToControlPointConverter extends StringToGenericConverter<ControlPoint, ControlPointRepository> {

}