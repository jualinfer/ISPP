<%--
 * action-1.jsp
 *
 * Copyright (C) 2017 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>

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

<spring:url value="/styles/profileManagement.css"
	var="profileManagementcss" />
<link href="${profileManagementcss}" rel="stylesheet" />
<script src="${profileManagementcss}"></script>

<div class="title-principal">
	<h3>
		<spring:message code="passenger.title.principal" />
	</h3>
</div>

<div class="nav-profile-management nav background_orange">
	<div class="nav-profile-enlaces d-flex flex-row">
		<a class="nav-link active text-white" href="passenger/edit.do"><spring:message code="driver.nav.profile" /></a> 
		<%-- PAYMENT <a class="nav-link text-white" href="payment/passenger/edit.do"><spring:message code="driver.nav.payment" /></a> --%> 
		<a class="nav-link text-white" href="passenger/editCredentials.do"><spring:message code="driver.nav.credentials" /></a>
	</div>
</div>

<form:form id="form" action="${requestURI}" modelAttribute="passenger">
	<form:hidden path="id" />
	<form:hidden path="version" />
	<form:hidden path="comments" />
	<form:hidden path="reservations" />
	<form:hidden path="bankAccountNumber" />
	<form:hidden path="creditCard.cvv" />
	<form:hidden path="creditCard.number" />
	<form:hidden path="creditCard.expMonth" />
	<form:hidden path="creditCard.expYear" />
	<form:hidden path="cash" />
	<form:hidden path="userAccount.id" />
	<form:hidden path="userAccount.enabled" />
	<form:hidden path="userAccount.version" />
	<form:hidden path="userAccount.authorities" />
	<form:hidden path="userAccount.username" />
	<form:hidden path="userAccount.password" />


	<div class="content-principal">
		<div class="profile-management d-flex flex-column justify-content-center">
			<div class="item-profile-management d-flex d-row justify-content-arround">
				<span><p><form:label path="name">
					<spring:message code="passenger.name" />: 
				</form:label></p></span>
				<div><form:input path="name" />
				<form:errors cssClass="error" path="name" /></div>
			</div>
	
			<div class="item-profile-management d-flex d-row justify-content-arround">
				<span><p><form:label path="surname">
					<spring:message code="passenger.surname" />: 
				</form:label></p></span>
				<div><form:input path="surname" />
				<form:errors cssClass="error" path="surname" /></div>
			</div>
	
			<div class="item-profile-management d-flex d-row justify-content-arround">
				<span><p><form:label path="country">
					<spring:message code="passenger.country" />: 
				</form:label></p></span>
				<div><form:input path="country" />
				<form:errors cssClass="error" path="country" /></div>
			</div>
	
			<div class="item-profile-management d-flex d-row justify-content-arround">
				<span><p><form:label path="city">
					<spring:message code="passenger.city" />: 
				</form:label></p></span>
				<div><form:input path="city" />
				<form:errors cssClass="error" path="city" /></div>
			</div>
	
			<div class="item-profile-management d-flex d-row justify-content-arround">
				<span><p><form:label path="phone">
					<spring:message code="passenger.phone" />: 
				</form:label></p></span>
				<div><form:input id="phone" path="phone" />
				<form:errors cssClass="error" path="phone" /></div>
			</div>
		</div>
		
		<div class="save-cancel-management">
			<input type="submit" name="save" class="btn btn-success"
				value="<spring:message code="passenger.register"/>" /> 
		</div>

	</div>
</form:form>



