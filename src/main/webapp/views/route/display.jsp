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
<!-- Nueva libreria fn para obtener la funcion length() para poder obtener el tama�o de una coleccion -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


	<spring:url value="/styles/route.css" var="routecss" />
	<link href="${routecss}" rel="stylesheet" />
	<script src="${routecss}"></script>
<head>
        <title>Accordion</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
    </head>
    <body>

	<jstl:out value="${route.origin}"/><br />
	<jstl:out value="${route.destination}"/><br />
	<jstl:out value="${route.departureDate}"/><br />
	
        <div class="container ">
            <div class="col-md-12">
                
                    <div class="col-md-6 d-flex flex-column justify-content-xl-center">
                        <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingOne">
                                    <h4 class="panel-title">
                                        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                            Route
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                                    <div class="panel-body d-flex flex-row justify-content-xl-center">
                                   			<p><jstl:out value="${route.origin}"/></p>
											<p><jstl:out value="${route.destination}"/></p>
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingTwo">
                                    <h4 class="panel-title">
                                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                            Details
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                    <div class="panel-body">
                                        <jstl:out value="${route.driver.name}   "/><jstl:out value="${route.driver.surname}"/><br />
                                        
                                        <div class="preferences" style="width: 8rem;">
  													Preferences:
							
           
         <spring:message code="route.preferences" var="routePref" /> 
         	<spring:message code="route.pets" var="routePets" /> 
         	<spring:message code="route.smoke" var="routeSmoke" /> 	
         	<spring:message code="route.children" var="routeChildren" /> 
         	<spring:message code="route.music" var="routeMusic" />
                                      	
		<jstl:if test="${route.driver.pets == true}">
			<jstl:out value="${routePets}: " />
			<input type="checkbox" disabled="disabled" checked="checked">
		</jstl:if><br/>	

		<jstl:if test="${route.driver.pets == false}">
			<jstl:out value="${routePets}: " />
			<input type="checkbox" disabled="disabled">
		</jstl:if><br/>	

		<jstl:if test="${route.driver.childs == true}">
			<jstl:out value="${routeChildren}: " />
			<input type="checkbox" disabled="disabled" checked="checked">
		</jstl:if><br/>	

		<jstl:if test="${route.driver.childs == false}">
			<jstl:out value="${routeChildren}: " />
			<input type="checkbox" disabled="disabled">
		</jstl:if> <br/>	
		

		<jstl:if test="${route.driver.smoke == true}">
			<jstl:out value="${routeSmoke}: " />
			<input type="checkbox" disabled="disabled" checked="checked">
		</jstl:if> <br/>	

		<jstl:if test="${route.driver.smoke == false}">
			<jstl:out value="${routeSmoke}: " />
			<input type="checkbox" disabled="disabled">
		</jstl:if> <br/>	

		<jstl:if test="${route.driver.music == true}">
			<jstl:out value="${routeMusic}: " />
			<input type="checkbox" disabled="disabled" checked="checked">
		</jstl:if> <br/>	

		<jstl:if test="${route.driver.music == false}">
			<jstl:out value="${routeMusic}: " />
			<input type="checkbox" disabled="disabled">
		</jstl:if> <br/>	
		
	
                                        	
                                        	<div class="luggage" style="width: 8rem;">
                                        Luggage size:
                                        <jstl:out value="${route.maxLuggage}"/><br />
                                        </div>
                                         <div class="Vehicle" style="width: 8rem;">
                                        Vehicle:
                                        <img src="${route.vehicle.image}" width="200" height="150"/>
                                        <jstl:out value="${route.vehicle.type}"/><br />Model:
                                        <jstl:out value="${route.vehicle.model}"/><br />Brand:
                                        <jstl:out value="${route.vehicle.vehicleBrand}"/><br /> Plate:
                                        <jstl:out value="${route.vehicle.plate}"/><br /> Description:
                                        <jstl:out value="${route.vehicle.description}"/><br />
                                        </div>
                                        	
                                        </div>
                                        
                                </div>
                            </div>
                            
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingThree">
                                    <h4 class="panel-title">
                                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                            Seats
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
								<div class="panel-body">
									<%-- <jstl:out value="${route.availableSeats}"></jstl:out><br/> --%>
									<p>
										Origin: &nbsp
										<jstl:out value="${route.origin }"></jstl:out>
									</p>

									<p>
										Destination: &nbsp
										<jstl:out value="${route.destination }"></jstl:out>
									</p>

									<p>Seats: &nbsp <jstl:out value="${remainingSeats}"></jstl:out><br/></p>


									<p>
										Total: &nbsp
										<jstl:out value="${route.pricePerPassenger }"></jstl:out>
										euros
									</p>
								</div>


			<!-- vvv ESTE BOTON DE REQUEST SOBRA YA QUE YA HAY OTRO MAS ADELANTE vvv -->
