<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="로그인" name="title"/>
</jsp:include>

<style>
  .login_form_wrap {
    width: 400px;
  }
</style>
  
  <div class="center_wrap login_form_wrap">
    <form method="post" action="${contextPath}/user/login.do">
      <div class="row align-items-center">      
        <div class="col-3">
          <label for="email" class="col-form-label">아이디</label>
        </div>
        <div class="col-6">
          <input type="text" name="email" id="email" placeholder="admin@gmail.com" class="form-control col-4">
        </div>
      </div>
      <div class="row align-items-center">      
        <div class="col-3">
          <label for="pw" class="col-form-label">비밀번호</label>
        </div>
        <div class="col-6">
          <input type="password" name="pw" id="pw" placeholder="●●●●" class="form-control col-4">
        </div>
      </div>
      <div class="d-grid gap-2">
        <input type="hidden" name="referer" value="${referer}">
        <button class="btn btn-success" type="submit">로그인</button>
      </div>
    </form>
    <ul class="ul_menu center_wrap">
      <li><a href="${contextPath}">자동로그인</a>
      <li><a href="${contextPath}">아이디/비밀번호 찾기</a>
    </ul>
    <hr>
    <div>
      <a href="${naverLoginURL}">
        <img src="${contextPath}/resources/image/btnG_완성형.png" width="200px">
      </a>
    </div>
  </div>

<%@ include file="../layout/footer.jsp" %>