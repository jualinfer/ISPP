package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import repositories.RouteRepository;
import domain.Route;

@Component
@Transactional
public class StringToRouteConverter extends StringToGenericConverter<Route, RouteRepository> {

}