<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="약관동의" name="title"/>
</jsp:include>

<script src="${contextPath}/resources/js/user_agree.js"></script>

<div>

  <form id="frm_agree" action="${contextPath}/user/join.form">
    
    <h1>약관 동의하기</h1>
    
    <div>
      <input type="checkbox" id="chk_all">
      <label for="chk_all">모두 동의합니다</label>
    </div>
    
    <hr>
    
    <div>
      <input type="checkbox" name="service" id="service" class="chk_each">
      <label for="service">서비스 이용약관 동의(필수)</label>
    </div>
    <div>
      <textarea>본 약관은 ...</textarea>
    </div>
    
    <div>
      <input type="checkbox" name="event" id="event" class="chk_each">
      <label for="event">이벤트 알림 동의(선택)</label>
    </div>
    <div>
      <textarea>본 약관은 ...</textarea>
    </div>

    <div>
      <button type="submit">다음</button>
    </div>
    
  </form>

</div>

<%@ include file="../layout/footer.jsp" %>