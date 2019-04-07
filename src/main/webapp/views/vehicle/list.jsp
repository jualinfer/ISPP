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

<%-- Stored message variables --%>

<spring:message code="vehicle.model"  var="vehModel"/>
<spring:message code="vehicle.brand"  var="vehBrand"/>
<spring:message code="vehicle.plate"  var="vehPlate"/>
<spring:message code="vehicle.description"  var="vehDescription"/>
<spring:message code="vehicle.capacity"  var="vehCapacity"/>
<spring:message code="vehicle.type"  var="vehType"/>
<spring:message code="vehicle.car" var="vehCar"/>
<spring:message code="vehicle.bike" var="vehBike"/>
<spring:message code="vehicle.edit.photo" var="vehEditPhoto"/>
<spring:message code="vehicle.cancel"  var="vehCancel"/>


<security:authorize access="hasRole('DRIVER')">
	<jstl:if test="${principal.id eq driverId }">
		<spring:message code="vehicle.new" var ="vehNew" />
		<a href="vehicle/driver/create.do"><jstl:out value="${vehNew}"/></a>
	</jstl:if>
	
</security:authorize>

<display:table name="vehicles" id="row" pagesize="4" class="displaytag" requestURI="${requestURI}">
	
	<spring:message code="vehicle.image" var = "vehImage" />
	<display:column title="${vehImage}">
		<img src="${row.image}" width="100"/>
	</display:column>
	
	<spring:message code="vehicle.brand" var = "vehBrand" />
	<display:column property="vehicleBrand" title="${vehBrand}" sortable="false"/>

	<spring:message code="vehicle.model" var = "vehModel" />
	<display:column property="model" title="${vehModel}" sortable="false"/>

	<spring:message code="vehicle.plate" var = "vehPlate" />
	<display:column property="plate" title="${vehPlate}" sortable="false"/>
	
	<spring:message code="vehicle.capacity" var = "vehCapacity" />
	<display:column property="seatsCapacity" title="${vehCapacity}" sortable="false"/>
	
	<spring:message code="vehicle.description" var = "vehDescription" />
	<display:column property="description" title="${vehDescription}" sortable="false"/>
	
	<security:authorize access="hasRole('DRIVER')">
	<jstl:if test="${principal.id eq driverId }">
		<display:column>
			<a href="vehicle/driver/edit.do?vehicleId=${row.id}"><spring:message code="vehicle.edit"/></a>
		</display:column>
		<display:column>
			<a href="vehicle/driver/delete.do?vehicleId=${row.id}"><spring:message code="vehicle.delete"/></a>
		</display:column>
	</jstl:if>
	</security:authorize>
	
</display:table>

<a href="driver/display.do?driverId=${driverId}"><spring:message code="vehicle.back"/></a>
