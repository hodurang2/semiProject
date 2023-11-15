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

<style>
  .list_wrap {
    width: 100%;
    height: 48px;
    border-bottom: 1px solid gray;
  }
  .mypage_list {
    display: flex;
    justify-content: space-between;
    flex: 4;
  }
  .mypage_list li {
    width: 100%;
    
  }
  .mypage_list a {
    display: block;
    width: 100%;
    text-align: center;
    line-height: 48px;
    cursor: pointer;
  }
  .mypage_list a:hover {
    background-color: #bfff00;
    border-bottom: 1px solid gray;
  }
</style>

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
      <div class="col-sm-9">${sessionScope.user.interestSido} ${sessionScope.user.interestSigungu}</div>
    </div>
    
    
    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
      <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
      <button type="button" id="btn_modify_interest" class="btn btn-primary">관심지역변경</button>
      <button type="button" id="btn_modify" class="btn btn-primary">개인정보수정</button>
      <button type="button" id="btn_leave" class="btn btn-primary">회원탈퇴</button>
    </div>
    
    <div class="list_wrap">
      <ul class="mypage_list">
        <li><a href="${contextPath}/mypage/wishList.do">관심목록</a></li>
        <li><a href="${contextPath}/mypage/salesList.do">판매내역</a></li>
        <li><a href="${contextPath}/mypage/purchaseList.do">구매내역</a></li>
        <li><a href="${contextPath}/mypage/reviewList.do">받은판매후기</a></li>
      </ul>
    </div>
    
  </form>

</div>
<script>
  
  $(() => {
	  fnModifyUser();
	  fnModifyInterest();
	  fnLeaveUser();
  })

  const getContextPath = () => {
    let begin = location.href.indexOf(location.host) + location.host.length;
    let end = location.href.indexOf('/', begin + 1);
    return location.href.substring(begin, end);
  }
  
  const fnModifyUser = () => {
	  $('#btn_modify').click(() => {
		  location.href = '${contextPath}/mypage/modify.form';
	  })
  }
  
  const fnModifyInterest = () => {
	  $('#btn_modify_interest').click(() => {
		  location.href = getContextPath() + '/mypage/modifyInterest.form';
	  })
  }
  
  const fnLeaveUser = () => {
	  $('#btn_leave').click(() => {
	    if(confirm('회원 탈퇴하시겠습니까?')){
	      $('#frm_mypage').prop('action', getContextPath() + '/user/leave.do');
	      $('#frm_mypage').submit();
	    }
	  })
	}
  
</script>

