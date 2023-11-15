<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="메인" name="title"/>
</jsp:include>

<style>
    ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    
    li {
        display: inline;
        margin-right: 10px; /* Adjust the margin as needed */
    }
</style>


<div class="banner"><img src="${contextPath}/resources/image/banner_dum.png"></div>
<br>
<div class="btn_five">
  
  <ul>
    <li><a href="${contextPath}/product/list.do">최신</a></li>
    <li><a href="${contextPath}/product/hot_list.do">인기</a></li>
    <li><a href="${contextPath}/product/interest_list.do">관심지역</a></li>
    <li><a href="${contextPath}/product/myarea_list.do">내 주변 매물</a></li> 
    <li><a href="${contextPath}/product/latest_list.do">최근에 본 상품</a></li>
  </ul>
</div>

<br><hr>
<h4>전체상품보기</h3>


<%@ include file="footer.jsp" %>