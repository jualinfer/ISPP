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



<spring:message code="comment.text" var="vehText" />
<spring:message code="comment.date" var="vehDate" />
<spring:message code="comment.star" var="vehStar" />


<spring:message code="route.formatDate" var="formatDate" />
<spring:url value="/styles/profile.css" var="profilecss" />
<link href="${profilecss}" rel="stylesheet" />
<script src="${profilecss}"></script>

<div
	class="resume d-flex flex-column justify-content-center align-items-center">

	<img src="images/passenger.png" />

</div>

<div
	class="resume d-flex flex-column justify-content-center align-items-center">
	<dt>
		<jstl:out value="${passengerName}" />
		<jstl:out value="${driver.name}" />
		<jstl:out value="${passengerSurname}" />
		<jstl:out value="${driver.surname}" />
	</dt>


	<spring:message code="driver.country" var="driverCountry" />
	<dt>
		<jstl:out value="${passengerCountry}" />
	</dt>
	<dd>
		<jstl:out value="${driver.country}" />
	</dd>

	<spring:message code="driver.phone" var="driverPhone" />
	<dt>
		<jstl:out value="${passengerPhone}" />
	</dt>
	<dd>
		<jstl:out value="${driver.phone}" />
	</dd>

	<spring:message code="driver.city" var="passengerCity" />
	<dt>
		<jstl:out value="${passengerCity}" />
	</dt>
	<dd>
		<jstl:out value="${driver.city}" />
	</dd>
	
  <a href="vehicle/list.do?driverId=${driver.id}" class="btn btn-success">View Vehicles</a>
  
	
</div>

<div class="card_">
	<div class="card-header_" id="headingTwo">
		<h2 class="mb-0">
			<button class="btn btn-link collapsed" data-toggle="collapse"
				data-target="#collapseTwo" aria-expanded="false"
				aria-controls="collapseTwo">Comments</button>
		</h2>
	</div>
</div>


<!-- Comments -->

<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
	data-parent="#accordion">
	<div class="card-body d-flex flex-column">

		<div
			class="comments d-flex flex-row align-items-baseline justify-content-center m-2">
			<div class="comments">

				<jstl:forEach var="comment" items="${driver.comments}">
					<div class="title listComment"></div>
					<div class="comment d-flex flex-column align-items-center">

						<div class="comment.driver">
							<dd>
							<dt>
								<jstl:out value="${comment.passenger.name }"></jstl:out>
								<jstl:out value="${comment.passenger.surname }"></jstl:out>
							</dt>
							</dd>
						</div>

						<div class="date-comment">

							<fmt:formatDate value="${comment.date}" pattern="${formatDate}" />
						</div>

						<div class="comment.star">
							<jstl:if test="${comment.star >= 0 && comment.star <= 0.4 }">
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
							</jstl:if>

							<jstl:if test="${comment.star >= 0.5 && comment.star <= 0.9 }">
								<i class="fas fa-star-half-alt"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
							</jstl:if>

							<jstl:if test="${comment.star >= 1 && comment.star <= 1.4 }">
								<i class="fas fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
							</jstl:if>

							<jstl:if test="${comment.star >= 1.5 && comment.star <= 1.9 }">
								<i class="fas fa-star"></i>
								<i class="fas fa-star-half-alt"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
							</jstl:if>

							<jstl:if test="${comment.star >= 2 && comment.star <= 2.4 }">
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
							</jstl:if>

							<jstl:if test="${comment.star >= 2.5 && comment.star <= 2.9 }">
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star-half-alt"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
							</jstl:if>

							<jstl:if test="${comment.star >= 3 && comment.star <= 3.4 }">
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
							</jstl:if>

							<jstl:if test="${comment.star >= 3.5 && comment.star <= 3.9 }">
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star-half-alt"></i>
								<i class="far fa-star"></i>
							</jstl:if>

							<jstl:if test="${comment.star >= 4 && comment.star <= 4.4 }">
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="far fa-star"></i>
							</jstl:if>

							<jstl:if test="${comment.star >= 4.5 && comment.star <= 4.9 }">
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star-half-alt"></i>
							</jstl:if>

							<jstl:if test="${comment.star >= 4.9 }">
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
							</jstl:if>

						</div>

						<div class="comment.text">
							<jstl:out value="${comment.text }"></jstl:out>
						</div>


					</div>

				</jstl:forEach>

			</div>
		</div>


	</div>

</div>

<div class="card_">
	<div class="card-header_" id="headingTwo">
		<h2 class="mb-0">
			<button class="btn btn-link collapsed" data-toggle="collapse"
				data-target="#collapseOne" aria-expanded="false"
				aria-controls="collapseOne">Routes</button>
		</h2>
	</div>
</div>

<div id="collapseOne" class="collapse" aria-labelledby="headingOne"
	data-parent="#accordion">
	<div class="card-body d-flex flex-column">

		<div
			class="routes d-flex flex-row align-items-baseline justify-content-center m-2">
			<div class="routes">

				<jstl:forEach var="route" items="${driver.routes}">
					<div class="title listRoute"></div>
					<div class="route d-flex flex-column align-items-center">

						<a
							class="stretched-link d-flex align-items-center justify-content-space-between flex-wrap"
							href="route/display.do?routeId=${route.id }">

							<div class="origin">
								<jstl:out value="${route.origin }"></jstl:out>
							</div>
							<div class="destination">
								<jstl:out value="${route.destination }"></jstl:out>
							</div>
						</a>
						<div class="date-route">
							<fmt:formatDate value="${route.departureDate}"
								pattern="${formatDate}" />
						</div>

					</div>
				</jstl:forEach>

			</div>
		</div>


	</div>

</div>


<div class="endList">
	<div class="circle background_pink"></div>
	<div class="circle background_blue"></div>
	<div class="circle background_green"></div>
</div>