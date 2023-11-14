<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="header.jsp">
  <jsp:param value="마이홈" name="title"/>
</jsp:include>

<div class="banner"><img src="${contextPath}/resources/image/banner_dum.png"></div>

<div class="btn_five">
  <button id="new"><a href="${contextPath}/product/new_list.jsp">최신</a></button>
  <button id="hot_joongo"><a href="${contextPath}/product/hot_list.jsp">인기</a></button>
  <button id="interest_city"><a href="${contextPath}/product/interest_list.jsp">관심지역</a></button>
  <button id="my_city_joongo"><a href="${contextPath}/product/myarea_list.jsp">내 주변 매물</a></button>
  <button id="recent"><a href="${contextPath}/product/latest_list.jsp">최근에 본 상품</a></button>
</div>

<h4>전체상품보기</h3>


<%@ include file="footer.jsp" %>