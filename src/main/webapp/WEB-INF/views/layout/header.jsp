<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${param.title == null ? '마이홈' : param.title}</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<link rel="stylesheet" href="${contextPath}/resources/css/init.css?dt=${dt}" />
<link rel="stylesheet" href="${contextPath}/resources/css/header.css?dt=${dt}" />
<link rel="stylesheet" href="${contextPath}/resources/css/main.css?dt=${dt}" />
<link rel="stylesheet" href="${contextPath}/resources/css/footer.css?dt=${dt}" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/40.0.0/decoupled-document/ckeditor.js"></script>
</head>
<body>

  <div class="header_wrap">
    <div class="logo"></div>
    <div class="login_wrap">
      <c:if test="${sessionScope.user == null}">
        <ul class="ul_menu right_wrap">
          <li><a href="${contextPath}/user/login.form">로그인</a></li>
          <li><a href="${contextPath}/user/agree.form">회원가입</a></li>
        </ul>
      </c:if>
      <c:if test="${sessionScope.user != null}">
        <div>${sessionScope.user.name}님 환영합니다 ♥</div>
        <div><a href="${contextPath}/user/logout.do">로그아웃</a></div>
      </c:if>
    </div>
    <div class="gnb_wrap">
      <ul class="gnb">
        <li><a href="${contextPath}/free/list.do">계층게시판</a></li>
        <li><a href="${contextPath}/blog/list.do">댓글형게시판</a></li>
        <li><a href="${contextPath}/upload/list.do">첨부게시판</a></li>
        <li><a href="${contextPath}/user/mypage.form">MY</a></li>
      </ul>
    </div>
  </div>
  
  <div class="main_wrap">
