package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import domain.Driver;

@Component
@Transactional
public class DriverToStringConverter extends GenericToStringConverter<Driver> {

}