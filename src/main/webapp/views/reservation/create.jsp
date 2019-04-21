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

<security:authorize access="hasRole('PASSENGER')">
<form:form action="reservation/passenger/create.do"	modelAttribute="reservation">
			<form:hidden path="id" />
			<form:hidden path="version" />
			<form:hidden path="passenger"/>
			<form:hidden path="route"/>
			<form:hidden path="driverPickedMe"/>
			<form:hidden path="driverNoPickedMe"/>
			<form:hidden path="status"/>


			<form:label path="seat">
				<spring:message code="route.request.seats" />: </form:label>
			<form:select path="seat" onclick="multiplicar()" id="seatId">
				<jstl:forEach var="x" begin="1" end="${remainingSeats}">
					<form:option label="${x}" value="${x}">
					</form:option>
				</jstl:forEach>
			</form:select>
			<form:errors cssClass="error" path="seat" />
			<br />



			<form:label path="origin">
				<spring:message code="route.origin" />: </form:label>
			<form:select path="origin">
				<form:option value="${route.origin }" />
			</form:select>
			<form:errors cssClass="error" path="origin" />
			<br />

			<form:label path="destination">
				<spring:message code="route.destination" />: </form:label>
			<form:select path="destination">
				<form:option value="${route.destination}" />
			</form:select>
			<form:errors cssClass="error" path="destination" />
			<br />

			<form:label path="luggageSize">
				<spring:message code="route.luggage" />: </form:label>
			<form:select path="luggageSize">
				<form:option value="NOTHING" label="NOTHING"/>
				<jstl:if test="${!LugNothing }">
				<form:option value="SMALL" label="SMALL"/>
				</jstl:if>
				<jstl:if test="${(LugMedium eq true) or (LugBig eq true)}">
				<form:option value="MEDIUM" label="MEDIUM"/>
				</jstl:if>
				<jstl:if test="${LugBig eq true }">
				<form:option value="BIG" label="BIG"/>
				</jstl:if>
			</form:select>
			<form:errors cssClass="error" path="luggageSize" />
			<br />

			<form:label path="price">
				<spring:message code="route.total" />: 
			</form:label>
			<form:input path="price" readonly="readonly" id="precioTotal"/>
			<br />



			<input type="submit" name="save"
				value="<spring:message code="route.save" />" />
			<input type="button" name="cancel"
				value="<spring:message code="route.cancel" />"
				onclick="javascript: relativeRedir('route/display.do?routeId=${route.id}');" />
			<br />

		</form:form>

		<script type="text/javascript">
			function multiplicar() {

				var result = document.getElementById("seatId").value * ${route.pricePerPassenger};
				document.getElementById("precioTotal").innerHTML = result.toFixed(2);
			};
		</script>

</security:authorize>