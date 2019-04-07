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

<spring:message code="route.formatDate" var="formatDate" />
<spring:url value="/styles/route.css" var="routecss" />
	<link href="${routecss}" rel="stylesheet" />
	<script src="${routecss}"></script>
	
<div class="text-center active-routes">
	<h3>Route</h3>
</div>
<div class="content">
	<!-- origin, destination and date -->
	<div class="resume d-flex flex-column justify-content-center align-items-center">
		<div class="d-flex justify-content-center align-items-center">
			<div class="origin">
				<jstl:out value="${route.origin }"></jstl:out>
			</div>
			<div class="to d-flex"></div>
			<div class="destination">
				<jstl:out value="${route.destination }"></jstl:out>
			</div>
		</div>
		<div class="date-route">
			<fmt:formatDate value="${route.departureDate}" pattern="${formatDate}"/>
		</div>
	</div>
	
	<div class="route-route">
	
		<!-- Route -->

		<div class="card_">
			<div class="card-header_" id="headingOne">
				<h2 class="mb-0">
					<button class="btn btn-link" data-toggle="collapse"
						data-target="#collapseOne" aria-expanded="true"
						aria-controls="collapseOne">Route</button>
				</h2>
			</div>
		</div>
		<div id="collapseOne" class="collapse show"
			aria-labelledby="headingOne" data-parent="#accordion">
			<div class="card-body d-flex flex-column">
				<div class="item-route-accordion item-1 d-inline-flex font-weight-bold">
					<div class="circle m-0 mr-3 align-items-baseline background_orange"></div>
					<p><jstl:out value="${route.origin}"/></p>
				</div>
				<div class="item-route-accordion item-2 d-inline-flex font-weight-bold">
					<div class="circle m-0 mr-3 align-items-baseline background_orange"></div>
					<p><jstl:out value="${route.destination}"/></p>
				</div>
			</div>
		</div>
		
		<div class="card_">
			<div class="card-header_" id="headingTwo">
				<h2 class="mb-0">
					<button class="btn btn-link collapsed" data-toggle="collapse"
						data-target="#collapseTwo" aria-expanded="false"
						aria-controls="collapseTwo">Details</button>
				</h2>
			</div>
		</div>
		
		
		<!-- Details -->

		<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
			data-parent="#accordion">
			<div class="card-body d-flex flex-column">

				<div class="driver">
					<div class="driver-name d-flex flex-row justify-content-center m-1">
						<h5>Driver: &nbsp</h5>
						<p>
							<jstl:out value="${route.driver.name}" />
							<jstl:out value="${route.driver.surname}" />
						</p>
					</div>

					<div class="vehicle d-flex flex-row justify-content-center m-1">
						<div class="vehile-foto">
							<h5>Vehicle: &nbsp </h5>
							<img src="${route.vehicle.image}" width="200" height="150" /> 
						</div>
						<div class="vehicle-description">
							<p>
								Type: &nbsp
								<jstl:out value="${route.vehicle.type}" />
							</p>
							<p>
								Model: &nbsp
								<jstl:out value="${route.vehicle.model}" />
							</p>
							<p>
								Brand: &nbsp
								<jstl:out value="${route.vehicle.vehicleBrand}" />
							</p>
							<p>
								Plate: &nbsp
								<jstl:out value="${route.vehicle.plate}" />
							</p>
							<p>
								Description: &nbsp
								<jstl:out value="${route.vehicle.description}" />
							</p>
						</div>
					</div>

					<div class="preferences d-flex flex-column justify-content-center align-items-center m-1">
						<h5>Preferences: &nbsp </h5>
						<div class="preferences-items">
							<spring:message code="route.preferences" var="routePref" />
							<spring:message code="route.pets" var="routePets" />
							<spring:message code="route.smoke" var="routeSmoke" />
							<spring:message code="route.children" var="routeChildren" />
							<spring:message code="route.music" var="routeMusic" />
	
							<jstl:if test="${route.driver.pets == true}">
								<jstl:out value="${routePets}: " />
								<input type="checkbox" disabled="disabled" checked="checked">
							</jstl:if>
	
							<jstl:if test="${route.driver.pets == false}">
								<jstl:out value="${routePets}: " />
								<input type="checkbox" disabled="disabled">
							</jstl:if>
	
							<jstl:if test="${route.driver.childs == true}">
								<jstl:out value="${routeChildren}: " />
								<input type="checkbox" disabled="disabled" checked="checked">
							</jstl:if>
	
							<jstl:if test="${route.driver.childs == false}">
								<jstl:out value="${routeChildren}: " />
								<input type="checkbox" disabled="disabled">
							</jstl:if>
	
	
							<jstl:if test="${route.driver.smoke == true}">
								<jstl:out value="${routeSmoke}: " />
								<input type="checkbox" disabled="disabled" checked="checked">
							</jstl:if>
	
							<jstl:if test="${route.driver.smoke == false}">
								<jstl:out value="${routeSmoke}: " />
								<input type="checkbox" disabled="disabled">
							</jstl:if>
	
							<jstl:if test="${route.driver.music == true}">
								<jstl:out value="${routeMusic}: " />
								<input type="checkbox" disabled="disabled" checked="checked">
							</jstl:if>
	
							<jstl:if test="${route.driver.music == false}">
								<jstl:out value="${routeMusic}: " />
								<input type="checkbox" disabled="disabled">
							</jstl:if>
							</br>
						</div>

					</div>

					<div class="luggage d-flex flex-row align-items-baseline justify-content-center m-2">
						<h5>Luggage size: &nbsp </h5>
						<p>
							<jstl:out value="${route.maxLuggage}" />
						</p>
					</div>

					<div class="details d-flex flex-row justify-content-center m-1">
						<h5>Details: &nbsp </h5>
						<p>
							<jstl:out value="${route.details}" />
						</p>
					</div>

				</div>

			</div>
		</div>
		
		<div class="card_">
			<div class="card-header_" id="headingThree">
				<h2 class="mb-0">
					<button class="btn btn-link collapsed" data-toggle="collapse"
						data-target="#collapseThree" aria-expanded="false"
						aria-controls="collapseThree">Seats</button>
				</h2>
			</div>
		</div>
		
		<div id="collapseThree" class="collapse" aria-labelledby="headingThree"
			data-parent="#accordion">
			<div class="card-body d-flex flex-column">
			
				<div class="num-seats price">
					<p>Avaiblable seats: &nbsp <jstl:out value="${remainingSeats}"></jstl:out></p>
					<p>Price per passenger: &nbsp <jstl:out value="${route.pricePerPassenger}"></jstl:out></p>
				</div>
		
				<%-- <div class="passengers">
					<h5>Passengers: &nbsp</h5>
					
					<!-- displayableReservations -->
					<jstl:forEach var="reservation" items="${reservations }">
						<div class="passenger">
							
						</div>
					</jstl:forEach>
				
				</div> --%>
			</div>
		</div>
	</div>
	
	<!-- ************************************************************************************************************************* -->
	
	<div class="d-none">
   <security:authorize access="hasRole('DRIVER')">
   <button class="btn" type="button">CANCEL ROUTE</button>
   <%-- <security:authorize access="hasRole('DRIVER')"> --%>
	
	<spring:message code="route.cancel.route" var="cancelRoute"/>
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
					<jstl:if test="${reservation.status != 'REJECTED' }">
					<form name="cancelReservation" method="POST" action="reservation/passenger/cancelReservation.do?reservationId=${reservation.id}">
						<button type="submit" name="cancelReservation" class="btn btn-primary">
							<spring:message code="route.reserv.cancel"/> 
						</button>
					</form>
					
					</jstl:if>
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
	

	
	</div>
