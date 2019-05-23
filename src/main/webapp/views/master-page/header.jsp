<%--
 * header.jsp
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
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
@MEDIA ( max-width :992px) {
		.navbar-collapse .navbar-nav {
		align-items: center;
	}
	.navbar-collapse li {
		width: 45%;
		text-align: center;
	}
	.navbar-nav li a {
		justify-content: center;
	}
	.fa-bell:AFTER, .fa-envelope:AFTER {
		content: '<spring:message code="master.page.alerts" />';
		font-family: font-familyPoppins, sans-serif;
		font-size: 16px;
		font-weight: bold;
		margin-left: 5px;
	}
	.fa-envelope:AFTER {
		content: '<spring:message code="master.page.messages" />';
	}
	.navbar-nav .border--bottom:AFTER {
		content: '';
		display: block;
		border: 1px solid rgba(255, 255, 255, 0.3);
		width: 100%;
	}
}

@MEDIA ( min-width :993px) {
	.home-trond {
		position: absolute;
		right: 47%;
		top: 2px;
	}
	.navbar-collapse {
		width: 15%;
	}
}
</style>

<spring:url value="/styles/header.css" var="headercss" />
<link href="${headercss}" rel="stylesheet" />
<script src="${headercss}"></script>

<security:authorize access="isAuthenticated()">
	<security:authentication property="principal.banned" var="banned" />
	<nav class="navbar navbar-expand-lg navbar-dark p-1"
		style="background-color: #fa3274;">
		<div class="home-trond mx-auto order-0">
			<security:authorize access="hasRole('DRIVER')">
				<a class="navbar-brand mx-auto" href="route/driver/listActive.do"><img
					src="images/trondicon-header-white.png" width="82px" height="42px" /></a>
			</security:authorize>
			<security:authorize access="hasRole('PASSENGER')">
				<a class="navbar-brand mx-auto" href="route/passenger/listActive.do"><img
					src="images/trondicon-header-white.png" width="82px" height="42px" /></a>
			</security:authorize>
			<security:authorize access="hasRole('ADMIN')">
				<a class="navbar-brand mx-auto" href="thread/report/list.do"><img
					src="images/trondicon-header-white.png" width="82px" height="42px" /></a>
			</security:authorize>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target=".dual-collapse2">
				<span class="navbar-toggler-icon"></span>
			</button>
		</div>

		<div
			class="navbar-collapse collapse order-1 order-md-0 dual-collapse2">
			<ul class="navbar-nav navbar-route">
				<!-- mr -auto -->
				<jstl:if test="${banned}">
					<li class="nav-item active"><span
						class="navbar-text d-flex align-items-center ml-1"> <spring:message
								code="master.page.banned" />
					</span></li>
				</jstl:if>
				<security:authorize access="hasRole('DRIVER')">
					<li class="nav-item active"><a
						class="botonnavbar d-flex align-items-center"
						href="driver/displayPrincipal.do"> <i
							class="fa fa-smile-o mr-1" style="font-size: 16px;"></i>
						<spring:message code="master.page.myProfile" />
					</a></li>
					<jstl:if test="${!banned}">
						<li class="nav-item active"><a
							class="botonnavbar d-flex align-items-center"
							href="vehicle/driver/list.do"> <i
								class="fa fa-automobile mr-1" style="font-size: 16px;"></i>
							<spring:message code="master.page.myVehicles" />
						</a></li>
						<li class="nav-item active"><a
							class="d-flex align-items-center ml-1"
							href="route/driver/create.do"> <img
								src="images/headerparadriver.png" height="45" width="75" />
						</a></li>
						<li class="nav-item active border--bottom"><a
							class="nav-link d-flex align-items-center ml-1"
							href="route/driver/create.do"> <spring:message
									code="master.page.publicarRuta" />
						</a></li>
					</jstl:if>
				</security:authorize>
				<security:authorize access="hasRole('PASSENGER')">
					<li class="nav-item active"><a
						class="botonnavbar d-flex align-items-center"
						href="passenger/displayPrincipal.do"> <i
							class="fa fa-smile-o mr-1" style="font-size: 16px;"></i> <spring:message
								code="master.page.myProfile" />
					</a></li>
					<jstl:if test="${!banned}">
						<li class="nav-item active"><a
							class="d-flex align-items-center" href="route/search.do"> <img
								src="images/headerparapassenger.png" height="45" width="90" />
						</a></li>
						<li class="nav-item active border--bottom"><a
							class="nav-link d-flex align-items-center ml-1"
							href="route/search.do"> <spring:message
									code="master.page.buscarViaje" />
						</a></li>
					</jstl:if>
				</security:authorize>
				<security:authorize access="hasRole('ADMIN')">
					<li class="nav-item active border--bottom"><a
						class="botonnavbar d-flex align-items-center" href="alert/edit.do">
							<i class="fa fa-bell mr-1" style="font-size: 16px;"></i> <spring:message
								code="master.page.sendAlert" />
					</a></li>
				</security:authorize>
			</ul>
		</div>

		<div class="navbar-collapse collapse order-3 dual-collapse2">
			<ul class="navbar-nav ml-auto">
				<!-- ml- auto -->
				<jstl:if test="${!banned}">
					<security:authorize access="hasAnyRole('DRIVER', 'PASSENGER')">
						<li class="nav-item active border--bottom"><a
							href="alert/list.do" class="nav-link"> <i class="fa fa-bell"
								style="font-size: 24px;"></i>
						</a></li>
					</security:authorize>
					<li class="nav-item active border--bottom"><a
						href="thread/message/list.do" class="nav-link"> <i
							class="fa fa-envelope" style="font-size: 24px;"></i>
					</a></li>
				</jstl:if>
				<li class="nav-item dropdown active"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false" style="font-size: calc(0.6em + 0.5vw)"> <security:authentication
							property="principal.username" />
				</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<jstl:if test="${!banned}">
							<security:authorize access="hasRole('DRIVER')">
								<a class="dropdown-item" href="driver/edit.do"> <spring:message
										code="master.page.editProfile" />
								</a>
								<a class="dropdown-item" href="driver/editCredentials.do"> <spring:message
										code="master.page.editCredentials" />
								</a>
							</security:authorize>

							<security:authorize access="hasRole('PASSENGER')">
								<a class="dropdown-item" href="passenger/edit.do"> <spring:message
										code="master.page.editProfile" />
								</a>
								<a class="dropdown-item" href="passenger/editCredentials.do" >
									<spring:message code="master.page.editCredentials" />
								</a>
							</security:authorize>

							<a class="dropdown-item" href="thread/report/list.do"> <spring:message
									code="master.page.report" />
							</a>

							<div class="dropdown-divider"></div>
						</jstl:if>
						<a class="dropdown-item" href="j_spring_security_logout"> <spring:message
								code="master.page.logout" />
						</a>
					</div></li>
			</ul>
		</div>
	</nav>

	<div style="background-color: #ff6b9b; padding: 24px"></div>

</security:authorize>
