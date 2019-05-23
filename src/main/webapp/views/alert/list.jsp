<%--
 * list.jsp
 *
 * Copyright (C) 2019 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>

<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<style>
html {
	font-size: calc(0.5em + 1vw)
}
</style>

<%-- Stored message variables --%>


<div class="text-center active-routes">

	<h3>
		<spring:message code="alerts.list" />
	</h3>

</div>
<spring:url value="/styles/messages.css" var="messages" />
<link href="${messages}" rel="stylesheet" />
<script src="${messages}"></script>

<spring:message code="alert.relatedRoute.orig" var="routeOrig" />
<spring:message code="alert.relatedRoute.dest" var="routeDest" />
<spring:message code="alert.alertType" var="alertType" />
<spring:message code="alert.delete" var="delete" />
<spring:message code="alert.seen" var="seen" />
<spring:message code="alert.confirm.delete" var="confirm" />


<div class="content-principal">

	<jstl:forEach items="${alerts}" var="alert">
		<div style="padding-top: 10px">
			<div class="card text-center">
				<div class="card-header">
					<spring:url var="seenUrl" value="alert/alertSeen.do">
						<spring:param name="varId" value="${alert.id}" />
					</spring:url>

					<spring:url var="deleteUrl" value="alert/delete.do">
						<spring:param name="varId" value="${alert.id}" />
					</spring:url>

					<spring:url var="editUrl" value="alert/edit.do">
						<%-- <spring:param name="varId" value="${alert.id}" /> --%>
					</spring:url>


					${alert.relatedRoute.origin} <i class="fas fa-arrow-right"></i>
					${alert.relatedRoute.destination} <span class="fa-stack"> <jstl:if
							test="${alert.isRead == false}">

							<i class="fa fa-comment fa-stack-2x" style="color: red"></i>
							<strong class="fa-stack-1x fa-stack-text fa-inverse"> <jstl:if
									test="${alert.isRead == false}">!</jstl:if>
							</strong>
						</jstl:if>
					</span> <br>
				</div>
				<div class="card-body">


					<br> <span class="badge badge-pill badge-primary">
						${alert.typeAlert}</span>
					<p>${alert.alertBody}</p>
					<br>

					<spring:message code="alert.sender" />
					<br> <span class="badge badge-pill badge-primary">
						${alert.sender.name} ${alert.sender.surname} </span> <br> <br>
				</div>
				<div class="card-footer text-muted">
					<div style="padding: 5px">
						<i class="fa fa-calendar" aria-hidden="true"></i>
						<fmt:formatDate value="${alert.date}" type="both"
							dateStyle="medium" timeStyle="short" />
					</div>
					<div class="text-center">

						<a href="${deleteUrl}"
							class="btn btn-success btn-lg p-1 text-white"
							onclick="return confirm('${confirm}')"> <spring:message
								code="alert.delete" />
						</a>

						<jstl:if test="${alert.isRead == false}">


							<a href="${seenUrl}"
								class="btn btn-success btn-lg p-1 text-white"> <spring:message
									code="alert.seen" /> <i class="fas fa-eye"></i>
							</a>


						</jstl:if>


					</div>

				</div>
			</div>
		</div>
	</jstl:forEach>
</div>
<security:authorize access="hasRole('ADMIN')">
	<a href="alert/edit.do" class="btn btn-success btn-lg p-1 text-white"><spring:message
			code="alert.create" /> </a>
</security:authorize>

