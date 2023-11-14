<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="관심지역변경" name="title"/>
</jsp:include>

<div>
  <form id="frm_modify_interest" method="get">
    
    <h1 class="text-center mb-4">관심지역변경</h1>
    
    
      
  </form>

</div>

<%@ include file="../layout/footer.jsp" %>