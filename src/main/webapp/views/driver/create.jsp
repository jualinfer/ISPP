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

<script>

  function checkForm(form)
  {
    if(!form.terms.checked) {
      alert("<spring:message code="driver.accept.terms"/>");
      form.terms.focus();
      return false;
    }
    return true;
  }
</script>

<form:form id="form" action="${requestURI}" modelAttribute="driver" onsubmit="return checkForm(this)">
	<form:hidden path="id" />
	<form:hidden path="version" />
	<form:hidden path="routes" />
	<form:hidden path="vehicles" />
	<form:hidden path="cash" />
	<form:hidden path="newAlerts" />
	<form:hidden path="newMessages" />
	<form:hidden path="userAccount.id" />
	<form:hidden path="userAccount.enabled" />
	<form:hidden path="userAccount.banned" />
	<form:hidden path="userAccount.version" />
	<form:hidden path="userAccount.authorities" />



	<div
		class="resume d-flex flex-column justify-content-center align-items-center">

		<div class="form-row">
			<div class="col">
			<spring:message code="driver.name" var="driverName"/>
				<form:input path="name" type="text" class="form-control"
					placeholder="${driverName}"/>
				<form:errors cssClass="error" path="name" />
				<br />
			</div>
		</div>
		<div class="form-row">
			<div class="col">
			<spring:message code="driver.surname" var="driverSurname"/>
				<form:input path="surname" type="text" class="form-control"
					placeholder="${driverSurname }"/>
				<form:errors cssClass="error" path="surname" />
				<br />
			</div>
		</div>

		</br>

		<div class="form-row">
			<div class="col">
			<spring:message code="driver.country" var="driverCountry"/>
				<form:input path="country" type="text" class="form-control"
					placeholder="${driverCountry }"/>
				<form:errors cssClass="error" path="country" />
				<br />
			</div>
		</div>
		<div class="form-row">
			<div class="col">
			<spring:message code="driver.city" var="driverCity"/>
				<form:input path="city" type="text" class="form-control"
					placeholder="${driverCity }"/>
				<form:errors cssClass="error" path="city" />
				<br />

			</div>

		</div>

		<div class="form-row">
			<div class="col">
			<spring:message code="driver.phone" var="driverPhone"/>
				<form:input path="phone" type="text" class="form-control"
					placeholder="${driverPhone }"/>
				<form:errors cssClass="error" path="phone" />
				<br />
			</div>

		</div>

		<div class="form-row">
			<div class="col">
			<spring:message code="driver.username" var="driverUsername"/>
				<form:input path="userAccount.username" type="text" class="form-control"
					placeholder="${driverUsername }"/>
				<form:errors cssClass="error" path="userAccount.username" />
				<br />
			</div>
		</div>
		<div class="form-row">
			<div class="col">
			<spring:message code="driver.password" var="driverPass"/>
				<form:input path="userAccount.password" type="password" class="form-control"
					placeholder="${driverPass }"/>
				<form:errors cssClass="error" path="userAccount.password" />
				<br />
			</div>
		</div>
		
		<div class="form-row">
			<div class="col">
			<spring:message code="driver.image" var="driverImage"/>
				<form:input path="image" type="text" class="form-control"
					placeholder="${driverImage }"/>
				<form:errors cssClass="error" path="image" />
				<br />
			</div>
		</div>

		<div class="form-row">
			<div class="col">
			<spring:message code="driver.bankAccountNumber" var="driverBA"/>
				<form:input path="bankAccountNumber" type="text" class="form-control"
					placeholder="${driverBA }"/>
				<form:errors cssClass="error" path="bankAccountNumber" />
				<br />
			</div>
		</div>

		<div class="form-row">
			<div class="col">
				<spring:message code="driver.preferences"/></br>
				<div class="form-check form-check-inline">
					 <form:checkbox path="childs" cssClass="form-check-input" id="inlineCheckbox4" value="option1"/>
					 <label
						class="form-check-label" for="inlineCheckbox1">Childs</label>
				</div>
				<div class="form-check form-check-inline">
					<form:checkbox path="pets" cssClass="form-check-input" id="inlineCheckbox4" value="option2"/>
					<label
						class="form-check-label" for="inlineCheckbox2">Pets</label>
				</div>
				<div class="form-check form-check-inline">
					<form:checkbox path="smoke" cssClass="form-check-input" id="inlineCheckbox4" value="option3"/>
					 <label
						class="form-check-label" for="inlineCheckbox3">Smoking</label>
				</div>
				<div class="form-check form-check-inline">
					<form:checkbox path="music" cssClass="form-check-input" id="inlineCheckbox4" value="option4"/>
					 <label
						class="form-check-label" for="inlineCheckbox4">Music</label>
				</div>

			</div>

	</div>
	
	<div>
		<input type="checkbox" name="terms"><a href="welcome/termsAndConditions.do"><spring:message code="driver.terms"/></a>
	</div>
		<input type="submit" class="btn btn-success" name="save"
			value="<spring:message code="driver.register"/>" /> <input
			type="button" class="btn btn-danger" name="cancel"
			value="<spring:message code="driver.cancel" />"
			onclick="javascript: relativeRedir('security/login.do');" />

	</div>



</form:form>




