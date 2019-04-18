<%--
 * action-1.jsp
 *
 * Copyright (C) 2019 Universidad de Sevilla
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
	<h3><spring:message code="makeReservation" /></h3>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<security:authorize access="hasRole('PASSENGER')">
	<center>
		<form:form action="${requestURI}" modelAttribute="reservation">
			<form:hidden path="route"/>
			<form:hidden path="availableSeats"/>
			
			<div class="form-group col-md-6">
				<div class="input-group">
					<div class="input-group-prepend">
						<span class="input-group-text" id="orig2"><spring:message code="reservation.origin" /></span>
					</div>
					<form:select path="origin" class="form-control" required="true" id="orig" onchange="calculatePrice()">
						<form:options items="${reservation.route.controlPoints}" itemLabel="location" />
					</form:select>
				</div>
				<form:errors cssClass="error" path="origin" />
			</div>
			
			<div class="form-group col-md-6">
				<div class="input-group">
					<div class="input-group-prepend">
						<span class="input-group-text" id="dest2"><spring:message code="reservation.destination" /></span>
					</div>
					<form:select path="destination" class="form-control" required="true" id="dest" onchange="calculatePrice()">
						<form:options items="${reservation.route.controlPoints}" itemLabel="location" />
					</form:select>
				</div>
				<form:errors cssClass="error" path="destination" />
			</div>
			
			<div class="form-group col-md-6">
				<div class="input-group">
					<div class="input-group-prepend">
						<span class="input-group-text" id="seats2"><spring:message code="reservation.seats" /></span>
					</div>
					<form:select path="requestedSeats" id="seats" class="form-control" required="true" onchange="calculatePrice()">
						<jstl:forEach var="x" begin="1" end="${reservation.availableSeats}">
							<form:option label="${x}" value="${x}"></form:option>
						</jstl:forEach>
					</form:select>
				</div>
				<form:errors cssClass="error" path="requestedSeats" />
			</div>
			
			<div class="form-group col-md-6">
				<div class="input-group">
					<div class="input-group-prepend">
						<span class="input-group-text" id="luggage2"><spring:message code="reservation.luggage" /></span>
					</div>
				<spring:message code="reserv.luggage.none"  var = "noneMsg"/>	
				<spring:message code="reserv.luggage.small"  var = "smallMsg"/>
				<spring:message code="reserv.luggage.medium"  var = "mediumMsg"/>
				<spring:message code="reserv.luggage.big"  var = "bigMsg"/>
					<form:select path="luggageSize" class="form-control" required="true" id="luggage">
						<form:option value="NOTHING" label="${noneMsg}"/>
						<form:option value="SMALL" label="${smallMsg}"/>
						<form:option value="MEDIUM" label="${mediumMsg}"/>
						<form:option value="BIG" label="${bigMsg}"/>
					</form:select>
				</div>
				<form:errors cssClass="error" path="luggageSize" />
			</div>
			
			<h4><spring:message code="reservation.price" />: <span class="badge badge-success" id="price"></span></h4>
			<br />
			
			<script id="botonStripe" src="https://checkout.stripe.com/checkout.js" class="stripe-button"
				data-key="pk_test_lx9QYYAhpwYKowZ5iqmKbs4Z00CaE1E067"
				data-amount="110"
				data-name="Trond"
				data-description="Request seats"
				data-image="https://stripe.com/img/documentation/checkout/marketplace.png"
				data-locale="auto"
				data-currency="${currency}" >
			</script>
			
			<input type="button" name="cancel" class="btn btn-danger"
				value="<spring:message code="route.cancel" />"
				onclick="javascript: relativeRedir('route/display.do?routeId=${reservation.route.id}');" />
			<br />
			
		</form:form>
		
		
	</center>
	<script type="text/javascript">
		function calculatePrice() {
			var cpOrders = {};
			var cpDistances = {};
			<jstl:forEach items="${reservation.route.controlPoints}" var="cp" varStatus="status">
			cpOrders["<jstl:out value="${cp.id}" />"] = <jstl:out value="${cp.arrivalOrder}" />;
			cpDistances["<jstl:out value="${cp.arrivalOrder}" />"] = <jstl:out value="${cp.distance}" />;
			</jstl:forEach>
			var originId = document.getElementById("orig").value;
			var destinationId = document.getElementById("dest").value;
			var originOrder = parseInt(cpOrders[originId]);
			var destinationOrder = parseInt(cpOrders[destinationId]);
			if (originOrder < destinationOrder) {
				var totalDistance = 0.0;
				for (var i = originOrder + 1; i <= destinationOrder; i++) {
					totalDistance = totalDistance + parseFloat(cpDistances[i.toString()]);
				}
				var price = 1.0;
				if (totalDistance > 9.0) {
					price = price + (totalDistance - 9.0) * 0.11;
				}
				price = price * parseInt(document.getElementById("seats").value);
				price = Number.parseFloat(price + 0.1).toFixed(2);
				document.getElementById("price").innerHTML = price.toString().concat("&euro;");
			}
			else {
				document.getElementById("price").innerHTML = "ERROR";
			}
		};
		calculatePrice();
	</script>
 
	
	
</security:authorize>