package converters;

import org.springframework.core.convert.converter.Converter;

import domain.DomainEntity;


public class GenericToStringConverter<S extends DomainEntity> implements Converter<S, String> {
	
	// Constructor
	
	public GenericToStringConverter() {
		super();
	}
	
	// Converter
	
	@Override
	public String convert(S source) {
		String result = null;
		if (source != null) {
			result = String.valueOf(source.getId());
		}
		return result;
	}

}