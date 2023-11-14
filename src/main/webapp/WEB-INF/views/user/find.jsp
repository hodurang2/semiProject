<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="아이디/비밀번호 찾기" name="title"/>
</jsp:include>

  <h2>아이디/비밀번호 찾기</h2>
  
  <form method="post" action="${contextPath}/user/findId.do">
    <div>
      <label for="name">이름</label>
      <input type="text" name="name" id="id">
    </div>  
    <div>
      <label for="phone">전화번호</label>
      <input type="text" name="phone" id="phone">
    </div>
    <div>
      <button type="submit">아이디 찾기</button>
    </div>
  </form>
  
  <hr>
  
  <div>
    <div>
      <label for="email">이메일</label>
      <input type="text" name="email" id="email">
    </div>
    <div>
      <label for="name">이름</label>
      <input type="text" name="name" id="name">
    </div>  
    <div>
      <button type="button" id="btn_findPw">비밀번호 찾기</button>
    </div>
  </div>
  
<script>
	
  $(() => {
    fnFindPw();
    fnRule();
  })


  const fnFindPw = () => {
	$('#btn_findPw').click(() => {
	  $.ajax({
		url:  '${contextPath}/user/findPw.do',
		type: 'post',
		data: { 
				email: $('#email').val(),
				name: $('#name').val()
			  },
		success: (resData) => {
		  alert(resData);
		  location.href = '${contextPath}/user/login.form';
		},
	  })
	});
  }
  
  const fnRule = () => {
	if('${sessionScope.user}' != '') {
	  location.href= '${contextPath}/main.do';
	}
  }

</script>

<%@ include file="../layout/footer.jsp" %>