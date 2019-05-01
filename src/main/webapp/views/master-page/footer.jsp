<%--
 * footer.jsp
 *
 * Copyright (C) 2019 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>

<%@page language="java" contentType="text/html; charset=ISO-8859-1"	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="date" class="java.util.Date" />

<hr />
<div class="container">
	<div class="row">
		<div class="col-auto mr-auto text-left">
			<b>Copyright &copy; <fmt:formatDate value="${date}" pattern="yyyy" /> Trond</b>
		</div>
		<div class="col-auto text-right">
			<a href="?language=en"><spring:message code="english" /></a>  |  <a href="?language=es"><spring:message code="spanish" /></a>    
		</div>
	</div>
</div>