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

  <h3>회원님의 아이디를 확인해주세요</h3>

  <div id="findIdResult">
    
  </div>
    
<script>
  $(() => {
	fnfindIdResult();
  })

  const fnfindIdResult = () => {
	if('${findId}' == ''){
      $('#findIdResult').text('조회결과가 없습니다');
      return;
	} else {
	  $('#findIdResult').text('${findId.email}');
	}
  }

</script>

<%@ include file="../layout/footer.jsp" %>