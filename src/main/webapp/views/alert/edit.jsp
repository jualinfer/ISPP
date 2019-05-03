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

<div class="text-center active-routes">

	<h3>
		<spring:message code="alerts.edit" />
	</h3>

</div>
<spring:url value="/styles/messages.css" var="messages" />
<link href="${messages}" rel="stylesheet" />
<script src="${messages}"></script>




<form:form id="form" action="${requestURI}" modelAttribute="alert">
	<form:hidden path="date" />
	<form:hidden path="sender" />
	<form:hidden path="receiver" />
	<form:hidden path="typeAlert" />
	<form:hidden path="isRead" />
	<center>
		<div class="content-principal">




			<form:label path="alertBody">
				<spring:message code="alert.alertBody" />: 
				</form:label>
			<div style="padding-left: 25px">
				<form:input path="alertBody" class="form-control" />
				<form:errors cssClass="error" path="alertBody" />
			</div>
		</div>


		<div class="form-group col-md-6 text-center" style="padding:10px">
			<input type="submit" name="save" class="btn btn-success"
				value="<spring:message code="alert.save" />" />

			<spring:message code="alert.cancel" var="cancel" />
			<a href="thread/report/list.do" class="btn btn-danger"><jstl:out
					value="${cancel}" /></a>
		</div>
	</center>

</form:form>
