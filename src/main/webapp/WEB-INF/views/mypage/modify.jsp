<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="마이페이지" name="title"/>
</jsp:include>

<div>

  <form id="frm_mypage_modify" method="post">

    <h1>회원정보수정</h1>

    <div>
      <buttton type="button" id="btn_modify_pw">비밀번호변경</buttton>
    </div>
    
    <div>이메일 : ${sessionScope.user.email}</div>
    <div>가입일 : ${sessionScope.user.joinedAt}</div>
    
    <div>
      <label for="name">이름</label>
      <input type="text" name="name" id="name" value="${sessionScope.user.name}">
      <span id="msg_name"></span>
    </div>

    <div>
      <input type="radio" name="gender" value="NO" id="none">
      <label for="none">선택안함</label>
      <input type="radio" name="gender" value="M" id="man">
      <label for="man">남자</label>
      <input type="radio" name="gender" value="F" id="woman">
      <label for="woman">여자</label>
    </div>
    <script>
      $(':radio[value=${sessionScope.user.gender}]').prop('checked', true);
    </script>
    
    <div>
      <label for="mobile">휴대전화번호</label>
      <input type="text" name="mobile" id="mobile" value="${sessionScope.user.mobile}">
      <span id="msg_mobile"></span>
    </div>
        
  </form>
  
  
  
</div>

<%@ include file="../layout/footer.jsp" %>