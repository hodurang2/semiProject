<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="dt" value="<%=System.currentTimeMillis() %>"/>

<jsp:include page="../layout/header.jsp">
  <jsp:param value="공지 상세" name="title"/>
</jsp:include>

 <div>
    <h1>${notice.title}</h1>
    <div>작성자  : 관리자</div>
    <div>작성일  : <fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${notice.createdAt}"/></div>
    <div>
      <%-- <c:if test="${sessionScope.user.userNo == 1}"> --%>
        <form id="frm_btn" method="post">
          <input type="hidden" name="noticeNo" value="${notice.noticeNo}">
          <input type="hidden" name="title" value="${notice.title}">
          <input type="hidden" name="contents" value='${notice.contents}'>
          <button type="button" id="btn_edit" class="btn btn-primary">편집</button>
          <button type="button" id="btn_rmv"  class="btn btn-danger">삭제</button>
      </form>
      <%-- </c:if> --%>
    </div>
    <div>${notice.contents}</div>
  </div>
  
  <script>
    var frmBtn = $('#frm_btn');
    
    const fnEditNotice = () => {
      $('#btn_edit').click(() => {
        frmBtn.attr('action', '${contextPath}/notice/edit.form');
        frmBtn.submit();
      })
    }
    
    const fnRemoveNotice = () => {
  		$('#btn_rmv').click(() => {
  			if(confirm('삭제할까요?')){
  				alert('삭제되었습니다.');
    			frmBtn.attr('action', '${contextPath}/notice/remove.do');
    			frmBtn.submit();
  			}
  		})	
  	}
    fnEditNotice();
    fnRemoveNotice();
  </script>
  
<%@ include file="../layout/footer.jsp"%>