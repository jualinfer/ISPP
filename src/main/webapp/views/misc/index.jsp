<%--
 * index.jsp
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


<security:authorize access="hasRole('ADMIN')">
<jsp:forward page="/administrator/controlPanel.do" />
</security:authorize>

<security:authorize access="hasRole('DRIVER')">
<jsp:forward page="/route/driver/listActive.do" />
</security:authorize>

<security:authorize access="hasRole('PASSENGER')">
<jsp:forward page="/route/passenger/listActive.do" />
</security:authorize>

<security:authorize access="isAnonymous()">
<jsp:forward page="/security/login.do" />
</security:authorize>

