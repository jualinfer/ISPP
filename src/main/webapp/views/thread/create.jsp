<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<spring:url value="/styles/route.css" var="routecss" />
<link href="${routecss}" rel="stylesheet" />
<script src="${routecss}"></script>
<div class="text-center active-routes">
	<h3><spring:message code="messages" /></h3>
</div>

<security:authorize access="hasAnyRole('DRIVER', 'PASSENGER', 'ADMIN')">
	<center>
		Message for: ${threadForm.user.name} ${threadForm.user.surname}
		<br>
		Route: ${threadForm.route.origin} -> ${threadForm.route.destination}
		<br>
		<form:form action="${requestURI}" modelAttribute="threadForm">
			<form:hidden path="route" />
			<form:hidden path="user" />

			<div class="form-group col-md-6">
				<form:textarea path="message" class="form-control" />
				<form:errors cssClass="error" path="message" />
			</div>

			<div class="form-group col-md-6 text-center">
				<input type="submit" class="btn btn-success"
					value="<spring:message code="thread.send" />" />

				<spring:message code="thread.cancel" var="cancel" />
				<a href="route/display.do?routeId=${threadForm.route.id}" class="btn btn-danger"><jstl:out
						value="${cancel}" /></a>
			</div>

		</form:form>
	</center>
</security:authorize>