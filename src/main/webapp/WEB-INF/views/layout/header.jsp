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
    <div class="header_dddd">
     <div class="logo">
      <img src="${contextPath}/resources/image/logo.png" width="150px">
    </div>
    
    <!-- 검색 -->
    <div class="search">
      <form id="search_frm" action="${contextPath}/product/searchList.do">
        <input type="text" name="searchWord" id="searchWord" class="searchWord input-group-text">
        <button type="submit" id="btn_search" class="btn_search"><i class="fa-solid fa-magnifying-glass search_icon" style="color: #1937cc;"></i></button>
        <input type="hidden" name="userNo" id="userNo" value="${sessionScope.user.userNo}" >
      </form>
    </div>
    
    
   </div> 
 </div>
 
  <!-- 로그인 --> 
    <div class="login_wrap">
      <c:if test="${sessionScope.user == null}">
        <ul class="ul_menu right_wrap">
          <li><a href="${contextPath}/user/login.form"  id="login_btn">로그인</a></li>
          <li><a href="${contextPath}/notice/list.do"  id="support_btn">고객센터</a></li>
        </ul>
      </c:if>
      <ul class="ul_menu right_wrap">
      <c:if test="${sessionScope.user != null}">
        <li>${sessionScope.user.name}님 환영합니다</li>
          <li><a href="${contextPath}/product/write.form" id="joongo_btn">중고판매하기</a></li>
          <li><a href="${contextPath}/mypage/detail.do">마이페이지</a></li>
          <li><a href="${contextPath}/user/logout.do">로그아웃</a></li>
          <li><a href="${contextPath}/notice/list.do"  id="support_btn">고객센터</a></li>
      </c:if>
      </ul>
     </div>
 
 
    <hr>
      <ul class="menu_var left_var">
        <li><i class="fa-solid fa-bars"></i></li>
        <li><div class="css-1vh2lxo">카테고리</div></li>
        <li><div class="css_1vh2lxo">전체매물</div></li>
        <li><div class="hot_list"><a href="${contextPath}/product/hot_list.do">인기상품</a></div></li>
      </ul>
  <hr>
<script>

    const fnMain = () => {
    	$('.logo').click(() => {
    		location.href = '${contextPath}/main.do';
    	})
    }
    
    const fnSearch = () => {
    	$('#search_frm').submit((e) => {
    		if('${sessionScope.user}' === ''){
    			alert('로그인 해주세요.');
    			e.preventDefault();
    			location.href = '${contextPath}/main.do';
    			return;
    		}
    		if($('#searchWord').val() === '') {
    			e.preventDefault();
    			return;
    		}
    	})
    }
    
    fnMain();
		fnSearch();

</script>