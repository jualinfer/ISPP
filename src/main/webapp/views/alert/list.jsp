<%--
 * list.jsp
 *
 * Copyright (C) 2019 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>

<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>

<%-- Stored message variables --%>


<spring:message code="alert.relatedRoute.orig" var="routeOrig" />
<spring:message code="alert.relatedRoute.dest" var="routeDest" />
<spring:message code="alert.alertType" var="alertType" />
<spring:message code="alert.delete" var="delete" />
<spring:message code="alert.seen" var="seen" />
<spring:message code="alert.confirm.delete" var="confirm" />


<%-- Listing grid --%>

<display:table pagesize="5" class="displaytag" keepStatus="false"
	name="alerts" requestURI="${requestURI}" id="row">

	<%-- Attributes --%>
	
	<display:column property="relatedRoute.origin" title="${routeOrig}" sortable="true" />
	<display:column property="relatedRoute.destination" title="${routeDest}" sortable="true" />

	<display:column property="typeAlert" title="${alertType}" sortable="true" />
	

	<%-- Links towards display, apply, edit and cancel views --%>
	
		<spring:url var="seenUrl"
		value="alert/alertSeen.do">
		<spring:param name="varId" value="${row.id}" />
	</spring:url>
	
	<display:column title="${seen}">
		<a href="${seenUrl}"><jstl:out value="${seen}" /></a>
	</display:column>


		
		<spring:url var="deleteUrl" value="alert/delete.do">
			<spring:param name="varId" value="${row.id}" />
		</spring:url>

		<display:column title="${delete}">
			<a href="${deleteUrl}" onclick="return confirm('${confirm}')" ><jstl:out value="${delete}" /></a>
		</display:column>
	
</display:table>


		