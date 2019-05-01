<%--
 * display.jsp
 *
 * Copyright (C) 2018 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>

<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />
<spring:url value="/styles/route.css" var="routecss" />
<link href="${routecss}" rel="stylesheet" />
<script src="${routecss}"></script>
<link rel="stylesheet" href="/path/to/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css" />
<div class="text-center active-routes">
	<h3>Confirm reservation</h3>
</div>

<%-- Stored message variables --%>

<spring:message code="reservation.price"  var="msgPrice"/>
<spring:message code="reservation.confirm"  var="confirm"/>
<spring:message code="reservation.cancel"  var="cancel"/>
<spring:message code="reservation.confirm.message" var="msgConfirm" />



<center>
	<div class="col-sm-10 text-center" style="padding-top: 20px;">
		<h2><jstl:out value="${msgConfirm}"/></h2>
	</div>
</center>

<center>
	<div class="col-sm-6 text-center" style="padding-top: 20px;">
		<h4><jstl:out value="${msgPrice}" />:</h4>
		<h3><span class="badge badge-success"><jstl:out value="${reservation.price}" /> &euro;</span></h3>
		<br />
	</div>
</center>

<center>
	<form:form action="reservation/passenger/confirmReservation.do" modelAttribute="reservation">
		<form:hidden path="seat"/>
		<form:hidden path="origin"/>
		<form:hidden path="destination"/>
		<form:hidden path="status"/>
		<form:hidden path="luggageSize"/>
		<form:hidden path="price"/>
		<form:hidden path="driverPickedMe"/>
		<form:hidden path="driverNoPickedMe"/>
		<form:hidden path="passenger"/>
		<form:hidden path="route"/>
		
		<div class="col-sm-6 text-center" style="padding-top: 20px;">
		<input type="submit" class="btn btn btn-success" value="${confirm}" />
		
		<input type="button" name="cancel" class="btn btn-warning"
				value="<spring:message code="reservation.cancel" />"
				onclick="javascript: relativeRedir('reservation/passenger/create.do?routeId=${route.id}');" />
		
		
	</div>
	
	</form:form>
	
	
</center>





