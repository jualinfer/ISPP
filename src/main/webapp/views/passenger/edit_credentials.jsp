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

<style>
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
		<spring:message code="passenger.title.principal" />
	</h3>
</div>

<div class="nav-profile-management nav background_orange">
	<div class="nav-profile-enlaces d-flex flex-row">
		<a class="nav-link text-white" href="passenger/edit.do"><spring:message code="driver.nav.profile" /></a> 
		<%-- PAYMENT <a class="nav-link text-white" href="payment/passenger/edit.do"><spring:message code="driver.nav.payment" /></a> --%> 
		<a class="nav-link active text-white" href="passenger/editCredentials.do"><spring:message code="driver.nav.credentials" /></a>
	</div>
</div>


<form:form id="form_edit_credentials" action="${requestURI}" modelAttribute="credentialsfForm">
	<form:hidden path="id"/>

	<div class="content-principal">
		<div class="profile-management d-flex flex-column justify-content-center">
			<div class="item-profile-management d-flex d-row justify-content-arround">
				<div class="form-group">
					<span><p><form:label path="password">
						<spring:message code="passenger.password"/>: 
					</form:label></p></span>
					<div><form:password id="password" path="password" class="form-control"/>
					<form:errors cssClass="error" path="password"/></div>
				</div>
			</div>
			
			<div class="item-profile-management d-flex d-row justify-content-arround">
				<div class="form-group">
					<span><p><form:label path="repeatPassword">
						<spring:message code="passenger.repeat.password"/>: 
					</form:label></p></span>
					<div><form:password id="repeatPassword" path="repeatPassword" class="form-control"/>
					<form:errors cssClass="error" path="repeatPassword"/></div>
				</div>
			</div>
		</div>
	
		<div class="save-cancel-management">
			<input class="btn btn-success" type="submit" name="save" value="<spring:message code="passenger.register"/>" />
			
		</div>	
	</div>	
	
</form:form>



