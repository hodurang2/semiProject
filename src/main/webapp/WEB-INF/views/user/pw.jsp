<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="비밀번호변경" name="title"/>
</jsp:include>

<script src="${contextPath}/resources/js/user_modify_pw.js?dt=${dt}"></script>

<div>

  <form id="frm_modify_pw" method="post" action="${contextPath}/user/modifyPw.do">
    
    <h1>비밀번호 변경하기</h1>
      
    <div>
      <label for="pw">비밀번호</label>
      <input type="password" name="pw" id="pw">
      <span id="msg_pw"></span>
    </div>
    
    <div>
      <label for="pw2">비밀번호 확인</label>
      <input type="password" id="pw2">
      <span id="msg_pw2"></span>
    </div>
    
    <div>
      <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
      <button type="submit">비밀번호변경하기</button>
    </div>
    
  </form>

</div>

<%@ include file="../layout/footer.jsp" %>