<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link rel="stylesheet"
	href="/path/to/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css" />
<div class="text-center active-routes">
	<h3><spring:message code="createRoute" /></h3>
</div>


<spring:message code="route.cancel" var="cancel" />
<security:authorize access="hasRole('DRIVER')">
	<center>
		<form:form action="${requestURI}" modelAttribute="route">
			<form:hidden path="id" />
			<form:hidden path="pricePerPassenger" />
			<form:hidden path="distance" />

			<div class="col-sm-6 text-center" style="padding-top: 20px;">
				<div class="form-group">
					<spring:message code="route.departureDate" var="routeDepartureDate" />
					<div class="input-group date" id="datetimepicker"
						data-target-input="nearest">
						<form:input type="text" path="departureDate"
							class="form-control datetimepicker-input"
							data-target="#datetimepicker1"
							placeholder="${routeDepartureDate}" />
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
				<small id="timeHelp" class="form-text text-muted"><spring:message
						code="aclaration" /></small>
				<div class="form-row align-items-center">
					<div class="col-auto">
						<button name="icon1" disabled
							style="border: 0; background: transparent;">
							<img src="images/marcador.png" width="35px" height="40px" />
						</button>
					</div>
					<div class="col-7">
						<spring:message code="route.origin" var="routeOrigin" />
						<form:input type="text" path="origin.location"
							class="form-control" placeholder="${routeOrigin}"
							id="autocompleteOrigin" onFocus="geolocate()" />



						<form:hidden path="origin.estimatedTime" />
						<form:hidden path="origin.arrivalOrder" />
						<form:hidden path="origin.distance" />
					</div>
					<div class="col-3">
						<div class="input-group">
							<form:input type="number" path="origin.estimatedTime"
								class="form-control" value="0" disabled="true"
								aria-describedy="originTime" />
							<div class="input-group-prepend">
								<span class="input-group-text" id="originTime"><spring:message
										code="minutes" /></span>
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
					<jstl:forEach items="${route.controlpoints}" var="cp"
						varStatus="status">
						<div class="form-group col-md-6">
							<div class="form-row align-items-center">
								<div class="col-auto">
									<button type="submit" name="remove_cp"
										formaction="controlpoint/driver/remove.do?index=${status.index}"
										style="border: 0; background: transparent;">
										<img src="images/marcador-delete.png" width="35px"
											height="40px" />
									</button>
								</div>
								<div class="col-7">
									<spring:message code="route.stop" var="routeStop" />
									<form:input type="text"
										path="controlpoints[${status.index}].location"
										class="form-control"
										placeholder="${routeStop} ${status.index + 1}"
										id="autocomplete${status.index}" onFocus="geolocate()" />
									<form:hidden path="controlpoints[${status.index}].arrivalOrder" />
									<form:hidden path="controlpoints[${status.index}].distance" />
								</div>
								<div class="col-3">
									<div class="input-group">
										<form:input type="number"
											path="controlpoints[${status.index}].estimatedTime"
											class="form-control" min="1"
											aria-describedy="controlpointTime${status.index}" />
										<div class="input-group-prepend">
											<span class="input-group-text"
												id="controlpointTime${status.index}"><spring:message
													code="minutes" /></span>
										</div>
									</div>
								</div>
							</div>
							<form:errors path="controlpoints[${status.index}].location"
								cssClass="error" />
							<form:errors path="controlpoints[${status.index}].estimatedTime"
								cssClass="error" />
						</div>
					</jstl:forEach>
				</jstl:otherwise>
			</jstl:choose>

			<div class="form-group col-md-6">
				<button type="submit" name="add_cp"
					formaction="controlpoint/driver/add.do"
					style="border: 0; background: transparent;">
					<img src="images/marcador-add.png" width="35px" height="40px" />
					<spring:message code="route.addStop" />
				</button>
			</div>

			<div class="form-group col-md-6">
				<div class="form-row align-items-center">
					<div class="col-auto">
						<button name="icon1" disabled
							style="border: 0; background: transparent;">
							<img src="images/marcador-ok.png" width="35px" height="40px" />
						</button>
					</div>
					<div class="col-7">
						<spring:message code="route.destination" var="routeDestination" />
						<div id="locationField">
							<form:input type="text" path="destination.location"
								class="form-control" placeholder="${routeDestination}"
								id="autocompleteDestination" onFocus="geolocate()" />
						</div>
						<form:hidden path="destination.arrivalOrder" />
						<form:hidden path="destination.distance" />
					</div>
					<div class="col-3">
						<div class="input-group">
							<form:input type="number" path="destination.estimatedTime"
								class="form-control" min="1" aria-describedy="destinationTime" />
							<div class="input-group-prepend">
								<span class="input-group-text" id="destinationTime"><spring:message
										code="minutes" /></span>
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
						<span class="input-group-text" id="routeVehicle"><spring:message
								code="route.vehicle" /></span>
					</div>
					<form:select path="vehicle" class="form-control"
						aria-describedby="routeVehicle">
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
						<span class="input-group-text" id="routeAvailableSeats"><spring:message
								code="route.availableSeats" /></span>
					</div>
					<form:input type="number" path="availableSeats"
						class="form-control" aria-describedby="routeAvailableSeats"
						min="1" max="10" />
				</div>
				<form:errors path="availableSeats" cssClass="error" />
			</div>

			<div class="form-group col-md-6">
				<div class="input-group">
					<div class="input-group-prepend">
						<span class="input-group-text" id="routeMaxLuggage"><spring:message
								code="route.maxLuggage" /></span>
					</div>
					
		<spring:message code="route.luggage.none"  var = "noneMsg"/>	
		<spring:message code="route.luggage.small"  var = "smallMsg"/>
		<spring:message code="route.luggage.medium"  var = "mediumMsg"/>
		<spring:message code="route.luggage.big"  var = "bigMsg"/>
					<form:select path="maxLuggage" class="form-control"
						aria-describedby="routeMaxLuggage">
						<form:option label="${noneMsg}" value="NOTHING" />
						<form:option label="${smallMsg}" value="SMALL" />
						<form:option label="${mediumMsg}" value="MEDIUM" />
						<form:option label="${bigMsg}" value="BIG" />
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
				<input type="submit" class="btn btn-success"
					value="<spring:message code="route.save" />" />

				<spring:message code="route.cancel" var="cancel" />
				<a href="route/driver/listActive.do" class="btn btn-danger"><jstl:out
						value="${cancel}" /></a>
			</div>

		</form:form>
	</center>
