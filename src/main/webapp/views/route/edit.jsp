<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />
<spring:url value="/styles/route.css" var="routecss" />

<link href="${routecss}" rel="stylesheet" />
<script src="${routecss}"></script>
<link rel="stylesheet" href="/path/to/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css" />
<div class="text-center active-routes">
	<h3>Create route</h3>
</div>


<spring:message code="route.cancel"  var="cancel"/>
<security:authorize access="hasRole('DRIVER')">
	<center>
		<form:form action="${requestURI}" modelAttribute="route">
			<form:hidden path="id" />
			<form:hidden path="pricePerPassenger" />
			<form:hidden path="distance" />	
		
			<div class="col-sm-6 text-center" style="padding-top: 20px;">
				<div class="form-group">
					<form:label path="departureDate">
						<spring:message code="route.departureDate" var="routeDepartureDate" />
					</form:label>
					<div class="input-group date" id="datetimepicker"
						data-target-input="nearest">
						<form:input type="text" path="departureDate"
							class="form-control datetimepicker-input"
							data-target="#datetimepicker1" placeholder="${routeDepartureDate}"/>
						<div class="input-group-append" data-target="#datetimepicker"
							data-toggle="datetimepicker">
							<div class="input-group-text">
								<i class="fa fa-calendar"></i>
							</div>
						</div>
					</div>
					<form:errors path="departureDate" cssClass="error" />
				</div>
			</div>
			<script type="text/javascript">
				$(function() {
					$('#datetimepicker').datetimepicker({
						format : 'DD/MM/YYYY HH:mm',
						minDate : new Date()
					});
				});
			</script>



			<div class="form-group col-md-6">
				<small id="timeHelp" class="form-text text-muted"><spring:message code="aclaration"/></small>
				<div class="form-row align-items-center">
					<div class="col-auto">
						<button name="icon1" disabled style="border:0;background:transparent;">
							<img src="images/marcador.png" width="35px" height="40px" />
						</button>
					</div>
					<div class="col-7">
						<spring:message code="route.origin" var="routeOrigin"/>
						<form:input type="text" path="origin.location" class="form-control" placeholder="${routeOrigin}"/>
						<form:hidden path="origin.estimatedTime" />
						<form:hidden path="origin.arrivalOrder" />
						<form:hidden path="origin.distance" />
					</div>
					<div class="col-3">
						<div class="input-group">
							<form:input type="number" path="origin.estimatedTime" class="form-control" value="0" disabled="true" aria-describedy="originTime" />
							<div class="input-group-prepend">
								<span class="input-group-text" id="originTime"><spring:message code="minutes"/></span>
							</div>
						</div>
					</div>
				</div>
				<form:errors path="origin.location" cssClass="error" />
			</div>
			
			
			<jstl:choose>
				<jstl:when test="${empty route.controlpoints}">
				<!-- empty -->
				</jstl:when>
				<jstl:otherwise>
					<jstl:forEach items="${route.controlpoints}" var="cp" varStatus="status">
						<div class="form-group col-md-6">
							<div class="form-row align-items-center">
								<div class="col-auto">
									<button type="submit" name="remove_cp" formaction="controlpoint/driver/remove.do?index=${status.index}" 
										style="border:0;background:transparent;">
										<img src="images/marcador-delete.png" width="35px" height="40px" />
									</button>
								</div>
								<div class="col-7">
									<spring:message code="route.stop" var="routeStop" />
									<form:input type="text" path="controlpoints[${status.index}].location" class="form-control" placeholder="${routeStop} ${status.index + 1}" />
									<form:hidden path="controlpoints[${status.index}].arrivalOrder" />
									<form:hidden path="controlpoints[${status.index}].distance" />
								</div>
								<div class="col-3">
									<div class="input-group">
										<form:input type="number" path="controlpoints[${status.index}].estimatedTime" class="form-control" min="1" aria-describedy="controlpointTime${status.index}" />
										<div class="input-group-prepend">
											<span class="input-group-text" id="controlpointTime${status.index}"><spring:message code="minutes"/></span>
										</div>
									</div>
								</div>
							</div>
							<form:errors path="controlpoints[${status.index}].location" cssClass="error" />
							<form:errors path="controlpoints[${status.index}].estimatedTime" cssClass="error" />
						</div>
					</jstl:forEach>
				</jstl:otherwise>
			</jstl:choose>
			
			<div class="form-group col-md-6">
				<button type="submit" name="add_cp" formaction="controlpoint/driver/add.do" style="border:0;background:transparent;">
					<img src="images/marcador-add.png" width="35px" height="40px" /> <spring:message code="route.addStop" />
				</button>
			</div>
			
			<div class="form-group col-md-6">
				<div class="form-row align-items-center">
					<div class="col-auto">
						<button name="icon1" disabled style="border:0;background:transparent;">
							<img src="images/marcador-ok.png" width="35px" height="40px" />
						</button>
					</div>
					<div class="col-7">
						<spring:message code="route.destination" var="routeDestination"/>
						<form:input type="text" path="destination.location"  class="form-control" placeholder="${routeDestination}"/>
						<form:hidden path="destination.arrivalOrder" />
						<form:hidden path="destination.distance" />
					</div>
					<div class="col-3">
						<div class="input-group">
							<form:input type="number" path="destination.estimatedTime" class="form-control" min="1" aria-describedy="destinationTime" />
							<div class="input-group-prepend">
								<span class="input-group-text" id="destinationTime"><spring:message code="minutes"/></span>
							</div>
						</div>
						
					</div>
				</div>
				<form:errors path="destination.location" cssClass="error" />
				<form:errors path="destination.estimatedTime" cssClass="error" />
			</div>
			
			<div class="form-group col-md-6">
				<div class="input-group">
					<div class="input-group-prepend">
						<span class="input-group-text" id="routeVehicle"><spring:message code="route.vehicle" /></span>
					</div>
					<form:select path="vehicle" class="form-control" aria-describedby="routeVehicle">
						<form:option label="-------" value="0">
						</form:option>
						<form:options items="${vehicles}" itemLabel="model" itemValue="id"
							required="true" />
					</form:select>
				</div>
				<form:errors cssClass="error" path="vehicle" />
			</div>
			
			<div class="form-group col-md-6">
				<div class="input-group">
					<div class="input-group-prepend">
						<span class="input-group-text" id="routeAvailableSeats"><spring:message code="route.availableSeats" /></span>
					</div>
					<form:input type="number" path="availableSeats" class="form-control" aria-describedby="routeAvailableSeats" min="1" max="10"/>
				</div>
				<form:errors path="availableSeats" cssClass="error" />
			</div>

			<div class="form-group col-md-6">
				<div class="input-group">
					<div class="input-group-prepend">
						<span class="input-group-text" id="routeMaxLuggage"><spring:message code="route.maxLuggage" /></span>
					</div>
					<form:select path="maxLuggage" class="form-control" aria-describedby="routeMaxLuggage" >
						<form:option label="None" value="NOTHING" />
						<form:option label="Small" value="SMALL" />
						<form:option label="Medium" value="MEDIUM" />
						<form:option label="Big" value="BIG" />
					</form:select>
				</div>
				<form:errors path="maxLuggage" cssClass="error" />
			</div>

			<div class="form-group col-md-6">
				<form:label path="details">
					<spring:message code="route.details" />
				</form:label>
				<form:textarea path="details" class="form-control" />
				<form:errors cssClass="error" path="details" />
			</div>

			<div class="form-group col-md-6 text-center">
				<input type="submit" class="btn btn-success" value="<spring:message code="route.save" />" />
			
				<spring:message code="route.cancel" var="cancel"/>
				<a href="route/driver/listActive.do" class="btn btn-danger" ><jstl:out value="${cancel}" /></a>
			</div>

		</form:form>
	</center>
</security:authorize>