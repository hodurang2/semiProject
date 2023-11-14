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
          <li><a href="${contextPath}/user/login.form"  id="login_btn">로그인</a></li>
          <li>고객센터</li>
        </ul>
      </c:if>
      <c:if test="${sessionScope.user != null}">
        <div>${sessionScope.user.name}님 환영합니다</div>
        <div>
          <a href="${contextPath}/product/write.form" id="joongo_btn">중고판매하기</a>
          <a href="${contextPath}/mypage/detail.do">마이페이지</a>
          <a href="${contextPath}/user/logout.do">로그아웃</a>
        </div>
      </c:if>
    </div>    
    <hr>  <!-- 중앙선 -->
    <div class="btn_menu_var">
        <i class="fa-solid fa-bars"></i>
      </div>
      <div class="css-1vh2lxo">카테고리</div>
      <div class="css_1vh2lxo">전체매물</div>
      <div class="hot_list"><a href="${contextPath}/product/hot_list.jsp">인기상품</a></div>
    </div>
    
  <div class="main_wrap">

<script>

    const fnMain = () => {
    	$('.logo').click(() => {
    		location.href = '${contextPath}/main.do';
    	})
    }
    fnMain();


</script>