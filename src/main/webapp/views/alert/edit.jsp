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
		<spring:message code="alert.title.create" />
	</h3>
</div>



<form:form id="form" action="${requestURI}" modelAttribute="alert">
	<form:hidden path="date" />
	<form:hidden path="sender" />
	<form:hidden path="receiver" />
	<form:hidden path="typeAlert" />
	<form:hidden path="isRead" />

	<div class="content-principal">


		<div
			class="profile-management d-flex flex-column justify-content-center">
			<div
				class="item-profile-management d-flex d-row justify-content-arround">
				<span><p>
						<form:label path="alertBody">
							<spring:message code="alert.alertBody" />: 
				</form:label>
					</p></span>
				<div>
					<form:input path="alertBody" />
					<form:errors cssClass="error" path="image" />
				</div>
			</div>
		</div>
	</div>

</form:form>
