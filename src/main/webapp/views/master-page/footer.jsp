<%--
 * footer.jsp
 *
 * Copyright (C) 2019 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>

<%@page language="java" contentType="text/html; charset=ISO-8859-1"	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="date" class="java.util.Date" />

<spring:url value="/styles/footer.css" var="footercss" />
<link href="${footercss}" rel="stylesheet" />
<script src="${footercss}"></script>

<hr />
<div class="container">
	<div class="row">
		<div class="col-auto mr-auto text-left">
		</div>
		<div class="col-auto text-right">
			<a href="?language=en"><spring:message code="english" /></a>  |  <a href="?language=es"><spring:message code="spanish" /></a>    
		</div>
	</div>
</div>
<security:authorize access="isAutenticated()">
<!-- Footer -->
<footer class="page-footer font-small blue pt-4">

    <!-- Footer Links -->
    <div class="container-fluid text-center text-md-left">

      <!-- Grid row -->
      <div class="row">

        <!-- Grid column -->
        <div class="col-md-6 mt-md-0 mt-3">

          <!-- Content -->
          <div class="imgcoche">
          <img src="images/cocheparafooter.png" height="120" width="200"/>
          </div>
          
        </div>
        <!-- Grid column -->
		
        <hr class="clearfix w-100 d-md-none pb-3">

        <!-- Grid column -->
        <div class="col-md-3 mb-md-0 mb-3">

            <!-- Links -->
            <h5 class="text-uppercase"><spring:message code="enlaces.legal"/></h5>

            <ul class="list-unstyled">
              <li>
                <a href="welcome/termsAndConditions.do" class="links" ><spring:message code="termsAndConditions"/></a>
              </li>
            </ul>

          </div>
          <!-- Grid column -->

          <!-- Grid column -->
          <div class="col-md-3 mb-md-0 mb-3">

            <!-- Links -->
            <h5 class="text-uppercase"><spring:message code="enlaces.contacto"/></h5>

            <ul class="list-unstyled">
              <li>
                <a href="mailto:ispp.grupo1819@gmail.com" class="links">ispp.grupo1819@gmail.com</a>
              </li>
            </ul>

          </div>
          
          
          <!-- Grid column -->

      </div>
      <!-- Grid row -->

    </div>
    <!-- Footer Links -->

    <!-- Copyright -->
    <div class="footer-copyright text-center py-3">© 2018 Copyright:
      <a class="links"> Trond </a>
    </div>
    <!-- Copyright -->

  </footer>
</security:authorize>
  <!-- Footer -->
  