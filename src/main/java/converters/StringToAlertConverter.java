
package converters;

import javax.transaction.Transactional;

import org.springframework.stereotype.Component;

import repositories.AlertRepository;
import domain.Alert;

@Component
@Transactional
public class StringToAlertConverter extends StringToGenericConverter<Alert, AlertRepository> {

}
