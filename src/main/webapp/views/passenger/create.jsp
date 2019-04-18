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

<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />
<spring:url value="/styles/profile.css" var="profilecss" />
<link href="${profilecss}" rel="stylesheet" />
<script src="${profilecss}"></script>
<link rel="stylesheet"
	href="/path/to/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css" />


<form:form id="form" action="${requestURI}" modelAttribute="passenger">
	<form:hidden path="id" />
	<form:hidden path="version" />
	<form:hidden path="comments" />
	<form:hidden path="reservations" />
	<form:hidden path="cash" />
	<form:hidden path="userAccount.id" />
	<form:hidden path="userAccount.enabled" />
	<form:hidden path="userAccount.version" />
	<form:hidden path="userAccount.authorities" />


	<div
		class="resume d-flex flex-column justify-content-center align-items-center">

			<div class="form-row">
			<div class="col">
			<spring:message code="passenger.name" var="passengerName"/>
				<form:input path="name" type="text" class="form-control"
					placeholder="${passengerName}"/>
				<form:errors cssClass="error" path="name" />
				<br />
			</div>
		</div>
		<div class="form-row">
			<div class="col">
			<spring:message code="passenger.surname" var="passengerSurname"/>
				<form:input path="surname" type="text" class="form-control"
					placeholder="${passengerSurname }"/>
				<form:errors cssClass="error" path="surname" />
				<br />
			</div>
		</div>

		</br>

		<div class="form-row">
			<div class="col">
			<spring:message code="passenger.country" var="passengerCountry"/>
				<form:input path="country" type="text" class="form-control"
					placeholder="${passengerCountry }"/>
				<form:errors cssClass="error" path="country" />
				<br />
			</div>
		</div>
		<div class="form-row">
			<div class="col">
			<spring:message code="passenger.city" var="passengerCity"/>
				<form:input path="city" type="text" class="form-control"
					placeholder="${passengerCity }"/>
				<form:errors cssClass="error" path="city" />
				<br />

			</div>

		</div>

		<div class="form-row">
			<div class="col">
			<spring:message code="passenger.phone" var="passengerPhone"/>
				<form:input path="phone" type="text" class="form-control"
					placeholder="${passengerPhone }"/>
				<form:errors cssClass="error" path="phone" />
				<br />
			</div>

		</div>

		<div class="form-row">
			<div class="col">
			<spring:message code="passenger.username" var="passengerUsername"/>
				<form:input path="userAccount.username" type="text" class="form-control"
					placeholder="${passengerUsername }"/>
				<form:errors cssClass="error" path="userAccount.username" />
				<br />
			</div>
		</div>
		<div class="form-row">
			<div class="col">
			<spring:message code="passenger.password" var="passengerPass"/>
				<form:input path="userAccount.password" type="password" class="form-control"
					placeholder="${passengerPass }"/>
				<form:errors cssClass="error" path="userAccount.password" />
				<br />
			</div>
		</div>
		
		<div class="form-row">
			<div class="col">
			<spring:message code="creditCard.number" var="passengerCreditCard"/>
				<form:input path="creditCard.number" type="text" class="form-control"
					placeholder="${passengerCreditCard }"/>
				<form:errors cssClass="error" path="creditCard.number" />
				<br />
			</div>
		</div>



		<div class="form-row">
			<div class="col">
			<spring:message code="creditCard.expMonth" var="passengerExpMonth"/>
				<form:input path="creditCard.expMonth" type="text" class="form-control"
					placeholder="${passengerExpMonth }"/>
				<form:errors cssClass="error" path="creditCard.expMonth" />
				<br />
			</div>
		</div>



		<div class="form-row">
			<div class="col">
			<spring:message code="creditCard.expYear" var="passengerExpYear"/>
				<form:input path="creditCard.expYear" type="text" class="form-control"
					placeholder="${passengerExpYear }"/>
				<form:errors cssClass="error" path="creditCard.expYear" />
				<br />
			</div>
		</div>


		<div class="form-row">
			<div class="col">
			<spring:message code="creditCard.cvv" var="passengerCVV"/>
				<form:input path="creditCard.cvv" type="text" class="form-control"
					placeholder="${passengerCVV }"/>
				<form:errors cssClass="error" path="creditCard.cvv" />
				<br />
			</div>
		</div>



		<div class="form-row">
			<div class="col">
			<spring:message code="passenger.bankAccountNumber" var="passengerBA"/>
				<form:input path="bankAccountNumber" type="text" class="form-control"
					placeholder="${passengerBA }"/>
				<form:errors cssClass="error" path="bankAccountNumber" />
				<br />
			</div>
		</div>



			
			
		<input type="submit" class="btn btn-success" name="save"
			value="<spring:message code="passenger.register"/>" /> <input
			type="button" class="btn btn-danger" name="cancel"
			value="<spring:message code="passenger.cancel" />"
			onclick="javascript: relativeRedir('security/login.do');" />

	</div>

</form:form>






