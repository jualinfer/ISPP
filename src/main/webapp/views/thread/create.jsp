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
	<jstl:if test="${!isReport}">
		<h3><spring:message code="messages" /></h3>
	</jstl:if>
	<jstl:if test="${isReport}">
		<h3><spring:message code="reports" /></h3>
	</jstl:if>
</div>

<security:authorize access="hasAnyRole('DRIVER', 'PASSENGER', 'ADMIN')">
	<center>
		<p style="font-size: 22px">${threadForm.route.origin}<i class="fas fa-arrow-right"></i>${threadForm.route.destination}</p>
		<br>
		<jstl:if test="${!isReport}">
			<i class="fa fa-envelope" aria-hidden="true"></i>
			<spring:message code="messages.for" /><span class="badge badge-pill badge-primary" style="font-size: 22px">
					${threadForm.user.name} ${threadForm.user.surname}</span>
			<br>
		</jstl:if>
		<jstl:if test="${isReport}">
			<spring:message code="reports.reporting" />: <span class="badge badge-pill badge-warning" style="font-size: 18px">${connectedUser.name} ${connectedUser.surname}</span>
			<br>
			<div style="padding-top:5px;">
			<spring:message code="reports.reported" />: <span class="badge badge-pill badge-danger" style="font-size: 18px">${threadForm.user.name} ${threadForm.user.surname}</span>
			<jstl:if test="${fn:contains(threadForm.user.userAccount.authorities, 'DRIVER')}">
			<i class="fas fa-car"></i>
			</jstl:if>
			<jstl:if test="${fn:contains(threadForm.user.userAccount.authorities, 'PASSENGER')}">
			<i class="fas fa-briefcase"></i>
			</jstl:if>
			</div>
			<br>
		</jstl:if>
		<form:form action="${requestURI}" modelAttribute="threadForm">
			<form:hidden path="route" />
			<form:hidden path="user" />
			
			<spring:message code="placeholderMessages" var="vrMessagesPl"/>
			<div class="form-group col-md-12">
				<form:textarea path="message" class="form-control" placeholder="${vrMessagesPl}" />
				<form:errors cssClass="error" path="message" />
			</div>

			<div class="form-group col-md-12 text-center">
				<input type="submit" class="btn btn-success"
					value="<spring:message code="thread.send" />" />

				<spring:message code="thread.cancel" var="cancel" />
				<a href="route/display.do?routeId=${threadForm.route.id}" class="btn btn-danger"><jstl:out
						value="${cancel}" /></a>
			</div>

		</form:form>
	</center>
</security:authorize>