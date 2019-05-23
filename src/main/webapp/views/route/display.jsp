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
<!-- Nueva libreria fn para obtener la funcion length() para poder obtener el tamaï¿½o de una coleccion -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<spring:message code="route.formatDate" var="formatDate" />
<spring:url value="/styles/route.css" var="routecss" />
<link href="${routecss}" rel="stylesheet" />
<script src="${routecss}"></script>

<spring:message code="route.route" var="routeMsg" />
<spring:message code="route.details" var="detailsMsg" />
<spring:message code="route.seats" var="seatsMsg" />
<spring:message code="route.driver" var="driverMsg" />
<spring:message code="route.vehicle" var="vehicleMsg" />
<spring:message code="route.preferences" var="preferencesMsg" />
<spring:message code="route.maxLuggage" var="luggageMsg" />
<spring:message code="route.vehicle.type" var="typeMsg" />
<spring:message code="route.vehicle.model" var="modelMsg" />
<spring:message code="route.vehicle.brand" var="brandMsg" />
<spring:message code="route.vehicle.plate" var="plateMsg" />
<spring:message code="route.vehicle.description" var="descriptionMsg" />
<spring:message code="route.available.seats" var="availableMsg" />
<spring:message code="route.price.per.passenger" var="priceMsg" />

<style>
/* landscape phones, 576px and up */
@MEDIA ( max-width : 576px) {
	.card-img-top {
		width: 100%;
		height: auto;
	}
}
/* tablets, 768px and up */
@MEDIA ( max-width : 768px) {
	.card-img-top {
		width: 100%;
		height: auto;
	}
}
/* desktops, 992px and up */
@MEDIA ( max-width : 992px) {
}
/* large desktops, 1200px and up */
@MEDIA ( max-width : 1200px) {
}
}
</style>

<div class="text-center active-routes">
	<h3>${routeMsg}</h3>
