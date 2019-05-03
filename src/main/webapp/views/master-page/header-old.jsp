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

<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

<spring:url value="/styles/header.css" var="headercss" />
<link href="${headercss}" rel="stylesheet" />
<script src="${headercss}"></script>

<!-- <script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	crossorigin="anonymous"></script> -->
<head>
<link rel="stylesheet" type="text/css"
	href="//cdnjs.cloudflare.com/ajax/libs/cookieconsent2/3.1.0/cookieconsent.min.css" />
<script
	src="//cdnjs.cloudflare.com/ajax/libs/cookieconsent2/3.1.0/cookieconsent.min.js"></script>
<!-- <link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"> -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<!-- <script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script> -->


<script>
	window.addEventListener("load", function() {
		window.cookieconsent.initialise({
			"palette" : {
				"popup" : {
					"background" : "#b143dd"
				},
				"button" : {
					"background" : "#ffa513"
				}
			},
			"theme" : "edgeless",
			"position" : "bottom-right",
			"content" : {
				"href" : "welcome/termsAndConditions.do"
			}
		})
	});
</script>
</head>
<body>
	<div class="header-trond">
		<security:authorize access="isAuthenticated()">
			<div class="bs-example">
				<nav class="navbar navbar-expand-md navbar-light bg-light">
					<div class="logo">
						<security:authorize access="hasRole('DRIVER')">
							<a href="route/driver/listActive.do"> <img
								src="images/logoicon.png" /></a>
						</security:authorize>
						<security:authorize access="hasRole('PASSENGER')">
							<a href="route/passenger/listActive.do"> <img
								src="images/logoicon.png" /></a>
						</security:authorize>
						<security:authorize access="hasRole('ADMIN')">
							<a href="administrator/controlPanel.do"> <img
								src="images/logoicon.png" /></a>
						</security:authorize>
					</div>
	
					<button type="button" class="navbar-toggler" data-toggle="collapse"
						data-target="#navbarCollapse">
						<span class="navbar-toggler-icon"></span>
					</button>
	
					<div id="navbarCollapse" class="collapse navbar-collapse">
						<ul class="nav navbar-nav">
	
							<security:authorize access="hasRole('DRIVER')">
								<li class="nav-item active">
									<a class="botonnavbar" href="driver/displayPrincipal.do"><spring:message
											code="master.page.myProfile" /> 
									</a>
								</li>
	
								<li class="nav-item active">
									<a class="botonnavbar" href="vehicle/driver/list.do"><spring:message
											code="master.page.myVehicles" />
									</a>
								</li>
							</security:authorize>
	
							<security:authorize access="hasRole('PASSENGER')">
								<li class="nav-item active">
									<a class="botonnavbar"
									href="passenger/displayPrincipal.do"><spring:message
											code="master.page.myProfile" />
								 	</a>
								</li>
							</security:authorize>
	
							<li class="nav-item active ">
								<a href="thread/message/list.do" class="nav-link border-right"> 
									<i class="far fa-envelope"></i>
								</a>
							</li>
	
							<li class="nav-item dropdown active">
								<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
									role="button" data-toggle="dropdown" aria-haspopup="true"
									aria-expandedt456="false"> 
									<security:authentication
									property="principal.username" />
								</a>
								<div class="dropdown-menu">
									<security:authorize access="hasRole('DRIVER')">
										<a class="dropdown-item" href="driver/edit.do">
											<spring:message code="master.page.editProfile" />
										</a>
										<a class="dropdown-item" href="driver/editCredentials.do">
											<spring:message code="master.page.editCredentials" />
										</a>
									</security:authorize>
	
									<security:authorize access="hasRole('PASSENGER')">
	
										<a class="dropdown-item" href="passenger/edit.do">
											<spring:message code="master.page.editProfile" />
										</a>
										<a class="dropdown-item" href="passenger/editCredentials.do">
											<spring:message code="master.page.editCredentials" /></a>
									</security:authorize>
									
									<a class="dropdown-item" href="thread/report/list.do">
											<spring:message code="master.page.report" /></a>
											
									<security:authorize access="hasAnyRole('DRIVER', 'PASSENGER')">
										<div class="dropdown-divider"></div>
									</security:authorize>
									
									<a class="dropdown-item" href="j_spring_security_logout">
										<spring:message code="master.page.logout" />
									</a>
								</div>
							</li>
						</ul>
					</div>
				</nav>
			</div>
	
	
		
		<div class="pinkheader background_pink d-flex justify-content-center align-items-baseline">
			<security:authorize access="hasRole('DRIVER')">		
				<div class="button-white ">
					<h5>
						<a href="route/driver/create.do" class="btn btn-light btn-rounded btn-lg" role="button">
							<b><spring:message code="master.page.publicarRuta" /> </b>
						</a>
					</h5>
					<p class="text-white text-right"><spring:message code="master.page.ahorra" /></p>
				</div>
				<div class="imgdriver">
					<img src="images/headerparadriver.png" height="300" width="300" />
				</div>
			</security:authorize>
			
			<security:authorize access="hasRole('PASSENGER')">
				<div class="button-white ">
					<h5>
						<a href="route/search.do" class="btn btn-light btn-rounded btn-lg" role="button">
							<b><spring:message code="master.page.buscarViaje" /> </b>
						</a>
					</h5>
					<p class="text-white text-right"><spring:message code="master.page.mejorPrecio"/></p>
				</div>
				<div class="imgpassenger">
					<img src="images/headerparapassenger.png" height="200" width="300" />
				</div>
			</security:authorize>
			
		</div>
		</security:authorize>
	</div>
	
</body>

	<!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script> -->
		

