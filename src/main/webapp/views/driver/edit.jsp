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
		<spring:message code="driver.title.principal" />
	</h3>
</div>

<div class="nav-profile-management nav background_orange">
	<div class="nav-profile-enlaces d-flex flex-row">
		<a class="nav-link active text-white" href="driver/edit.do"><spring:message code="driver.nav.profile" /></a>
		<a class="nav-link text-white" href="vehicle/driver/list.do"><spring:message code="driver.nav.vehicles" /></a>
		<%-- PAYMENT <a class="nav-link text-white" href="payment/driver/edit.do"><spring:message code="driver.nav.payment" /></a> --%>
		<a class="nav-link text-white" href="driver/editCredentials.do"><spring:message code="driver.nav.credentials" /></a>
	</div>
</div>

<form:form id="form" action="${requestURI}" modelAttribute="driver">
		<form:hidden path="id" />
		<form:hidden path="version" />
		<form:hidden path="routes" />
		<form:hidden path="vehicles" />
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
					<spring:message code="driver.name" />: 
				</form:label></p></span>
				<div><form:input path="name" />
				<form:errors cssClass="error" path="name" /></div>
			</div>
	
			<div class="item-profile-management d-flex d-row justify-content-between">
				<span><p><form:label path="surname">
					<spring:message code="driver.surname" />: 
				</form:label></p></span>
				<div><form:input path="surname" />
				<form:errors cssClass="error" path="surname" /></div>
			</div>
	
			<div class="item-profile-management d-flex d-row justify-content-between">
				<span><p><form:label path="country">
					<spring:message code="driver.country" />: 
				</form:label></p></span>
				<div><form:input path="country" />
				<form:errors cssClass="error" path="country" /></div>
			</div>
	
			<div class="item-profile-management d-flex d-row justify-content-between">
				<span><p><form:label path="city">
					<spring:message code="driver.city" />: 
				</form:label></p></span>
				<div><form:input path="city" />
				<form:errors cssClass="error" path="city" /></div>
			</div>
	
			<div class="item-profile-management d-flex d-row justify-content-between">
				<span><p><form:label path="phone">
					<spring:message code="driver.phone" />: 
				</form:label></p></span>
				<div><form:input id="phone" path="phone" />
				<form:errors cssClass="error" path="phone" /></div>
			</div>
		</div>
		
		
		
		
		
	
		<div class="preferences-list-management d-flex flex-column justify-content-center mt-1">
			<span><spring:message code="driver.preferences" />: </span>
			
			<div class="item-preferences-list-management">
				<form:label path="pets">
					<spring:message code="driver.pets" />
				</form:label>
				<form:select path="pets">
					<form:option label="Yes" value="true">
					</form:option>
					<form:option label="No" value="false">
					</form:option>
				</form:select>
			</div>
	
			<div class="item-preferences-list-management">
				<form:label path="smoke">
					<spring:message code="driver.smoke" />
				</form:label>
				<form:select path="smoke">
					<form:option label="Yes" value="true">
					</form:option>
					<form:option label="No" value="false">
					</form:option>
				</form:select>
			</div>
	
			<div class="item-preferences-list-management">
				<form:label path="music">
					<spring:message code="driver.music" />
				</form:label>
				<form:select path="music">
					<form:option label="Yes" value="true">
					</form:option>
					<form:option label="No" value="false">
					</form:option>
				</form:select>
			</div>
	
			<div class="item-preferences-list-management">
				<form:label path="childs">
					<spring:message code="driver.childs" />
				</form:label>
				<form:select path="childs">
					<form:option label="Yes" value="true">
					</form:option>
					<form:option label="No" value="false">
					</form:option>
				</form:select>
			</div>
		</div>

		<div class="save-cancel-management">
			<input type="submit" name="save" class="btn btn-success"
				value="<spring:message code="driver.register"/>" /> 
		</div>
	</div>
</form:form>



