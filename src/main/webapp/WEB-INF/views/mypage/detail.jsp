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
    
    <h1>마이페이지</h1>
    
    <div>이메일 : ${sessionScope.user.email}</div>
    <div>이름 : ${sessionScope.user.name}</div>
    
    <div>
      <button type="button" id="btn_modify">개인정보수정</button>
      <button type="button" id="btn_leave">회원탈퇴</button>
    </div>
    
  </form>

</div>
<script>
  
  $(() => {
	  fnModifyUser();
  })

  const fnModifyUser(() => {
	  $('#btn_modify').click(() => {
		  location.href = '${contextPath}/mypage/modify.do';
	  })
  })
</script>
