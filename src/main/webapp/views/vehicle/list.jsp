<%--
 * display.jsp
 *
 * Copyright (C) 2018 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>

<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css"> -->
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link rel="stylesheet"
		href="/path/to/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css" />

<spring:url value="/styles/route.css" var="routecss" />
	<link href="${routecss}" rel="stylesheet" />
	<script src="${routecss}"></script>

<spring:url value="/styles/profileManagement.css"
	var="profileManagementcss" />
<link href="${profileManagementcss}" rel="stylesheet" />
<script src="${profileManagementcss}"></script>



<div class="title-principal">
	<h3>
		<spring:message code="driver.title.principal" />
	</h3>
</div>

<div class="nav-profile-management nav background_orange">
	<div class="nav-profile-enlaces d-flex flex-row">
		<a class="nav-link text-white" href="driver/edit.do"><spring:message code="driver.nav.profile" /></a>
		<a class="nav-link active text-white" href="vehicle/driver/list.do"><spring:message code="driver.nav.vehicles" /></a>
		<%-- PAYMENT <a class="nav-link text-white" href="payment/driver/edit.do"><spring:message code="driver.nav.payment" /></a> --%>
		<a class="nav-link text-white" href="driver/editCredentials.do"><spring:message code="driver.nav.credentials" /></a>
	</div>
</div>

<div class="content-principal">

	<%-- Stored message variables --%>
	
	<spring:message code="vehicle.model" var="vehModel" />
	<spring:message code="vehicle.brand" var="vehBrand" />
	<spring:message code="vehicle.plate" var="vehPlate" />
	<spring:message code="vehicle.description" var="vehDescription" />
	<spring:message code="vehicle.capacity" var="vehCapacity" />
	<spring:message code="vehicle.type" var="vehType" />
	<spring:message code="vehicle.car" var="vehCar" />
	<spring:message code="vehicle.bike" var="vehBike" />
	<spring:message code="vehicle.edit.photo" var="vehEditPhoto" />
	<spring:message code="vehicle.cancel" var="vehCancel" />
	

	<security:authorize access="hasRole('DRIVER')">
		<div class="newVehicle">
			<jstl:if test="${principal.id eq driverId }">
				<spring:message code="vehicle.new" var="vehNew" />
				<center>
					<a href="vehicle/driver/create.do"
						class="btn btn-success btn-square btn-xl"><i
						class="fas fa-plus fa-2x"></i></a> <a href="vehicle/driver/create.do"><jstl:out
							value="${vehNew}" /></a>
				</center>
			</jstl:if>
		</div>
	
	</security:authorize>
	
	
	<div class="text-center active-routes">
		<!-- <h3>Vehicle list</h3> -->
	</div>
	<ul class="list-group">
		<jstl:forEach var="vehicle" items="${vehicles}">
	
			<div class="container">
				<div ><!-- class="row" -->
					<div > <!-- class="col-sm-6 col-md-3" -->
						<div class="thumbnail d-flex justify-content-between p-2">
						
							<img src="${vehicle.image}" width="200" height="150">
							<div class="caption">
								<h3>${vehicle.vehicleBrand} ${vehicle.model}</h3>
									<div class="media-body pl-3">
										<div class="plate">
											<span>CAR PLATE :&ensp;</span>${vehicle.plate}
										</div>
										
										<div class="capacity">
											${vehicle.seatsCapacity}<span>&ensp;Seats capacity</span>
										</div>
										<div class="description">${vehicle.description}</div>
									</div> <spring:message code="vehicle.edit" var="editVehicle" /> <jstl:if
										test="${principal.id eq driverId }">
										<div class="font-weight-bold">
											<dd>
												<%-- <a class="text-danger"
													href="vehicle/driver/edit.do?vehicleId=${vehicle.id}"><jstl:out
														value="${editVehicle}" /></a> --%>
											</dd>
	
										</div>
									</jstl:if>
								<p>
									<a href="vehicle/driver/edit.do?vehicleId=${vehicle.id}" class="btn btn-success" role="button">Editar</a> 
									
								</p>
							</div>
						</div>
					</div>
					</div>
					</div>
		</jstl:forEach>
	</ul>
</div>
