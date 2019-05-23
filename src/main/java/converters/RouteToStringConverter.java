package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import domain.Route;

@Component
@Transactional
public class RouteToStringConverter extends GenericToStringConverter<Route> {
	
}