</div>

		<!-- ************************************************************************************************************************* -->
	
	<%-- 
 							<div class="cancelled">
									<security:authorize access="hasRole('PASSENGER')">
									<jstl:if test="${route.isCancelled == false && reservation.status != 'PENDING' || 'ACCEPTED'}">

										<jstl:if test="${remainingSeats > 0 }">
										<a href="reservation/passenger/create.do?routeId=${route.id }"class="btn" type="button">REQUEST SEATS</a>
										
										<!-- <button class="btn" type="button">REQUEST</button> -->
										
										</jstl:if>

									</jstl:if>
									</security:authorize>
									

								</div>
								</div>
							</div>
                            </div>
                        </div>
                    </div>
                
            </div>
        </div>
        </body>
        
   <security:authorize access="hasRole('DRIVER')">
   <button class="btn" type="button">CANCEL ROUTE</button>
   <security:authorize access="hasRole('DRIVER')">
	<spring:message code="route.confirm.cancel" var="confirm" />
	<spring:message code="route.cancel.route" var="cancelRoute"/>
		<jstl:if test="${rol==1 }">
			<dd><a href="route/driver/cancel.do?routeId=${route.id}"
			onclick="return confirm('${confirm}')" />&nbsp;<jstl:out value="${cancelRoute}"/></a></dd>
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
					<jstl:if test="${reservation.status != 'REJECTED' }">
					<form name="cancelReservation" method="POST" action="reservation/passenger/cancelReservation.do?reservationId=${reservation.id}">
						<button type="submit" name="cancelReservation" class="btn btn-primary">
							<spring:message code="route.reserv.cancel"/> 
						</button>
					</form>
					
					</jstl:if>
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
	

</dl> --%>

