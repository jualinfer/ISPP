package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import domain.ControlPoint;

@Component
@Transactional
public class ControlPointToStringConverter extends GenericToStringConverter<ControlPoint> {

}