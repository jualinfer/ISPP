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

<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

<spring:url value="/styles/route.css" var="routecss" />
<link href="${routecss}" rel="stylesheet" />
<script src="${routecss}"></script>

<spring:url value="/styles/profileManagement.css"
	var="profileManagementcss" />
<link href="${profileManagementcss}" rel="stylesheet" />
<script src="${profileManagementcss}"></script>
<style>
.card-img-top --img-overlay {
	position: relative;
	max-width: 100px;
	//
	whatever
	your
	max-width
	should
	be
}
	/* landscape phones, 576px and up */
	@MEDIA ( max-width : 576px) {
		.nav-profile-enlaces .nav-link{
			padding: .5rem;
    		font-size: 16px;
		}
	}
</style>



<div class="title-principal">
	<h3>
		<spring:message code="driver.title.principal" />
	</h3>
</div>

<div class="nav-profile-management nav background_orange">
	<div class="nav-profile-enlaces d-flex flex-row">
		<a class="nav-link text-white" href="driver/edit.do"><spring:message
				code="driver.nav.profile" /></a> <a class="nav-link active text-white"
			href="vehicle/driver/list.do"><spring:message
				code="driver.nav.vehicles" /></a>
		<%-- PAYMENT <a class="nav-link text-white" href="payment/driver/edit.do"><spring:message code="driver.nav.payment" /></a> --%>
		<a class="nav-link text-white" href="driver/editCredentials.do"><spring:message
				code="driver.nav.credentials" /></a>
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





	<div class="text-center active-routes">
		<!-- <h3>Vehicle list</h3> -->
	</div>
	<div class="form-group col-xs-12 col-sm-12 col-md-8  mx-auto">
		<div class="card-group">
			<jstl:forEach var="vehicle" items="${vehicles}">
				<div class="card" style="min-width: 250px; max-width: 300px;">
					<img class="card-img-top " src="${vehicle.image}"
						style="min-height: 250px;">
					<div class="card-img-overlay">
						<spring:message code="vehicle.edit" var="editVehicle" />
						<jstl:if test="${principal.id eq driverId }">
							<div class="edit" style="padding-top: 10px">
								<a href="vehicle/driver/edit.do?vehicleId=${vehicle.id}"
									class="btn btn-success" role="button">${editVehicle}</a>
							</div>
						</jstl:if>



					</div>


					<div class="card-footer text-center">
						<div class="row">
							<div class="col">
								<div class="capacity">
									<span class="fa-stack"> <span
										class="fa fas fa-user fa-5x fa-stack-2x"></span> <strong
										class="fa-stack-1x fa-stack-text fa-inverse">
											${vehicle.seatsCapacity}</strong>
									</span>
								</div>
							</div>
							<div class="col">
								<span class="badge badge-pill badge-primary">
									${vehicle.vehicleBrand} ${vehicle.model} </span>
								<div class="plate" style="padding-top: 10px">
									<span class="badge badge-pill badge-secondary">${vehicle.plate}</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</jstl:forEach>
		</div>
		<div
			class="form-group col-xs-12 col-sm-10 col-md-8  mx-auto text-center">
			<security:authorize access="hasRole('DRIVER')">
				<div id=new style="padding-top: 10px">
					<jstl:if test="${principal.id eq driverId }">
						<spring:message code="vehicle.new" var="vehNew" />

						<a href="vehicle/driver/create.do"
							class="btn btn-success btn-square btn-xl"><i
							class="fas fa-plus fa-2x"></i></a>
						<a href="vehicle/driver/create.do"><jstl:out value="${vehNew}" /></a>
					</jstl:if>
				</div>



			</security:authorize>
		</div>
	</div>
</div>