<!-- 								<div class="cancelled"> -->

<%-- 									<jstl:if test="${route.isCancelled == false }"> --%>

<%-- 										<jstl:if test="${route.availableSeats > 0 }"> --%>

<!-- 											<button class="btn" type="button">REQUEST</button> -->

<%-- 										</jstl:if> --%>

<%-- 									</jstl:if> --%>

<!-- 								</div> -->
								</div>
							</div>
                            </div>
                        </div>
                    </div>
                
            </div>
        </div>
        </body>
        
  <%--  <security:authorize access="hasRole('DRIVER')">
   <button class="btn" type="button">CANCEL ROUTE</button> --%>
   <security:authorize access="hasRole('DRIVER')">
	
	<spring:message code="route.cancel" var="cancelRoute"/>
		<jstl:if test="${rol==1 }">
			<dd><a href="route/driver/cancel.do?routeId=${route.id}"><jstl:out value="${cancelRoute}"/></a></dd>
		</jstl:if>
	
	</security:authorize>


	
	

	
	

	<jstl:if test="${not empty reservations}">
		<spring:message code="route.luggage" var="resLuggage" />
		<jstl:forEach items="${reservations}" var="res">
			<dd>
				<jstl:out value="----------------------------" />
			</dd>
			<dd>
				<jstl:out value="${res.passenger.name} ${res.passenger.surname}" />
			</dd>
			<dd>
				<jstl:out value="${res.passenger.mediumStars}/5" />
			</dd>
			<dd>
				<jstl:out value="${resLuggage}: ${res.luggageSize}" />
			</dd>
			<dd>
				<jstl:out value="${res.origin} -> ${res.destination}" />
			</dd>
			
					<!-- (COMO CONDUCTOR) PARA CADA PASAJERO, BOTONES DE ACEPTAR O RECHAZAR SOLICITUD -->
			<security:authorize access="hasRole('DRIVER')">
				<jstl:if test="${rol == 1}">
					<jstl:if test="${res.status eq 'PENDING' }">
						<spring:message code="route.reservation.accept"
							var="acceptReservation" />
						<form name="acceptReservation" method="POST" action="reservation/driver/acceptReservation.do?reservationId=${res.id}">
							<button type="submit" name="acceptReservation" class="btn btn-primary">
								<spring:message code="route.reservation.accept"/> 
							</button>
						</form>
					</jstl:if>
					<jstl:if test="${!(res.status eq 'ACCEPTED') }">
					<spring:message code="route.reservation.reject"
						var="rejectReservation" />
						<form name="rejectReservation" method="POST" action="reservation/driver/rejectReservation.do?reservationId=${res.id}">
							<button type="submit" name="rejectReservation" class="btn btn-primary">
								<spring:message code="route.reservation.reject"/> 
							</button>
						</form>
					</jstl:if>
				</jstl:if>
			</security:authorize>

		</jstl:forEach>
		<dd>
			<jstl:out value="----------------------------" />
		</dd>
	</jstl:if>
	
	

	<!-- (COMO PASAJERO) MENSAJE DE ESTADO DE LA RESERVA -->

	<security:authorize access="hasRole('PASSENGER')">
		<jstl:if test="${rol == 2}">

			<jstl:if test="${reservation.status eq 'PENDING' }">
				<spring:message code="route.reserv.pending" var="rrp" />
				<spring:message code="route.reserv.cancel" var="reservCancel" />
				<dd>
					<jstl:out value="${rrp}" />
				</dd>
				<dd>
				
					<form name="cancelReservation" method="POST" action="reservation/passenger/cancelReservation.do?reservationId=${reservation.id}">
						<button type="submit" name="cancelReservation" class="btn btn-primary">
							<spring:message code="route.reserv.cancel"/> 
						</button>
					</form>
					
				</dd>
				<a></a>
			</jstl:if>

			<jstl:if test="${reservation.status eq 'ACCEPTED' }">
				<spring:message code="route.reserv.accepted" var="rra" />
				<spring:message code="route.reserv.cancel" var="reservCancel" />
				<dd>
					<jstl:out value="${rra}" />
				</dd>

				<!-- (COMO PASAJERO)PARA RESERVA ACEPTADA POR EL CONDUCTOR, BOTONES DE "�ME HA RECOGIDO EL CONDUCTOR O NO?" -->
				
					<!-- SI LA RUTA EST� EMPEZADA...  -->
				<jstl:if test="${startedRoute == true }">
					<spring:message code="route.driver.pick.up" var="pickup" />
						<!--...Y SI EL SISTEMA AUN NO SABE SI LO HA RECOGIDO, SE MUESTRA EL BOTON DE "ME HA RECOGIDO"...-->
					<jstl:if test="${reservation.driverPickedMe eq false and reservation.driverNoPickedMe eq false and arrivalPlus10Min eq false}">
					<dd>
						<a href="reservation/passenger/driverPickUp.do?reservationId=${reservation.id}"><jstl:out value="${pickup}" /></a>
					</dd>
					</jstl:if>
						<!-- ...PERO SI EL SISTEMA YA SABE QUE HA RECOGIDO AL PASAJERO, SOLO SE MUESTRA EL MENSAJE DE "ME HA RECOGIDO"-->
					<jstl:if test="${(reservation.driverPickedMe eq true and reservation.driverNoPickedMe eq false) or arrivalPlus10Min eq true}">
					<dd>
						<jstl:out value="${pickup}" />
					</dd>
					</jstl:if>
					<!-- UNA VEZ HAN PASADO 10 MINUTOS DESDE LA HORA DE SALIDA... -->
					<jstl:if test="${hasPassed10Minutes == true }">
						<spring:message code="route.driver.no.pick.up" var="nopickup" />
							<!-- ...SI  EL SISTEMA AUN NO SABE SI LO HA RECOGIDO, SE MUESTRA EL BOTON DE "NO ME HA RECOGIDO"...-->
						<jstl:if test="${reservation.driverPickedMe eq false and reservation.driverNoPickedMe eq false and arrivalPlus10Min eq false}">
							<dd>
								<a href="reservation/passenger/driverNoPickUp.do?reservationId=${reservation.id}"><jstl:out value="${nopickup}" /></a>
							</dd>
						</jstl:if>
						<!-- ...PERO SI EL SISTEMA YA SABE QUE NO HA RECOGIDO AL PASAJERO, SOLO SE MUESTRA EL MENSAJE DE "NO ME HA RECOGIDO"-->
						<jstl:if test="${reservation.driverPickedMe eq false and reservation.driverNoPickedMe eq true and arrivalPlus10Min eq false}">
							<dd>
								<jstl:out value="${nopickup}" />
							</dd>
						</jstl:if>
						
					</jstl:if>

				</jstl:if>
			<!-- SI EL VIAJE NO HA EMPEZADO, EL PASAJERO PUEDE CANCELAR LA RESERVA -->
				<jstl:if test="${startedRoute == false }">
					<dd>
						<form name="cancelReservation" method="POST" action="reservation/passenger/cancelReservation.do?reservationId=${reservation.id}">
						<button type="submit" name="cancelReservation" class="btn btn-primary">
							<spring:message code="route.reserv.cancel"/> 
						</button>
					</form>
					</dd>
				</jstl:if>

			</jstl:if>
		<!-- SI LA RESERVA HA SIDO DENEGADA, SE MUESTRA MENSAJE DE "SOLICITUD DENEGADA" -->
			<jstl:if test="${reservation.status eq 'REJECTED' }">
				<spring:message code="route.reserv.rejected" var="rrr" />
				<dd>
					<jstl:out value="${rrr}" />
				</dd>
			</jstl:if>
		<!-- SI LA RESERVA HA SIDO CANCELADA, SE MUESTRA MENSAJE DE "SOLICITUD CANCELADA" -->
			<jstl:if test="${reservation.status eq 'CANCELLED' }">
				<spring:message code="route.reserv.cancelled" var="rrc" />
				<dd>
					<jstl:out value="${rrc}" />
				</dd>

			</jstl:if>

		</jstl:if>
	</security:authorize>

	<security:authorize access="hasRole('PASSENGER')">

	<jstl:if test="${rol==3}">
		<spring:message code="route.request.seats" var="createReserv"/>
		<a href="reservation/passenger/create.do?routeId=${route.id }"><jstl:out value="${createReserv}"/></a>
	</jstl:if>
	
	</security:authorize>
	

</dl>

