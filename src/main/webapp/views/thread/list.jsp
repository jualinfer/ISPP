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
		<h3>
			<spring:message code="messages" />
		</h3>
	</jstl:if>
	<jstl:if test="${isReport}">
		<h3>
			<spring:message code="reports" />
		</h3>
	</jstl:if>
</div>
<spring:url value="/styles/messages.css" var="messages" />
<link href="${messages}" rel="stylesheet" />
<script src="${messages}"></script>

<security:authorize access="hasAnyRole('DRIVER', 'PASSENGER', 'ADMIN')">

<div class="col-xs-12 col-sm-10 col-md-8 mx-auto text-center">
		<jstl:forEach items="${threads}" var="thread">
			<div style="padding-top: 10px">
				<div class="card text-center">
					<div class="card-header">
						<jstl:if test="${!isReport}">
							<a href="thread/message/view.do?threadId=${thread.id}">
								${thread.route.origin} <i class="fas fa-arrow-right"></i>
								${thread.route.destination}
							</a>
						</jstl:if>
						<jstl:if test="${isReport}">
							<h3>
								<a href="thread/report/view.do?threadId=${thread.id}">
									${thread.route.origin} <i class="fas fa-arrow-right"></i>
									${thread.route.destination}
								</a>
							</h3>
						</jstl:if>

						<span class="fa-stack"> <i
							class="fa fa-comment fa-stack-2x" style="color: red"></i> <strong
							class="fa-stack-1x fa-stack-text fa-inverse">${thread.newMessages}</strong>
						</span> <br>
					</div>
					<div class="card-body">

						<spring:message code="thread.participants" />
						<br> <span class="badge badge-pill badge-primary">
							${thread.participantA.name} ${thread.participantA.surname} </span> <br>
						<jstl:if test="${!isReport}">
							<div class="container2" style="padding-top: 5px">
								<span class="badge badge-pill badge-primary">
									${thread.participantB.name} ${thread.participantB.surname} </span>
							</div>
						</jstl:if>
						<jstl:if test="${isReport}">
							<div class="container2" style="padding-top: 5px">
								<span class="badge badge-pill badge-danger">
									${thread.participantB.name} ${thread.participantB.surname} </span>
							</div>
						</jstl:if>

						<div>
							<security:authorize access="hasRole('ADMIN')">
								<jstl:if test="${isReport && !thread.reportedUser.userAccount.banned}">
										<a href="administrator/ban.do?userId=${thread.reportedUser.id}" > <spring:message code="administrator.ban"/></a>
								</jstl:if>
								<jstl:if test="${isReport && thread.reportedUser.userAccount.banned}">
										<spring:message code="report.bannedUser" />
								</jstl:if>
							</security:authorize>					
						</div>

					</div>
					<div class="card-footer text-muted">

						<br> <i class="fa fa-calendar" aria-hidden="true"></i>
						<fmt:formatDate value="${thread.lastMessage.issueDate}"
							type="both" dateStyle="medium" timeStyle="short" />
						<p>
							<jstl:if test="${thread.closed}">
								<i class="fas fa-lock"></i>
								<spring:message code="thread.closed" />
							</jstl:if>
						</p>
					</div>
					<br> <br> <br>
				</div>
			</div>
		</jstl:forEach>

	</div>
</security:authorize>