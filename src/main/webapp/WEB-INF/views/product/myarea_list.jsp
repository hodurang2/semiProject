<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="업로드게시판" name="title"/>
</jsp:include>

<h3>내 지역 게시판</h3>

<div class="myarea_joongo">
  <!--  -->
  <select>
    <option></option>
    <option></option>
    <option></option>
    <option></option>
    <option></option>
    <option></option>
    <option></option>
    <option></option>
    <option></option>
    
  </select>

</div>

<%@ include file="../layout/footer.jsp" %>