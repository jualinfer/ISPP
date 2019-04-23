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

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	crossorigin="anonymous"></script>
<head>
<link rel="stylesheet" type="text/css"
	href="//cdnjs.cloudflare.com/ajax/libs/cookieconsent2/3.1.0/cookieconsent.min.css" />
<script
	src="//cdnjs.cloudflare.com/ajax/libs/cookieconsent2/3.1.0/cookieconsent.min.js"></script>
<script>
window.addEventListener("load", function(){
window.cookieconsent.initialise({
 "palette": {
   "popup": {
     "background": "#b143dd"
   },
   "button": {
     "background": "#ffa513"
   }
 },
 "theme": "edgeless",
 "position": "bottom-right",
      "content": {
            "href": "welcome/termsAndConditions.do"
          }
})});
</script>
</head>

<!------ Include the above in your HEAD tag ---------->

<security:authorize access="isAuthenticated()">
	<div class="logo">
		<security:authorize access="hasRole('DRIVER')">
		<a href="route/driver/listActive.do" >
		
		<img src="images/logoicon.png" /></a>
		</security:authorize>
		<security:authorize access="hasRole('PASSENGER')">
		<a href="route/passenger/listActive.do" >
		
		<img src="images/logoicon.png" /></a>
		</security:authorize>
	</div>
	<div class="user-details d-flex justify-content-end">
		<div class="item-details messages">
			<a class="nav-link border-right" href="#"> 
				<i class="far fa-envelope">
					<!-- <span class="badge badge-danger">11</span> --> <!-- numero de mensajes -->
				</i>
			</a>
		</div>
		<div class="item-details notificaciones">
			<a class="nav-link border-right" href="#"> 
				<i class="far fa-bell"></i>
			</a>
		</div>
		<div class="item-details perfil">
			<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
 				<security:authentication property="principal.username" />
			</a>
			<div class="dropdown-menu" aria-labelledby="navbarDropdown">
<!-- 				<a class="dropdown-item" href="#">Visit my profile</a>  	FUNCIONALIDAD AUN SIN IMPLEMENTAR-->
<!-- 				<a class="dropdown-item" href="#">Configuration</a> 		FUNCIONALIDAD AUN SIN IMPLEMENTAR-->
				<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="j_spring_security_logout"><spring:message code="master.page.logout" /></a>
			</div>
		</div>
	</div>
	
	<!-- --- -->
	<nav class="navbar navbar-icon-top navbar-expand-lg" style="background-color: #fa3274;">
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
  
  <!-- vvv ESTE MENU DESPLEGABLE NO APORTABA NADA  vvv -->
<!--     <ul class="navbar-nav mr-auto"> -->
     
<!--       <li class="nav-item dropdown"> -->
<!--         <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> -->
<!--           <i class="fas fa-bars"></i> -->
<!--           </i> -->
<!--           Menu -->
<!--         </a> -->
<!--         <div class="dropdown-menu" aria-labelledby="navbarDropdown"> -->
<!--           <a class="dropdown-item" href="#">Action</a> -->
<!--           <a class="dropdown-item" href="#">Another action</a> -->
<!--           <div class="dropdown-divider"></div> -->
<!--           <a class="dropdown-item" href="#">Something else here</a> -->
<!--         </div> -->
<!--       </li>  -->
<!--       <li class="nav-item"> -->
        
<!--       </li> -->
    
<!--     </ul> -->
    <ul class="navbar-nav ">

      
     <li class="nav-item dropdown">
        
      </li>
      
    <div>
    <li class="nav-item">
     <security:authorize access="hasRole('PASSENGER')">
        <a class="nav-link" href="route/search.do">
          <i class="fa fa-search">
          </i>
         
        </a>
        </security:authorize>
      </li>
    </div>
  </div>
  
      <security:authorize access="hasRole('DRIVER')">
    <div>
   
        <a class="nav-link" href="route/driver/create.do">
          <i class="fa fa-plus">
          </i>
         
        </a>
  
    </div>
    </security:authorize>
  </div>
  
</nav>

<nav class="navbar navbar-light" style="background-color: #fa3274;">
    <div class="container">
  


</nav>
</security:authorize>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
	integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
	integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
	crossorigin="anonymous"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	crossorigin="anonymous"></script>
