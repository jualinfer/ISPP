<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
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
<div class="text-center active-routes">
	<h3><spring:message code="searchRoute" /></h3>
</div>
<form:form action="${requestURI}" modelAttribute="finder">
	<center>

		<div class="col-sm-6 text-center" style="padding-top: 20px;">
			<spring:message code="route.origin" var="routeOrigin" />
			<form:input type="text" path="origin" class="form-control" placeholder="${routeOrigin}" id="autocompleteOrigin" />
			<form:errors path="origin" cssClass="error" />
		</div>

		<div class="col-sm-6 text-center" style="padding-top: 20px;">
			<div class="form-group">
				<spring:message code="route.departureDate" var="routeDepartureDate" />
				<div class="input-group date" id="datetimepicker4"
					data-target-input="nearest">
					<form:input type="text" path="departureDate"
						class="form-control datetimepicker-input"
						data-target="#datetimepicker4"
						placeholder="${routeDepartureDate}" />
					<div class="input-group-append" data-target="#datetimepicker4"
						data-toggle="datetimepicker">
						<div class="input-group-text">
							<i class="fa fa-calendar"></i>
						</div>
					</div>
				</div>
				<form:errors path="departureDate" cssClass="error" />
			</div>
		</div>

		<div class="col-sm-6 text-center" style="padding-top: 20px;">
			<spring:message code="route.destination" var="routeDestination" />
			<form:input type="text" path="destination" class="form-control" required="true" placeholder="${routeDestination}" id="autocompleteDestination" />
			<form:errors path="destination" cssClass="error" />
		</div>
		
		<div class="col-sm-6 text-center" style="padding-top: 20px;">
			<div class="form-group">
				<spring:message code="search.arrivalDate" var="routeArrivalDate" />
				<div class="input-group date" id="datetimepicker3"
					data-target-input="nearest">
					<form:input type="text" path="arrivalDate"
						class="form-control datetimepicker-input"
						data-target="#datetimepicker3"
						placeholder="${routeArrivalDate}" />
					<div class="input-group-append" data-target="#datetimepicker3"
						data-toggle="datetimepicker">
						<div class="input-group-text">
							<i class="fa fa-calendar"></i>
						</div>
					</div>
				</div>
				<form:errors path="arrivalDate" cssClass="error" />
			</div>
		</div>
		
		
		<div class="form-group col-md-6">
			<div class="input-group">
				<div class="input-group-prepend">
					<span class="input-group-text" id="routeVehicleType"><spring:message code="search.vehicleType" /></span>
				</div>
				<form:select path="vehicleType" class="form-control"
					aria-describedby="routeVehicleType">
					<form:option label="Any" value="0" />
					<form:option label="Car" value="1" />
					<form:option label="Bike" value="2" />
				</form:select>
			</div>
			<form:errors path="vehicleType" cssClass="error" />
		</div>
		
		<div class="form-group col-md-6">
			<div class="input-group">
				<div class="input-group-prepend">
					<span class="input-group-text" id="routeAvailableSeats"><spring:message code="route.availableSeats" /></span>
				</div>
				<form:input type="number" path="availableSeats" min="1" max="9" class="form-control" aria-describedby="routeAvailableSeats" />
			</div>
		</div>
		
		<div class="form-group col-md-6">
			<div class="input-group">
				<div class="input-group-prepend">
					<span class="input-group-text" id="routeMaxLuggage"><spring:message code="route.maxLuggage" /></span>
				</div>
				<form:select path="luggageSize" class="form-control" aria-describedby="routeMaxLuggage" >
					<form:option label="Nothing" value="NOTHING" />
					<form:option label="Small" value="SMALL" />
					<form:option label="Medium" value="MEDIUM" />
					<form:option label="Big" value="BIG" />
				</form:select>
			</div>
		</div>

		<div class="col-sm-6 text-center" style="padding-top: 20px;">
			<div class="form-check">
				<form:checkbox class="form-check-input" value="true" path="pets"
					id="defaultCheck1" />
				<label class="form-check-label" for="defaultCheck1"> <spring:message code="route.pets" /> </label>
			</div>
		</div>

		<div class="col-sm-6 text-center" style="padding-top: 20px;">
			<div class="form-check">
				<form:checkbox class="form-check-input" value="true" path="childs"
					id="defaultCheck2" />
				<label class="form-check-label" for="defaultCheck2"> <spring:message code="route.children" /> </label>
			</div>
		</div>
		
		<div class="col-sm-6 text-center" style="padding-top: 20px;">
			<div class="form-check">
				<form:checkbox class="form-check-input" value="true" path="smoke"
					id="defaultCheck3" />
				<label class="form-check-label" for="defaultCheck3"> <spring:message code="route.smoke" /> </label>
			</div>
		</div>
		
		<div class="col-sm-6 text-center" style="padding-top: 20px;">
			<div class="form-check">
				<form:checkbox class="form-check-input" value="true" path="music"
					id="defaultCheck4" />
				<label class="form-check-label" for="defaultCheck4"> <spring:message code="route.music" /> </label>
			</div>
		</div>

		<div class="col-sm-6 text-center" style="padding-top: 20px;">
			<spring:message code="search" var="search" />
			<input type="submit" name="search" class="btn btn-success" value="${search}" />
		</div>
	</center>
</form:form>

<script type="text/javascript">
	$(function() {
		$('#datetimepicker4').datetimepicker({
			format : 'DD/MM/YYYY HH:mm',
			minDate : new Date()
		});
	});
	$(function() {
		$('#datetimepicker3').datetimepicker({
			format : 'DD/MM/YYYY HH:mm',
			minDate : new Date()
		});
	});
</script>