</security:authorize>

<script>
	// This sample uses the Autocomplete widget to help the user select a
	// place, then it retrieves the address components associated with that
	// place, and then it populates the form fields with those details.
	// This sample requires the Places library. Include the libraries=places
	// parameter when you first load the API. For example:
	// <script
	// src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">
	
	var autocompleteOrigin, autocompleteDestination;
	<jstl:forEach items="${route.controlpoints}" var="cp" varStatus="status">
	var autocomplete<jstl:out value="${status.index}" />;
	</jstl:forEach>

	var componentForm = {
		street_number : 'short_name',
		route : 'long_name',
		locality : 'long_name',
		administrative_area_level_1 : 'short_name',
		country : 'long_name',
		postal_code : 'short_name'
	};

	function initAutocomplete() {
		// Create the autocomplete object, restricting the search predictions to
		// geographical location types.
		autocompleteOrigin = new google.maps.places.Autocomplete(document.getElementById('autocompleteOrigin'), {
			types : [
				'geocode'
			]
		});

		// Avoid paying for data that you don't need by restricting the set of
		// place fields that are returned to just the address components.
		autocompleteOrigin.setFields([
			'address_component'
		]);

		autocompleteDestination = new google.maps.places.Autocomplete(document.getElementById('autocompleteDestination'), {
			types : [
				'geocode'
			]
		});

		autocompleteDestination.setFields([
			'address_component'
		]);
		
		<jstl:forEach items="${route.controlpoints}" var="cp" varStatus="status">
		autocomplete<jstl:out value="${status.index}" /> = new google.maps.places.Autocomplete(document.getElementById('autocomplete<jstl:out value="${status.index}" />'), {
			types : [
				'geocode'
			]
		});
		autocomplete<jstl:out value="${status.index}" />.setFields([
        	'address_component'
        ]);
		</jstl:forEach>
	}

	// Bias the autocomplete object to the user's geographical location,
	// as supplied by the browser's 'navigator.geolocation' object.
	function geolocate() {
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(function(position) {
				var geolocation = {
					lat : position.coords.latitude,
					lng : position.coords.longitude
				};
				var circle = new google.maps.Circle({
					center : geolocation,
					radius : position.coords.accuracy
				});
				autocompleteOrigin.setBounds(circle.getBounds());
			});
		}
	}
</script>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAKoI-jZJQyPjIp1XGUSsbWh47JBix7qws&libraries=places&callback=initAutocomplete"
	async defer></script>