</div>
<center>
	<div class="col-xs-12 col-sm-10 col-md-10 text-center">
		<div class="content">
			<!-- origin, destination and date -->
			<div
				class="resume d-flex flex-column justify-content-center align-items-center">
				<div class="d-flex justify-content-center align-items-center">
					<span class="badge badge-info" style="font-size: 22px"><jstl:out
							value="${route.origin }"></jstl:out> <i
						class="fas fa-arrow-right"></i> <jstl:out
							value="${route.destination }"></jstl:out></span>

				</div>

				<div class="route-route">

					<!-- Route -->

					<div class="card_">
						<div class="card-header_" id="headingOne">
							<h2 class="mb-0">
								<button class="btn btn-link" data-toggle="collapse"
									data-target="#collapseOne" aria-expanded="true"
									aria-controls="collapseOne">${routeMsg}</button>
							</h2>
						</div>
					</div>
					<div id="collapseOne" class="collapse show">
						<div class="col-xs-12 col-sm-10 col-md-10 text-center">
							<div class="card-body d-flex flex-column">

								<jstl:forEach var="point" items="${route.controlPoints}">
									<div
										class="item-route-accordion d-inline-flex font-weight-bold">
										<div
											class="circle m-0 mr-3 align-items-baseline background_orange"></div>
										<p>
											<jstl:out value="${point.location}" />
											&nbsp
										</p>
										<p class="font-weight-normal">
											<span class="badge badge-pill badge-primary"
												style="font-size: 15px"> <fmt:formatDate
													value="${point.arrivalTime}" pattern="${formatDate}" />
											</span>
										</p>
									</div>
								</jstl:forEach>

							</div>
						</div>
					</div>

					<div class="card_">
						<div class="card-header_" id="headingTwo">
							<h2 class="mb-0">
								<button class="btn btn-link collapsed" data-toggle="collapse"
									data-target="#collapseTwo" aria-expanded="false"
									aria-controls="collapseTwo">${detailsMsg}</button>
							</h2>
						</div>
					</div>


					<!-- Details -->

					<div id="collapseTwo" class="collapse">
						<div class="col-lg 12 col-md-12 col-sm-12 col-xs-12">
							<div class="card-body d-flex flex-column">

								<div class="card text-center">
									<div class="card-header">

										<div class="driver">
											<div class="text-center m-1">
												<div
													class="driver-name d-flex flex-row justify-content-center m-1">
													<span class="badge badge-info" style="font-size: 18px">

														<a href="driver/display.do?driverId=${route.driver.id}"
														style="color: white"
														onMouseOver="this.style.cssText='color: #cc0000'"
														onMouseOut="this.style.cssText='color: #FFFFFF'"><jstl:out
																value="${route.driver.name}" /> <jstl:out
																value="${route.driver.surname}" /></a> <jstl:if
															test="${route.driver.id != connectedUser.id}">
															<a
																href="thread/message/create.do?userId=${route.driver.id}&routeId=${route.id}"
																style="color: white"
																onMouseOver="this.style.cssText='color: #cc0000'"
																onMouseOut="this.style.cssText='color: #FFFFFF'"><i
																class="far fa-envelope"></i></a>
														</jstl:if>
													</span>

												</div>
												<span class="badge badge-pill badge-success"> <jstl:out
														value="${route.driver.mediumStars}" />
												</span>
											</div>

											<div class="text-center m-3">
												<jstl:if test="${canComment}">
													<security:authorize access="hasRole('PASSENGER')">

														<form:form action="comment/create.do?routeId=${route.id}"
															modelAttribute="commentForm" method="post">

															<form:hidden path="route" />

															<form:label path="star">
																<spring:message code="comment.star" />:
               					</form:label>
															<form:input path="star" />
															<form:errors cssClass="error" path="star" />
															<br />

															<form:label path="text">
																<spring:message code="comment.text" />:
               					</form:label>
															<form:input path="text" />
															<form:errors cssClass="error" path="text" />
															<br />


															<button type="submit" name="save" class="btn btn-primary">
																<spring:message code="comment.save" />
															</button>

														</form:form>


													</security:authorize>



												</jstl:if>
												<jstl:if test="${canReport}">
													<security:authorize access="hasRole('PASSENGER')">
														<spring:message code="thread.report" var="reportText" />
														<a
															href="thread/report/create.do?userId=${route.driver.id}&routeId=${route.id}"
															class="btn btn-danger"><jstl:out
																value="${reportText}" /></a>
													</security:authorize>
												</jstl:if>
											</div>
										</div>
									</div>

									<div class="vehicle d-flex flex-row justify-content-center m-1">
										<div style="padding-top: 15px">
											<div class="card border-info mb-3">

												<img class="card-img-top" src="${route.vehicle.image}">
												<div class="card-footer text-muted">
													<p>
														<jstl:out value="${route.vehicle.vehicleBrand}" />
														<span class="badge badge-primary"> <jstl:out
																value="${route.vehicle.model}" />
														</span>
													</p>
													<jstl:out value="${route.vehicle.plate}" />
												</div>
											</div>
										</div>


										<div
											class="preferences d-flex flex-column justify-content-center align-items-center m-1">
											<div style="padding-left: 30px">
												<div class="card border-info mb-3">
													<ul class="list-group list-group-flush">
														<li class="list-group-item">
															<div class="preferences-items">
																<spring:message code="route.preferences" var="routePref" />
																<spring:message code="route.pets" var="routePets" />
																<spring:message code="route.smoke" var="routeSmoke" />
																<spring:message code="route.children"
																	var="routeChildren" />
																<spring:message code="route.music" var="routeMusic" />

																<jstl:if test="${route.driver.pets == true}">
																	<jstl:out value="${routePets}: " />
																	<input type="checkbox" disabled="disabled"
																		checked="checked">
																</jstl:if>

																<jstl:if test="${route.driver.pets == false}">
																	<jstl:out value="${routePets}: " />
																	<input type="checkbox" disabled="disabled">
																</jstl:if>

																<jstl:if test="${route.driver.childs == true}">
																	<jstl:out value="${routeChildren}: " />
																	<input type="checkbox" disabled="disabled"
																		checked="checked">
																</jstl:if>

																<jstl:if test="${route.driver.childs == false}">
																	<jstl:out value="${routeChildren}: " />
																	<input type="checkbox" disabled="disabled">
																</jstl:if>


																<jstl:if test="${route.driver.smoke == true}">
																	<jstl:out value="${routeSmoke}: " />
																	<input type="checkbox" disabled="disabled"
																		checked="checked">
																</jstl:if>

																<jstl:if test="${route.driver.smoke == false}">
																	<jstl:out value="${routeSmoke}: " />
																	<input type="checkbox" disabled="disabled">
																</jstl:if>

																<jstl:if test="${route.driver.music == true}">
																	<jstl:out value="${routeMusic}: " />
																	<input type="checkbox" disabled="disabled"
																		checked="checked">
																</jstl:if>

																<jstl:if test="${route.driver.music == false}">
																	<jstl:out value="${routeMusic}: " />
																	<input type="checkbox" disabled="disabled">
																</jstl:if>


															</div>
														</li>

														<li class="list-group-item">
															<div
																class="luggage d-flex flex-row align-items-baseline justify-content-center m-2">
																<h5>${luggageMsg}:&nbsp</h5>
																<p>
																	<span class="badge badge-warning"><jstl:out
																			value="${route.maxLuggage}" /></span>
																</p>
															</div>
														</li>
														<li class="list-group-item">

															<div
																class="details d-flex flex-row justify-content-center m-1">
																<h5>${detailsMsg}:&nbsp</h5>
																<p>
																	<jstl:out value="${route.details}" />
																</p>
															</div>
														</li>
													</ul>
												</div>
											</div>
										</div>


									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="card_">
						<div class="card-header_" id="headingThree">
							<h2 class="mb-0">
								<button class="btn btn-link collapsed" data-toggle="collapse"
									data-target="#collapseThree" aria-expanded="false"
									aria-controls="collapseThree">${seatsMsg}</button>
							</h2>
						</div>
					</div>
					<div id="collapseThree" class="collapse">

						<div class="num-seats price text-center">
							<p>
								${availableMsg}: &nbsp <span
									class="badge badge-pill badge-primary" style="font-size: 25px">
									<jstl:out value="${remainingSeats}"></jstl:out>
								</span>
							</p>
							<p>
								${priceMsg}: &nbsp <span class="badge badge-pill badge-success"
									style="font-size: 25px"> <jstl:out
										value="${route.pricePerPassenger}"></jstl:out>&euro;
								</span>
							</p>
						</div>

						<div class="passengers-route text-center">
							<jstl:if test="${not empty reservations}">
								<spring:message code="route.luggage" var="resLuggage" />
								<jstl:forEach items="${reservations}" var="res">
									<%-- <dd>
								<jstl:out value="----------------------------" />
							</dd> --%>
									<div class="passengers-- m-1 p-3">
										<span><dd>
												<a
													href="passenger/display.do?passengerId=${res.passenger.id}">
													<jstl:out
														value="${res.passenger.name} ${res.passenger.surname}" />
												</a>
												<jstl:if test="${res.passenger.id != connectedUser.id}">
													<a
														href="thread/message/create.do?userId=${res.passenger.id}&routeId=${route.id}"><i
														class="far fa-envelope"></i></a>
												</jstl:if>
											</dd></span>
										<dd>
											<jstl:out value="${res.passenger.mediumStars}/5" />
										</dd>
										<dd>
											<jstl:out value="${resLuggage}: ${res.luggageSize}" />
										</dd>
										<dd>
											<jstl:out value="${res.origin} -> ${res.destination}" />
										</dd>
										<jstl:if test="${canComment}">

											<security:authorize access="hasRole('DRIVER')">

												<jstl:forEach items="${passengersToComment}" var="passenger">

													<form:form
														action="comment/create.do?passengerId=${passenger.id}"
														modelAttribute="commentForm" method="post">

														<form:hidden path="route" />

														<form:label path="star">
															<spring:message code="comment.star" />:
                    							</form:label>
														<form:input type="number" path="star" />
														<form:errors cssClass="error" path="star" />
														<br />

														<form:label path="text">
															<spring:message code="comment.text" />:
                    							</form:label>
														<form:input type="text" path="text" />
														<form:errors cssClass="error" path="text" />
														<br />


														<button type="submit" name="save" class="btn btn-primary">
															<spring:message code="comment.save" />
														</button>

													</form:form>

												</jstl:forEach>

											</security:authorize>
										</jstl:if>
										<jstl:if test="${canReport}">
											<security:authorize access="hasRole('DRIVER')">
												<spring:message code="thread.report" var="reportText" />
												<a
													href="thread/report/create.do?userId=${res.passenger.id}&routeId=${route.id}"
													class="btn btn-danger"><jstl:out value="${reportText}" /></a>
											</security:authorize>
										</jstl:if>

										<!-- (COMO CONDUCTOR) PARA CADA PASAJERO, BOTONES DE ACEPTAR O RECHAZAR SOLICITUD -->
										<security:authorize access="hasRole('DRIVER')">
											<jstl:if test="${rol == 1}">
												<jstl:if test="${res.status eq 'PENDING' }">
													<spring:message code="route.reservation.accept"
														var="acceptReservation" />
													<form name="acceptReservation" method="POST"
														action="reservation/driver/acceptReservation.do?reservationId=${res.id}">
														<button type="submit" name="acceptReservation"
															class="btn btn-success">
															<spring:message code="route.reservation.accept" />
														</button>
													</form>
												</jstl:if>
												<jstl:if test="${!(res.status eq 'ACCEPTED') }">
													<spring:message code="route.reservation.reject"
														var="rejectReservation" />
													<form name="rejectReservation" method="POST"
														action="reservation/driver/rejectReservation.do?reservationId=${res.id}">
														<button type="submit" name="rejectReservation"
															class="btn btn-danger">
															<spring:message code="route.reservation.reject" />
														</button>
													</form>
												</jstl:if>
											</jstl:if>
										</security:authorize>
									</div>
								</jstl:forEach>
								<%-- <dd>
							<jstl:out value="----------------------------" />
						</dd> --%>
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
											<spring:message code="reserv.cancel.confirm" var="confirm" />
											<jstl:if test="${reservation.status != 'REJECTED' }">
												<form name="cancelReservation" method="POST"
													action="reservation/passenger/cancelReservation.do?reservationId=${reservation.id}">
													<button type="submit" name="cancelReservation"
														onclick="return confirm('${confirm}')"
														class="btn btn-danger">
														<spring:message code="route.reserv.cancel" />

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

										<!-- (COMO PASAJERO)PARA RESERVA ACEPTADA POR EL CONDUCTOR, BOTONES DE "
		ï¿½ME HA RECOGIDO EL CONDUCTOR ONO?" -->

										<!-- SI LA RUTA ESTï¿½ EMPEZADA...  -->
										<jstl:if test="${startedRoute == true }">
											<spring:message code="route.driver.pick.up" var="pickup" />
											<!--...Y SI EL SISTEMA AUN NO SABE SI LO HA RECOGIDO, SE MUESTRA EL BOTON DE "ME HA RECOGIDO"...-->
											<jstl:if
												test="${reservation.driverPickedMe eq false and reservation.driverNoPickedMe eq false and arrivalPlus10Min eq false}">
												<dd>
													<a
														href="reservation/passenger/driverPickUp.do?reservationId=${reservation.id}"><jstl:out
															value="${pickup}" /></a>
												</dd>
											</jstl:if>
											<!-- ...PERO SI EL SISTEMA YA SABE QUE HA RECOGIDO AL PASAJERO, SOLO SE MUESTRA EL MENSAJE DE "ME HA RECOGIDO"-->
											<jstl:if
												test="${(reservation.driverPickedMe eq true and reservation.driverNoPickedMe eq false) or arrivalPlus10Min eq true}">
												<dd>
													<jstl:out value="${pickup}" />
												</dd>
											</jstl:if>
											<!-- UNA VEZ HAN PASADO 10 MINUTOS DESDE LA HORA DE SALIDA... -->
											<jstl:if test="${hasPassed10Minutes == true }">
												<spring:message code="route.driver.no.pick.up"
													var="nopickup" />
												<!-- ...SI  EL SISTEMA AUN NO SABE SI LO HA RECOGIDO, SE MUESTRA EL BOTON DE "NO ME HA RECOGIDO"...-->
												<jstl:if
													test="${reservation.driverPickedMe eq false and reservation.driverNoPickedMe eq false and arrivalPlus10Min eq false}">
													<dd>
														<a
															href="reservation/passenger/driverNoPickUp.do?reservationId=${reservation.id}"><jstl:out
																value="${nopickup}" /></a>
													</dd>
												</jstl:if>
												<!-- ...PERO SI EL SISTEMA YA SABE QUE NO HA RECOGIDO AL PASAJERO, SOLO SE MUESTRA EL MENSAJE DE "NO ME HA RECOGIDO"-->
												<jstl:if
													test="${reservation.driverPickedMe eq false and reservation.driverNoPickedMe eq true and arrivalPlus10Min eq false}">
													<dd>
														<jstl:out value="${nopickup}" />
													</dd>
												</jstl:if>

											</jstl:if>

										</jstl:if>
										<!-- SI EL VIAJE NO HA EMPEZADO, EL PASAJERO PUEDE CANCELAR LA RESERVA -->
										<jstl:if test="${startedRoute == false }">
											<dd>
												<form name="cancelReservation" method="POST"
													action="reservation/passenger/cancelReservation.do?reservationId=${reservation.id}">
													<button type="submit" name="cancelReservation"
														class="btn btn-danger">
														<spring:message code="route.reserv.cancel" />
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
									<spring:message code="route.request.seats" var="createReserv" />
									<a class="request--"
										href="reservation/passenger/create.do?routeId=${route.id }"><jstl:out
											value="${createReserv}" /></a>
								</jstl:if>

							</security:authorize>
						</div>

					</div>
				</div>

				<div class="cancel-route-driver text-center m-1 p-3">
					<security:authorize access="hasRole('DRIVER')">
						<!-- <button class="btn" type="button">CANCEL ROUTE</button> -->
						<%-- <security:authorize access="hasRole('DRIVER')"> --%>

						<spring:message code="route.cancel.route" var="cancelRoute" />
						<jstl:if test="${rol==1 }">
							<div class="font-weight-bold">
								<dd>
									<a class="text-danger"
										href="route/driver/cancel.do?routeId=${route.id}"><jstl:out
											value="${cancelRoute}" /></a>
								</dd>
							</div>
						</jstl:if>

					</security:authorize>
				</div>

			</div>
			<div>
				<%-- <jstl:if test="${canComment}">
        
        <security:authorize access="hasRole('DRIVER')">
        
            <jstl:forEach items="${passengersToComment}" var="passenger">
            
                <jstl:out value="${passenger.name}"/>
            
                <form:form action="comment/create.do?passengerId=${passenger.id}" modelAttribute="commentForm" method="post">
                                
                    <form:hidden path="route"/>
                
                    <form:label path="star">
                        <spring:message code="comment.star"/>:
                    </form:label>
                    <form:input type="number" path="star"/>
                    <form:errors cssClass="error" path="star"/><br />
            
                    <form:label path="text">
                        <spring:message code="comment.text"/>:
                    </form:label>
                    <form:input type="text" path="text"/>
                    <form:errors cssClass="error" path="text"/><br />
                    
                    
                    <button type="submit" name="save" class="btn btn-primary">
                        <spring:message code="comment.save" />
                    </button>                        
                
                </form:form>
            
            </jstl:forEach>
        
        </security:authorize>
        
        <security:authorize access="hasRole('PASSENGER')">
           
           <jstl:out value="${route.driver.name}"/>
           
           <form:form action="comment/create.do?routeId=${route.id}" modelAttribute="commentForm" method="post">

               <form:hidden path="route"/>

               <form:label path="star">
                   <spring:message code="comment.star"/>:
               </form:label>
               <form:input path="star"/>
               <form:errors cssClass="error" path="star"/><br />

               <form:label path="text">
                   <spring:message code="comment.text"/>:
               </form:label>
               <form:input path="text"/>
               <form:errors cssClass="error" path="text"/><br />


               <button type="submit" name="save" class="btn btn-primary">
                   <spring:message code="comment.save" />
               </button>

           </form:form>


       </security:authorize>
        
        
    
    </jstl:if> --%>

				<jstl:if test="${commentResultOk != null}">

					<div class="alert alert-success" role="alert">
						<spring:message code="${commentResultOk}" />
					</div>

				</jstl:if>

				<jstl:if test="${commentResultError != null}">

					<div class="alert alert-danger" role="alert">
						<spring:message code="${commentResultError}" />
					</div>

				</jstl:if>

			</div>

			<!-- ************************************************************************************************************************* -->







		</div>
	</div>
</center>