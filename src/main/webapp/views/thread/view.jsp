<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		<a href="route/display.do?routeId=${thread.route.id}"><p style="font-size: 25px">${thread.route.origin}
			<i class="fas fa-arrow-right"></i> ${thread.route.destination}
		</p></a>
		<br>
	</center>
	<jstl:forEach items="${thread.messages}" var="message">
		<div class="jumbotron">

			<jstl:if test="${message.fromAtoB == true}">
				<span class="badge badge-pill badge-primary" style="font-size: 22px">
				${thread.participantA.name}
						${thread.participantA.surname}</span>
			</jstl:if>
			<jstl:if test="${message.fromAtoB == false}">
				<span class="badge badge-pill badge-primary" style="font-size: 22px">
					${thread.participantB.name} ${thread.participantB.surname}</span>

			</jstl:if>
			<p style="text-align: right;">
				<fmt:formatDate value="${message.issueDate}" type="both"
					dateStyle="medium" timeStyle="short" />
			</p>
			
			<center>
				<p style="font-size: 18px">${message.content}</p>
			</center>
			<br> <br>

		</div>

	</jstl:forEach>
	<center>
		<form:form action="${requestURI}" modelAttribute="messageForm">
			<form:hidden path="thread" />

			<div class="form-group col-md-12">
				<form:textarea path="content" class="form-control" />
				<form:errors cssClass="error" path="content" />
			</div>

			<div class="form-group col-md-6 text-center">
				<input type="submit" class="btn btn-success"
					value="<spring:message code="thread.send" />" />

				<spring:message code="thread.back" var="back" />
				<a href="thread/message/list.do"
					class="btn btn-danger"><jstl:out value="${back}" /></a>
			</div>

		</form:form>
	</center>

</security:authorize>