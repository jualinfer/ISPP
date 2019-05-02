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
<div class="text-center active-routes">
	<jstl:if test="${!isReport}">
		<h3><spring:message code="messages" /></h3>
	</jstl:if>
	<jstl:if test="${isReport}">
		<h3><spring:message code="reports" /></h3>
	</jstl:if>
</div>
<spring:url value="/styles/messages.css" var="messages" />
<link href="${messages}" rel="stylesheet" />
<script src="${messages}"></script>

<security:authorize access="hasAnyRole('DRIVER', 'PASSENGER', 'ADMIN')">
	<center>
		<jstl:forEach items="${threads}" var="thread">
			<div style="padding-top: 10px">
				<div class="card text-center" style="width: 70rem;">
					<div class="card-header">

						<a href="thread/message/view.do?threadId=${thread.id}">
							${thread.route.origin} <i class="fas fa-arrow-right"></i>
							${thread.route.destination}
						</a> <span class="fa-stack"> <i
							class="fa fa-comment fa-stack-2x" style="color: red"></i> <strong
							class="fa-stack-1x fa-stack-text fa-inverse">${thread.newMessages}</strong>
						</span> <br>
					</div>
					<div class="card-body">

						<spring:message code="thread.participants" />
						<br> <span class="badge badge-pill badge-primary">
							${thread.participantA.name} ${thread.participantA.surname} </span> <br>
						<div class="container2" style="padding-top: 5px">
							<span class="badge badge-pill badge-primary">
								${thread.participantB.name} ${thread.participantB.surname} </span>
						</div>
						<div>
							<security:authorize access="hasRole('ADMIN')">
								<jstl:if test="${isReport && !thread.reportedUser.userAccount.banned}">
										<a href="administrator/ban.do?userId=${thread.reportedUser.id}" > <spring:message code="administrator.ban"/></a>
								</jstl:if>
							</security:authorize>					
						</div>
					</div>
					<div class="card-footer text-muted">

						<br> <i class="fa fa-calendar" aria-hidden="true"></i>
						<fmt:formatDate value="${thread.lastMessage.issueDate}"
							type="both" dateStyle="medium" timeStyle="short" />
					</div>
					<br>
					<jstl:if test="${thread.closed}">[<spring:message code="thread.closed" />]</jstl:if>
					<br><br>
				</div>
			</div>
		</jstl:forEach>

	</center>
</security:authorize>