<%--
 * footer.jsp
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
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

<jsp:useBean id="date" class="java.util.Date" />

<spring:url value="/styles/footer.css" var="footercss" />
<link href="${footercss}" rel="stylesheet" />
<script src="${footercss}"></script>

<style>
@MEDIA ( max-width :405px) {
	.imgcoche {
		display:none;
	}
}

@MEDIA ( max-width :770px) {
	.legal-contact {
		flex-direction: column;
		text-align: left;
	}
}

@MEDIA ( max-width :480px) {
	.legal-contact a {
		font-size: 15px;
	}
}
</style>

<hr />
<div class="container">
	<div class="row">
		<div class="col-auto mr-auto text-left"></div>
		<div class="col-auto text-right">
			<a href="?language=en"><spring:message code="english" /></a> | <a
				href="?language=es"><spring:message code="spanish" /></a>
		</div>
	</div>
</div>
<security:authorize access="isAuthenticated()">
	<!-- Footer -->
	<footer class="page-footer font-small blue pt-4 sticky-bottom">

		<!-- Footer Links -->
		<div class="container-fluid text-center text-md-left">

			<!-- Grid row -->
			<div class="d-flex justify-content-around">

				<!-- Grid column -->
				<div class="">

					<!-- Content -->
					<div class="imgcoche">
						<img src="images/cocheparafooter.png" height="120" width="200" />
					</div>

				</div>
				<!-- Grid column -->

				<!-- <hr class="clearfix w-100 d-md-none pb-3"> -->

				<!-- Grid column -->
				<div class="legal-contact d-flex justify-content-arround">
					<div class="mr-4">

						<!-- Links -->
						<h5 class="text-uppercase">
							<spring:message code="enlaces.legal" />
						</h5>

						<ul class="list-unstyled">
							<li><a href="welcome/termsAndConditions.do" class="links"><spring:message
										code="termsAndConditions" /></a></li>
						</ul>

					</div>
					<!-- Grid column -->

					<!-- Grid column -->
					<div class="">

						<!-- Links -->
						<h5 class="text-uppercase">
							<spring:message code="enlaces.contacto" />
						</h5>
					
						<ul class="list-unstyled">
							<li><a href="mailto:ispp.grupo1819@gmail.com" class="links">ispp.grupo1819@gmail.com</a>
							</li>
						</ul>

					</div>
				</div>


				<!-- Grid column -->

			</div>
			<!-- Grid row -->

		</div>
		<!-- Footer Links -->

		<!-- Copyright -->
		<div class="footer-copyright text-center py-3">
			© 2018 Copyright: <a class="links"> Trond </a>
		</div>
		<!-- Copyright -->

	</footer>
</security:authorize>
<!-- Footer -->
