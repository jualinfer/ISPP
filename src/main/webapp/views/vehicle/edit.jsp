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

<security:authorize access="hasRole('DRIVER')">

<spring:message code="vehicle.car" var="vehCar"/>
<spring:message code="vehicle.bike" var="vehBike"/>
<spring:message code="vehicle.edit.photo" var="vehEditPhoto"/>



<form:form action="vehicle/driver/edit.do"	modelAttribute="vehicle">
			<form:hidden path="id" />
			<form:hidden path="version" />
			<form:hidden path="driver"/>
			<form:hidden path="routes"/>


			<form:label path="type">
			<spring:message code="vehicle.type" />: 
			</form:label>
			
			<form:radiobutton path="type" label="${vehCar}" value="CAR"/>
			<form:radiobutton path="type" label="${vehBike}" value="BIKE"/>
			<form:errors cssClass="error" path="type" />
			<br />


			<form:label path="image">
				<spring:message code="vehicle.image" />: </form:label>
			<jstl:if test="${vehicle.id!=0}">
				<img src="${vehicle.image}" width="250"/></br>
			</jstl:if>
			<form:input path="image" />
			<form:errors cssClass="error" path="image" />
			<br />

			<form:label path="vehicleBrand">
				<spring:message code="vehicle.brand" />: </form:label>
			<form:input path="vehicleBrand" />
			<form:errors cssClass="error" path="vehicleBrand" />
			<br />

			<form:label path="model">
				<spring:message code="vehicle.model" />: </form:label>
			<form:input path="model" />
			<form:errors cssClass="error" path="model" />
			<br />
			
			<form:label path="seatsCapacity">
				<spring:message code="vehicle.capacity" />: </form:label>
			<form:input path="seatsCapacity" />
			<form:errors cssClass="error" path="seatsCapacity" />
			<br />

			<form:label path="plate">
				<spring:message code="vehicle.plate" />: </form:label>
			<form:input path="plate" />
			<form:errors cssClass="error" path="plate" />
			<br />

			<form:label path="description">
				<spring:message code="vehicle.description" />: </form:label>
			<form:textarea path="description" />
			<form:errors cssClass="error" path="description" delimiter="350"/>
			<br />

			<input type="submit" name="save"
				value="<spring:message code="vehicle.save" />" />
			<input type="button" name="cancel"
				value="<spring:message code="vehicle.cancel" />"
				onclick="javascript: relativeRedir('vehicle/list.do?driverId=${driver.id}');" />
			<br />

		</form:form>


</security:authorize>