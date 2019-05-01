package forms;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

public class ControlPointFormCreate {

	public ControlPointFormCreate() {
		super();
	}
	
	private String	location;
	private Integer	arrivalOrder;
	private Integer estimatedTime;
	private Double	distance;
	
	@NotNull
	@NotBlank
	public String getLocation() {
		return location;
	}
	
	public void setLocation(String location) {
		this.location = location;
	}
	
	@NotNull
	@Min(0)
	public Integer getArrivalOrder() {
		return arrivalOrder;
	}
	
	public void setArrivalOrder(Integer arrivalOrder) {
		this.arrivalOrder = arrivalOrder;
	}
	
	@NotNull
	@Min(0)
	public Integer getEstimatedTime() {
		return estimatedTime;
	}
	
	public void setEstimatedTime(Integer estimatedTime) {
		this.estimatedTime = estimatedTime;
	}
	
	@NotNull
	@Min(0)
	public Double getDistance() {
		return distance;
	}
	
	public void setDistance(Double distance) {
		this.distance = distance;
	}

}
