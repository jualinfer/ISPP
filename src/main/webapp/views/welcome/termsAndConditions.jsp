 <%--
 * termsAndConditions.jsp
 *
 * Copyright (C) 2017 Universidad de Sevilla
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
<spring:url value="/styles/route.css" var="routecss" />
<link href="${routecss}" rel="stylesheet" />
<script src="${routecss}"></script>

<div class="text-center active-routes">
	<h3><spring:message code="terms.and.conditions.title"/></h3>
</div>
<div style="padding:25px">
<div class="card">
<div class="card-body">
<h4 class="text"><spring:message code="terms.and.conditions.1"/> <br/></h4>
<p><spring:message code="terms.and.conditions.11"/></p>
<p><spring:message code="terms.and.conditions.12"/></p>
<p><spring:message code="terms.and.conditions.13"/></p>
<p><spring:message code="terms.and.conditions.14"/></p>
<p><spring:message code="terms.and.conditions.15"/></p>
<p><spring:message code="terms.and.conditions.16"/></p>
<p><spring:message code="terms.and.conditions.17"/></p>
<p><spring:message code="terms.and.conditions.18"/></p>
<br>
<h4 class="text"><spring:message code="terms.and.conditions.2"/> <br/></h4>
<p><spring:message code="terms.and.conditions.21"/></p>
 
<h4 class="text"><spring:message code="terms.and.conditions.3"/> <br/></h4>
<p><spring:message code="terms.and.conditions.31"/></p>
<p><spring:message code="terms.and.conditions.32"/></p>
<p><spring:message code="terms.and.conditions.33"/></p>

<h4 class="text"><spring:message code="terms.and.conditions.4"/> <br/></h4>
<p><spring:message code="terms.and.conditions.41"/></p>
<p><spring:message code="terms.and.conditions.42"/></p>
<p><spring:message code="terms.and.conditions.43"/></p>
</div>
</div>
</div>

<security:authorize access="!isAuthenticated()">
			<spring:message code="terms.back" var="cancel" />
			<center>
			<a href="security/login.do" class="btn btn-success"><jstl:out
					value="${cancel}" /></a></center>
</security:authorize>
