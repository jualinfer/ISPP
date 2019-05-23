
package domain;

public enum TypeAlert {

	APPLICATION_PLACE("APPLICATION_PLACE", 1), ACCEPTANCE_PLACE("ACCEPTANCE_PLACE", 2), REJECTION_PLACE("REJECTION_PLACE", 3), CANCELLATION_ROUTE("CANCELLATION_ROUTE", 4), CANCELLATION_PLACE("CANCELLATION_PLACE", 5), SYSTEM_NEWS("SYSTEM_NEWS", 6);

	private int		id;
	private String	name;


	private TypeAlert(final String name, final int id) {
		this.name = name;
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(final String name) {
		this.name = name;
	}

	public int getId() {
		return this.id;

	}
}
