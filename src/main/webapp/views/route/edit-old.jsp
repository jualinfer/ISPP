<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
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
	<h3>Create route</h3>
</div>


<spring:message code="route.cancel"  var="cancel"/>
<security:authorize access="hasRole('DRIVER')">
<center>
		<form:form action="${requestURI}" modelAttribute="route">
			<form:hidden path="id" />
			<form:hidden path="pricePerPassenger" />
			<form:hidden path="distance" />
			
			<form:hidden path="controlPoints" />
			<form:hidden path="reservations" />
			<form:hidden path="daysRepeat" />
			<form:hidden path="driver" />
			<form:hidden path="estimatedDuration" />
			<form:hidden path="isCancelled" />


			<div class="col-sm-6 text-center" style="padding-top: 20px;">
				<div class="form-group">
					<label for="inputPassword4"> Departure date:</label>
					<div class="input-group date" id="datetimepicker"
						data-target-input="nearest">
						<form:input type="text" path="departureDate"
							class="form-control datetimepicker-input"
							data-target="#datetimepicker1" required="true" />
						<div class="input-group-append" data-target="#datetimepicker"
							data-toggle="datetimepicker">
							<div class="input-group-text">
								<i class="fa fa-calendar"></i>
							</div>
						</div>
					</div>
				</div>
			</div>
			<script type="text/javascript">
				$(function() {
					$('#datetimepicker').datetimepicker({
						format : 'DD/MM/YYYY HH:mm',
						minDate : new Date()
					});
				});
			</script>



			<div class="form-group col-md-6">
							Origin:
			<form:input type="text" path="origin.location" />
			<form:errors path="origin.location" cssClass="error" />
			<form:hidden path="origin.estimatedTime" />
			<form:hidden path="origin.arrivalOrder" />
			<form:hidden path="origin.distance" />
			<br />
			</div>
			
			<div class="form-group col-md-6">
							<jstl:forEach items="${route.controlpoints}" var="cp" varStatus="status">
				Stop:
				<form:input type="text" path="controlpoints[${status.index}].location" />
				<form:errors path="controlpoints[${status.index}].location" cssClass="error" />
				<form:input type="number" path="controlpoints[${status.index}].estimatedTime" />
				<form:errors path="controlpoints[${status.index}].estimatedTime" cssClass="error" />
				<form:hidden path="controlpoints[${status.index}].arrivalOrder" />
				<form:hidden path="controlpoints[${status.index}].distance" />
				<button type="submit" name="remove_cp" formaction="controlpoint/driver/remove.do?index=${status.index}">
					Remove
				</button>
				<br />
			</jstl:forEach>
			</div>

			<div class="form-group col-md-6">
				Destination:
			<form:input type="text" path="destination.location" />
			<form:errors path="destination.location" cssClass="error" />
			<form:input type="number" path="destination.estimatedTime" />
			<form:errors path="destination.estimatedTime" cssClass="error" />
			<form:hidden path="destination.arrivalOrder" />
			<form:hidden path="destination.distance" />
			<br />
			<button type="submit" name="add_cp" formaction="controlpoint/driver/add.do">
				Add stop
			</button>
			<br />
			</div>

			<div class="form-group col-md-6">
				Available seats:
			<form:input type="number" path="availableSeats" />
			<form:errors path="availableSeats" cssClass="error" />
			<br />
			</div>

			<div class="form-group col-md-6">
				Max luggage size:
			<form:select path="maxLuggage" class="form-control">
				<form:option label="None" value="NOTHING" />
				<form:option label="Small" value="SMALL" />
				<form:option label="Medium" value="MEDIUM" />
				<form:option label="Big" value="BIG" />
			</form:select>
			<form:errors path="maxLuggage" cssClass="error" />
			<br />

				
			</div>
			<div class="form-group col-md-6">
				<form:label path="vehicle">
					<spring:message code="route.vehicle" />:
	</form:label>
				<form:select path="vehicle" class="form-control">
					<form:option label="-------" value="0">
					</form:option>
					<form:options items="${vehicles}" itemLabel="model" itemValue="id"
						required="true" />
				</form:select>
				<form:errors cssClass="error" path="vehicle" />
				<br />
			</div>

			<div class="form-group col-md-6">
				<form:label path="details">
					<spring:message code="route.details" />
				</form:label>
				<form:textarea path="details" class="form-control" />
				<form:errors cssClass="error" path="details" />
				<br />
			</div>

			<!-- <div class="form-group col-md-6 text-center">
				<h4>
					Distance: <span class="badge badge-primary">10Km</span>
				</h4>

				<h4>
					Price per passenger: <span class="badge badge-success">1,10&euro;</span>
				</h4>

			</div> -->

			<div class="form-group col-md-6 text-center">
				<input type="submit" name="save" class="btn btn-success"
					value="<spring:message code="route.save" />"
					 <jstl:if test="${route.id!=0}">
					onclick="javascript: relativeRedir('route/driver/confirmRoute.do');"
					</jstl:if>
					/>
				<%-- <jstl:if test="${route.id!=0}">
					<input type="submit" name="Abort Route"
						value="<spring:message code="route.abort" />" />
				</jstl:if> --%>
				
					
					
					
					<jstl:if test="${route.id!=0}">
					<spring:url var="cancelUrl" value="route/driver/cancel.do">
						<spring:param name="routeId" value="${route.id}" />
					</spring:url>
					<a href="${cancelUrl}" class="btn btn-danger" ><jstl:out
						value="${cancel}" />
						</a>
						
						</jstl:if>
						
					<jstl:if test="${route.id==0}">
					<input type="button" name="cancel" class="btn btn-warning"
					value="<spring:message code="route.cancel" />"
					onclick="javascript: relativeRedir('route/driver/listActive.do');" /> 
					</jstl:if><br />
			</div>

		</form:form>
	</center>
</security:authorize>