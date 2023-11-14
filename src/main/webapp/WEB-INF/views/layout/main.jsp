<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<%@ include file="header.jsp" %>

<div class="banner"><img src="${contextPath}/resources/image/banner_dum.png"></div>

<div class="btn_five">
  
  <ul>
    <li><a href="${contextPath}/product/new_list.jsp">최신</a></li>
    <li><a href="${contextPath}/product/hot_list.jsp">인기</a></li>
    <li><a href="${contextPath}/product/interest_list.jsp">관심지역</a></li>
    <li><a href="${contextPath}/product/myarea_list.jsp">내 주변 매물</a></li> 
    <li><a href="${contextPath}/product/latest_list.jsp">최근에 본 상품</a></li>
  </ul>
</div>

<h4>전체상품보기</h3>


<%@ include file="footer.jsp" %>