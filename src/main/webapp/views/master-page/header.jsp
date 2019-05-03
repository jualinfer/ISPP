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

<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
	href="//cdnjs.cloudflare.com/ajax/libs/cookieconsent2/3.1.0/cookieconsent.min.css" />
<script
	src="//cdnjs.cloudflare.com/ajax/libs/cookieconsent2/3.1.0/cookieconsent.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

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
	<security:authorize access="isAuthenticated()">
		<nav class="navbar navbar-expand-lg navbar-light bg-light p-1">
			<div class="navbar-collapse collapse w-100 order-1 order-md-0 dual-collapse2">
				<ul class="navbar-nav mr-auto">
					<security:authorize access="hasRole('DRIVER')">
						<li class="nav-item active">
							<a class="botonnavbar d-flex align-items-center" href="driver/displayPrincipal.do">
								<i class="fa fa-smile-o" style="font-size:16px;"></i><spring:message code="master.page.myProfile" /> 
							</a>
						</li>
						<li class="nav-item active">
							<a class="botonnavbar d-flex align-items-center" href="vehicle/driver/list.do">
								<i class="fa fa-automobile" style="font-size:16px;"></i><spring:message code="master.page.myVehicles" />
							</a>
						</li>
					</security:authorize>
					<security:authorize access="hasRole('PASSENGER')">
						<li class="nav-item active">
							<a class="botonnavbar d-flex align-items-center" href="passenger/displayPrincipal.do">
								<i class="fa fa-smile-o" style="font-size:16px;"></i><spring:message code="master.page.myProfile" />
							</a>
						</li>
					</security:authorize>
				</ul>
			</div>
			<div class="mx-auto order-0">
				<security:authorize access="hasRole('DRIVER')">
					<a class="navbar-brand mx-auto" href="route/driver/listActive.do"><img src="images/trondicon-original-ajustado.png" width="82px" height="42px" /></a>
				</security:authorize>
				<security:authorize access="hasRole('PASSENGER')">
					<a class="navbar-brand mx-auto" href="route/passenger/listActive.do"><img src="images/trondicon-original-ajustado.png" width="82px" height="42px" /></a>
				</security:authorize>
				<security:authorize access="hasRole('ADMIN')">
					<a class="navbar-brand mx-auto" href="thread/report/listActive.do"><img src="images/trondicon-original-ajustado.png" width="82px" height="42px" /></a>
				</security:authorize>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target=".dual-collapse2">
					<span class="navbar-toggler-icon"></span>
				</button>
			</div>
			<div class="navbar-collapse collapse w-100 order-3 dual-collapse2">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item active ">
						<a href="alert/list.do" class="nav-link"> 
							<i class="fa fa-bell-o" style="font-size: 24px;"></i>
						</a>
					</li>
					<li class="nav-item active ">
						<a href="thread/message/list.do" class="nav-link"> 
							<i class="fa fa-envelope-o" style="font-size: 24px;"></i>
						</a>
					</li>
					<li class="nav-item dropdown active">
						<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> 
							<security:authentication property="principal.username" />
						</a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
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
									<spring:message code="master.page.editCredentials" />
								</a>
							</security:authorize>
							
							<a class="dropdown-item" href="thread/report/list.do">
								<spring:message code="master.page.report" />
							</a>
									
							<div class="dropdown-divider"></div>
							
							<a class="dropdown-item" href="j_spring_security_logout">
								<spring:message code="master.page.logout" />
							</a>
						</div>
					</li>
				</ul>
			</div>
		</nav>
			
		
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
	
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" 
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" 
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" 
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	
</body>
