<%--
 * action-1.jsp
 *
 * Copyright (C) 2019 Universidad de Sevilla
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
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />
<spring:url value="/styles/route.css" var="routecss" />
<link rel="stylesheet" href="/path/to/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css" />


<div class="title-principal">
	<h3>
		<spring:message code="vehicle.title.principal" />
	</h3>
</div>



	
	<security:authorize access="hasRole('DRIVER')">
	
	<spring:message code="vehicle.car" var="vehCar"/>
	<spring:message code="vehicle.bike" var="vehBike"/>
	<spring:message code="vehicle.edit.photo" var="vehEditPhoto"/>
	
	
	
	<form:form action="vehicle/driver/edit.do"	modelAttribute="vehicle">
				<form:hidden path="id" />
				<form:hidden path="version" />
				<form:hidden path="driver"/>
				<form:hidden path="routes"/>
	
		<div class="content-principal">
			<div class="profile-management d-flex flex-column justify-content-center">
				<div class="form-group">
					<label> <spring:message code="vehicle.type" /></label>
	
					<form:select path="type" class="form-control">
						<form:option label="${vehCar}" value="CAR" />
						<form:option label="${vehBike}" value="BIKE" />
					</form:select>
				</div>
	
				<div class="form-group">
					<label> <spring:message code="vehicle.image" /></label>
					<jstl:if test="${vehicle.id!=0}">
						</br>
						<img src="${vehicle.image}" width="250" class="rounded"/>
					</jstl:if>
					<form:input path="image" class="form-control"/>
					<form:errors cssClass="error" path="image" />
				</div>
	
				<div class="form-group">
					<form:label path="vehicleBrand">
						<spring:message code="vehicle.brand" />
					</form:label>
					<form:input path="vehicleBrand" class="form-control" />
					<form:errors cssClass="error" path="vehicleBrand" />
				</div>		
	
				<div class="form-group">
					<form:label path="model">
						<spring:message code="vehicle.model" />
					</form:label>
					<form:input path="model" class="form-control" />
					<form:errors cssClass="error" path="model" />
				</div>
				
				<div class="form-group">
					<form:label path="seatsCapacity">
						<spring:message code="vehicle.capacity" />
					</form:label>
					<form:input path="seatsCapacity" class="form-control" type="number" min="2" max="15"/>
					<form:errors cssClass="error" path="seatsCapacity" />
				</div>
	
				<div class="form-group">
					<form:label path="plate">
						<spring:message code="vehicle.plate" />
					</form:label>
					<form:input path="plate" class="form-control" />
					<form:errors cssClass="error" path="plate" />
				</div>
	
				<div class="form-group">
					<form:label path="description">
						<spring:message code="vehicle.description" />
					</form:label>
					<form:textarea path="description" class="form-control" />
					<form:errors cssClass="error" path="description" />
				</div>
			</div>
	
	
				<div class="form-group text-center">
					<input type="submit" name="save" class="btn btn-success"
						value="<spring:message code="vehicle.save" />" />
						
					<input type="button" name="cancel" class="btn btn-danger"
						value="<spring:message code="vehicle.cancel" />"
						onclick="javascript: relativeRedir('vehicle/driver/list.do');" />
				</div>
			</div>
			</form:form>
	
	
	</security:authorize>
