
package utilities;

import java.util.HashMap;
import java.util.Map;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Payout;
import com.stripe.model.Refund;

import domain.Reservation;

public class StripeConfig {

	public static final String PUBLIC_KEY = "pk_test_lx9QYYAhpwYKowZ5iqmKbs4Z00CaE1E067";
	public static final String SECRET_KEY = "sk_test_0bkVMJPAjHpW9u9YpxqM3yht00PfFHLjSJ";
	public static final String CURRENCY	  = "EUR";
	
	public void payout(Reservation reservation) throws StripeException{
		Stripe.apiKey = StripeConfig.SECRET_KEY;
		
		final Map<String, Object> payoutParams = new HashMap<String, Object>();
		final Double reservPrice = reservation.getPrice() * 100;
		payoutParams.put("amount", Integer.toString(reservPrice.intValue()));
		payoutParams.put("currency", StripeConfig.CURRENCY);

		Payout.create(payoutParams);
	}
	
	public void refound(Reservation reservation) throws StripeException{
		Stripe.apiKey = StripeConfig.SECRET_KEY;
		
		final Map<String, Object> params = new HashMap<>();
		params.put("charge", reservation.getChargeId());
		final Refund refund2 = Refund.create(params);
	}

}
