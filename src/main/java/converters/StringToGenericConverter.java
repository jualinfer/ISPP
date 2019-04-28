package converters;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.data.jpa.repository.JpaRepository;

import domain.DomainEntity;


public class StringToGenericConverter<T extends DomainEntity, R extends JpaRepository<T, Integer>> implements Converter<String, T> {

	// Constructor
	
	public StringToGenericConverter() {
		super();
	}
	
	// Repository
	
	@Autowired
	private R repository;
	
	// Converter
	
	@Override
	public T convert(String source) {
		T result = null;
		
		try {
			if (!StringUtils.isEmpty(source)) {
				result = repository.findOne(Integer.valueOf(source));
			}
		}
		catch (Throwable e) {
			throw new IllegalArgumentException(e);
		}
		
		return result;
	}
	
}