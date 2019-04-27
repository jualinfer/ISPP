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
		<jstl:forEach items="${threads}" var="thread">
			<a href="thread/message/view.do?threadId=${thread.id}">Route: ${thread.route.origin} -> ${thread.route.destination}</a>
			<br>
			Participants:<br>
			- ${thread.participantA.name} ${thread.participantA.surname}<br>
			- ${thread.participantB.name} ${thread.participantB.surname}
			<br><br>
		</jstl:forEach>
		
	</center>
</security:authorize>