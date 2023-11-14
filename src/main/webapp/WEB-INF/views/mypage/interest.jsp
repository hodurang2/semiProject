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

  <h1 class="title">관심지역 변경하기</h1>

  <form id="frm_modify_interest" class="mt-5" method="post">
    
    <div class="row mb-2">
      <div class="col-sm-3">관심지역</div>
      <select name="interest_sido" id="interest_sido"></select>
      <select name="interest_sigungu" id="interest_sigungu"></select>
    </div>
    
    <div class="text-center mt-3">
      <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
      <button type="button" class="btn btn-primary">관심지역변경하기</button>
    </div>
  </form>

</div>

<script>
  
  $(() => {
	  fnModifyInterest();
  })
  
  const fnModifyInterest = () => {
	  $('#frm_modify_interest').((ev) => {

	  })
  }
</script>

<%@ include file="../layout/footer.jsp" %>