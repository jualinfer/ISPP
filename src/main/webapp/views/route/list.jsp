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

<spring:message code="route.formatDate" var="formatDate" />
<%-- <display:table name="routes" id="row" pagesize="4" class="displaytag" requestURI="${requestURI}">

	<spring:message code="route.origin" var = "auMomentCreated" />
	<display:column property="origin" title="${auMomentCreated}" sortable="true"/>
	
	<spring:message code="route.destination" var = "auTitle" />
	<display:column property="destination" title="${auTitle}" sortable="true"/>

</display:table> --%>

<spring:url value="/styles/route.css" var="routecss" />
	<link href="${routecss}" rel="stylesheet" />
	<script src="${routecss}"></script>

<div class="text-center active-routes">
	<h3>Active routes</h3>
</div>
<jstl:forEach var="route" items="${routes }">
	<div class="title listRoute"></div>
	<div class="route d-flex flex-column align-items-center">
	<!-- AÑADIR ENLACE A RUTA  -->


		<a class="stretched-link d-flex align-items-center justify-content-space-between flex-wrap" href="route/display.do?routeId=${route.id }">

			<div class="origin">
				<jstl:out value="${route.origin }"></jstl:out>
			</div>
			<div class="to d-flex"></div>
			<div class="destination">
				<jstl:out value="${route.destination }"></jstl:out>
			</div>
		</a>
		<div class="date-route">
		<%-- 	<jstl:out value="${route.departureDate}"></jstl:out> --%>
			<fmt:formatDate value="${route.departureDate}" pattern="${formatDate}"/>
		</div>
		
		<!-- vvvvv NO SE TENIA EN CUENTA EL Nº DE ASIENTOS POR RESERVA vvvvvv -->
		<div class="available-seats d-flex">
			<p>Available seats : </p>
			<jstl:set var="remainingSeats" value="${route.availableSeats}"/>
			<jstl:forEach items="${route.reservations}" var="reservation">
				<jstl:if test="${reservation.status eq 'ACCEPTED' }">
					<jstl:set var="remainingSeats" value="${remainingSeats-reservation.seat}"/>
				</jstl:if>
			</jstl:forEach>
			<jstl:if test="${remainingSeats <= 0 }">
			<jstl:out value=" 0"/>
			</jstl:if>
			
			<jstl:if test="${remainingSeats >= 0 }">
			<jstl:out value=" ${remainingSeats}"/>
			</jstl:if>
			
		</div>

	</div>
</jstl:forEach>
<div class="endList">
	<div class="circle background_pink"></div>
	<div class="circle background_blue"></div>
	<div class="circle background_green"></div>
</div>


<security:authorize access="hasRole('DRIVER')">
	<a href="route/driver/create.do" class="btn btn-success btn-circle btn-xl"><i class="fas fa-plus fa-2x"></i></a>
</security:authorize>
<security:authorize access="hasRole('PASSENGER')">
	<a href="route/search.do" class="btn btn-primary btn-circle btn-xl"><i class="fas fa-search fa-2x"></i></a>
</security:authorize>