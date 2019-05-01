
package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import domain.Alert;

@Component
@Transactional
public class AlertToStringConverter extends GenericToStringConverter<Alert> {

}
