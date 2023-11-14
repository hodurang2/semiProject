<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="마이페이지" name="title" />
</jsp:include>

<div>

  <form id="frm_mypage" method="post">
    
    <h1 class="text-center mb-4">마이페이지</h1>
    
    <div class="row mb-4">
      <div class="col-sm-3">이메일</div>
      <div class="col-sm-9">${sessionScope.user.email}</div>
    </div>
    <div class="row mb-4">
      <div class="col-sm-3">이름</div>
      <div class="col-sm-9">${sessionScope.user.name}</div>
    </div>
    <div class="row mb-4">
      <div class="col-sm-3">관심지역</div>
      <div class="col-sm-9">${sessionScope.user.interestCity}</div>
    </div>
    
    <div>
      <button type="button" id="btn_modify_interest">관심지역변경</button>
    </div>
    
    <div class="list_wrap">
      <ul class="mypage_list">
        <li><a href="${contextPath}/mypage/trade.do">거래내역</a></li>
        <li><a href="${contextPath}/mypage/wishlist.do">찜목록보기</a></li>
        <li><a href="${contextPath}/mypage/review.do">리뷰보기</a></li>
      </ul>
      <div>
        <button type="button" id="btn_modify">개인정보수정</button>
        <button type="button" id="btn_leave">회원탈퇴</button>
      </div>
    </div>
  </form>

</div>
<script>
  
  $(() => {
	  fnModifyUser();
  })

  const fnModifyUser = () => {
	  $('#btn_modify').click(() => {
		  location.href = '${contextPath}/mypage/modify.form';
	  })
  }
  
  const fnModifyInterest = () => {
	  $('#btn_modify_interest').click((() => {
		  location.href = '${contextPath}/mypage/interest.do';
	  })
  }
</script>

<%@ include file="../layout/footer.jsp" %>