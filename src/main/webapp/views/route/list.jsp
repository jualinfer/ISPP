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


<spring:url value="/styles/route.css" var="routecss" />
	<link href="${routecss}" rel="stylesheet" />
	<script src="${routecss}"></script>

<div class="content-principal">
	<%-- <div class="text-center active-routes">
		<h3><spring:message code="activeRoutes" /></h3>
	</div> --%>
	<jstl:forEach var="route" items="${routes }">
		<div class="title listRoute"></div>
		<a class="stretched-link text-body" href="route/display.do?routeId=${route.id }">
			<div class="route d-flex flex-column">

				<div class="date text-center text-secondary mt-2">
					<h5 class="font-weight-normal">
						<fmt:formatDate value="${route.departureDate}"
							pattern="${formatDate}" />
					</h5>
				</div>

				<div class="recorrido mx-5 mt-4 d-flex flex-column flex-wrap">
					<jstl:forEach var="point" items="${route.controlPoints}">
						<div class="d-inline-flex font-weight-bold">
							<div class="circle m-0 mr-3 b-0 align-items-baseline background_orange">
								
								<%-- <jstl:if test="${point != route.destination}">
									<div class="arrow">
										<i class="icono-arrow-down"></i>
									</div>
								</jstl:if> --%>
								
							</div>
							
							
							<p>
								<jstl:out value="${point.location}" />
								&nbsp
							</p>
							
						</div>
					</jstl:forEach>
					
				</div>
				
				<div class="available-seats d-flex justify-content-center">
					<jstl:set var="remainingSeats" value="${route.availableSeats}"/>
					<jstl:forEach items="${route.reservations}" var="reservation">
						<jstl:if test="${reservation.status eq 'ACCEPTED' }">
							<jstl:set var="remainingSeats" value="${remainingSeats-reservation.seat}"/>
						</jstl:if>
					</jstl:forEach>
					<jstl:forEach begin="1" end="${remainingSeats}" var="index">
						<div class="rectangle background_green"></div>
					</jstl:forEach>
					<jstl:forEach begin="1" end="${route.availableSeats - remainingSeats}" var="index">
						<div class="rectangle background_red"></div>
					</jstl:forEach>
				</div>
				
				<div class="driver-route-i d-flex justify-content-end mr-4">
					<div class="circle background_blue m-1"></div>
					<h5>
						<jstl:out value="${route.driver.name}" />
						<jstl:out value="${route.driver.surname}" />
					</h5>
				</div>
			
			</div>
		</a>
	</jstl:forEach>
	<div class="endList">
		<div class="circle background_pink"></div>
		<div class="circle background_blue"></div>
		<div class="circle background_green"></div>
	</div>
</div>


<%-- <security:authorize access="hasRole('DRIVER')">
	<a href="route/driver/create.do" class="btn btn-success btn-circle btn-xl"><i class="fas fa-plus fa-2x"></i></a>
</security:authorize>
<security:authorize access="hasRole('PASSENGER')">
	<a href="route/search.do" class="btn btn-primary btn-circle btn-xl"><i class="fas fa-search fa-2x"></i></a>
</security:authorize> --%>