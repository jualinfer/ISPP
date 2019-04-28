<%--
 * display.jsp
 *
 * Copyright (C) 2018 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>

<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<h3><spring:message code="confirmRoute" /></h3>
</div>

<%-- Stored message variables --%>

<spring:message code="route.price"  var="msgPrice"/>
<spring:message code="route.distance"  var="msgDistance"/>
<spring:message code="route.confirm"  var="confirm"/>
<spring:message code="route.cancel"  var="cancel"/>


<center>
	<div class="col-sm-10 text-center" style="padding-top: 20px;">
		<h2><spring:message code="confirmRouteMessage" /></h2>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-sm">
				<h4><jstl:out value="${msgPrice}" /> <span class="badge badge-success"><jstl:out value="${route.pricePerPassenger}" /> &euro;</span></h4>
			</div>
			<div class="col-sm">
				<h4><jstl:out value="${msgDistance}" /> <span class="badge badge-primary"><jstl:out value="${route.distance} Km" /></span></h4>
			</div>
		</div>
	</div>
	<div class="col-md-6 text-center">
	<form:form action="${requestURISave}" modelAttribute="route" style="padding-bottom: 25px;">
		<form:hidden path="id" />
		<form:hidden path="departureDate" />
		<form:hidden path="origin" />
		<form:hidden path="destination" />
		<form:hidden path="estimatedDuration" />
		<form:hidden path="daysRepeat" />
		<form:hidden path="availableSeats" />
		<form:hidden path="distance" />
		<form:hidden path="pricePerPassenger" />
		<form:hidden path="details" />
		<form:hidden path="maxLuggage" />
		<form:hidden path="isCancelled" />
		<form:hidden path="driver" />
		<form:hidden path="vehicle" />
		<form:hidden path="reservations" />
		
		<jstl:forEach items="${route.controlPoints}" var="cp" varStatus="status">
			<form:hidden path="controlPoints[${status.index}].id" />
			<form:hidden path="controlPoints[${status.index}].location" />
			<form:hidden path="controlPoints[${status.index}].arrivalTime" />
			<form:hidden path="controlPoints[${status.index}].arrivalOrder" />
			<form:hidden path="controlPoints[${status.index}].distance" />
		</jstl:forEach>
		
		<input type="submit" name="save" class="btn btn-success"
					value="<spring:message code="route.save" />" />
	</form:form>
	
	<form:form action="${requestURICancel}" modelAttribute="route">
		<form:hidden path="id" />
		<form:hidden path="departureDate" />
		<form:hidden path="origin" />
		<form:hidden path="destination" />
		<form:hidden path="estimatedDuration" />
		<form:hidden path="daysRepeat" />
		<form:hidden path="availableSeats" />
		<form:hidden path="distance" />
		<form:hidden path="pricePerPassenger" />
		<form:hidden path="details" />
		<form:hidden path="maxLuggage" />
		<form:hidden path="isCancelled" />
		<form:hidden path="driver" />
		<form:hidden path="vehicle" />
		<form:hidden path="reservations" />
		
		<jstl:forEach items="${route.controlPoints}" var="cp" varStatus="status">
			<form:hidden path="controlPoints[${status.index}].id" />
			<form:hidden path="controlPoints[${status.index}].location" />
			<form:hidden path="controlPoints[${status.index}].arrivalTime" />
			<form:hidden path="controlPoints[${status.index}].arrivalOrder" />
			<form:hidden path="controlPoints[${status.index}].distance" />
		</jstl:forEach>
		
		<input type="submit" class="btn btn-danger" value="<spring:message code="route.cancel" />" />
	</form:form>
	</div>
</center>