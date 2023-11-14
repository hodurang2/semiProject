<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../mypage/info.jsp"></jsp:include>

<div>

  <h1 class="text-center mb-4">나의 판매내역</h1>
  <div>
    <a href="${contextPath}/product/write.form">
      <button type="button" class="btn btn-primary">판매하기</button>
    </a>
  </div>
  
  <div id="sales_list" class="sales_list"></div>
  
</div>




<%@ include file="../layout/footer.jsp" %>