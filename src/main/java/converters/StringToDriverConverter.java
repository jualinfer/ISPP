package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import repositories.DriverRepository;
import domain.Driver;

@Component
@Transactional
public class StringToDriverConverter extends StringToGenericConverter<Driver, DriverRepository> {

}