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
<form:form action="vehicle/driver/editPhoto.do"	modelAttribute="vehicle">
			<form:hidden path="id" />
			<form:hidden path="version" />
			<form:hidden path="driver"/>
			<form:hidden path="routes"/>
			<form:hidden path="vehicleBrand"/>
			<form:hidden path="model" />
			<form:hidden path="seatsCapacity" />
			<form:hidden path="type"/>


			<form:label path="image">
				<spring:message code="vehicle.image" />: </form:label>
			<form:input path="image"/>
			<form:errors cssClass="error" path="image" />
			<br />


			<input type="submit" name="save"
				value="<spring:message code="vehicle.save" />" />
			<input type="button" name="cancel"
				value="<spring:message code="vehicle.cancel" />"
				onclick="javascript: relativeRedir('vehicle/driver/edit.do?vehicleId=${vehicle.id}');" />
			<br />

		</form:form>


</security:authorize>