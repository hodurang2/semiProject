<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="dt" value="<%=System.currentTimeMillis() %>"/>

<jsp:include page="../layout/header.jsp">
  <jsp:param value="문의 상세" name="title"/>
</jsp:include>

 <div>
    <h1>${inquiry.inquiryTitle}</h1>
    <div>작성자  : ${inquiry.userDto.email}</div>
    <div>작성일  : <fmt:formatDate pattern="yyyy-MM-dd" value="${inquiry.inquiryCreatedAt}"/></div>
    <div>
        <form id="frm_btn" method="post">
          <input type="hidden" name="noticeNo" value="${inquiry.inquiryNo}">
          <input type="hidden" name="title" value="${inquiry.inquiryTitle}">
          <input type="hidden" name="contents" value="${inquiry.inquiryContent}">
          <button type="button" id="btn_edit" class="btn btn-primary">편집</button>
          <button type="button" id="btn_rmv"  class="btn btn-danger">삭제</button>
      </form>
      <%-- </c:if> --%>
    </div>
    <div>${inquiry.inquiryContent}</div>
  </div>
  
  <div>
    <form id="frm_answer_add">
      <textarea rows="3" cols="50" name="contents" id="contents" placeholder="댓글을 작성해 주세요"></textarea>
      <input type="hidden" name="inquirtNo" value="${inquiry.inquiryNo}">
      <input type="hidden" name="answerNo" value="${answer.answerNo}">
      <button type="button" id="btn_answer_add">작성완료</button>
    </form>
  </div>
  
  <script>
    const fnAnswerAdd = () => {
        $('#btn_answer_add').click(() => {
          if('${sessionScope.user}' === ''){
            if(confirm('로그인이 필요한 기능입니다. 로그인할까요?')){
              location.href = '${contextPath}/user/login.form';
            } else {
              return;
            }
          }
          $.ajax({
            // 요청
            type: 'post',
            url: '${contextPath}/inquiry/addAnswer.do',
            data: $('#frm_answer_add').serialize(),
            // 응답
            dataType: 'json',
            success: (resData) => {  // {"addAnswerResult": 1}
              if(resData.addAnswerResult === 1){
                alert('댓글이 등록되었습니다.');
                $('#contents').val('');
                fnAnswerList();
              }
            }
          })
        })
    }
    
    // 전역 변수
    var page = 1;
    
    const fnAjaxPaging = (p) => {
      page = p;
      fnAnswerList();
    }
    
    const fnAnswerReplyAdd = () => {
      $(document).on('click', '.btn_add_reply', (ev) => {
        if('${sessionScope.user}' === ''){
          if(confirm('로그인이 필요한 기능입니다. 로그인할까요?')){
            location.href = '${contextPath}/user/login.form';
          } else {
            return;
          }
        }
        var frmAddReply = $(ev.target).closest('.frm_add_reply');
        $.ajax({
          // 요청
          type: 'post',
          url: '${contextPath}/inquiry/addAnswerReply.do',
          data: frmAddReply.serialize(),
          // 응답
          dataType: 'json',
          success: (resData) => {  // resData = {"addCommentReplyResult": 1}
            if(resData.addAnswerReplyResult === 1){
              alert('답글이 등록되었습니다.');
              fnAnswerList();
              frmAddReply.find('textarea').val('');
            } else {
              alert('답글이 등록되지 않았습니다.');
            }
          }
        })
      })
    }
    
    
    
    
      fnAnswerAdd();
    
  </script>
  
  
  
<%@ include file="../layout/footer.jsp"%>