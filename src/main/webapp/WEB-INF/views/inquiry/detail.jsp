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

<style>
  .blind {
    display: none;
  }
  .ico_remove_comment {
    cursor: pointer;
  }
</style>

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
      <input type="hidden" name="inquiryNo" value="${inquiry.inquiryNo}">
      <input type="hidden" name="answerNo" value="${answer.answerNo}">
      <button type="button" id="btn_answer_add">작성완료</button>
    </form>
  </div>
  <div style="width: 100%;border-bottom: 1px solid gray;"></div>
  <div id="answer_list"></div>
  <div id="paging"></div>
  
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
              fnAlarmAdd();
              fnAnswerList();
            }
          }
        })
      })
    }
    const fnAlarmAdd = () => {
  	  $.ajax({
  		  type: 'post',
  		  url: '${contextPath}/addAlarm.do'
  		  data: ${inquiry.inquiryTitle},
  		  dataType: 'json',
  	  })
    }
    
    // 전역 변수
    var page = 1;
    
    const fnAnswerList = () => {
        $.ajax({
          // 요청
          type: 'get',
          url: '${contextPath}/inquiry/answerList.do',
          data: 'page=' + page + '&inquiryNo=${inquiry.inquiryNo}',
          // 응답
          dataType: 'json',
          success: (resData) => {  // resData = {"answerList": [], "paging": "<div>...</div>"}
            $('#answer_list').empty();
            $('#paging').empty();
            if(resData.answerList.length === 0){
              $('#answer_list').text('첫 번째 댓글의 주인공이 되어 보세요');
              $('#paging').text('');
              return;
            }
            $.each(resData.answerList, (i, answer) => {
              let str = '';
              if(answer.depth === 0){
                str += '<div style="width: 100%; border-bottom: 1px solid gray;">';
              } else {
                str += '<div style="width: 100%; border-bottom: 1px solid gray; margin-left: 32px;">';
              }
              if(answer.status === 0){
                str += '<div>삭제된 댓글입니다.</div>';
              } else {
                str += '  <div>' + answer.contents + '</div>';
                str += '  <div style="font-size: 12px;">' + answer.createdAt + '</div>';
                if(answer.depth === 0){
                  str += '  <div><button type="button" class="btn_open_reply">답글달기</button></div>';
                }
                /************************** 답글 입력 창 **************************/
                str += '  <div class="blind frm_add_reply_wrap">';
                str += '    <form class="frm_add_reply">';
                str += '      <textarea rows="3" cols="50" name="contents" placeholder="답글을 입력하세요"></textarea>';
                str += '      <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">';
                str += '      <input type="hidden" name="inquiryNo" value="${inquiry.inquiryNo}">';
                str += '      <input type="hidden" name="groupNo" value="' + answer.groupNo + '">';
                str += '      <button type="button" class="btn_add_reply">답글작성완료</button>';
                str += '    </form>';
                str += '  </div>';
                /******************************************************************/
                if('${sessionScope.user.userNo}' == '${inquiry.userDto.userNo}'){                
                  str += '  <div>';
                  str += '  </div>';
                }
              }
              str += '</div>';
              $('#answer_list').append(str);
            })
            $('#paging').append(resData.paging);  // fnAjaxPaging() 함수가 호출되는 곳
          }
        })
      }
    
    
    const fnAjaxPaging = (p) => {
      page = p;
      fnAnswerList();
    }
    
    const fnBlind = () => {
      $(document).on('click', '.btn_open_reply', (ev) => {
        if('${sessionScope.user}' === ''){
          if(confirm('로그인이 필요한 기능입니다. 로그인할까요?')){
            location.href = '${contextPath}/user/login.form';
          } else {
            return;
          }
        }
        var blindTarget = $(ev.target).parent().next();
        if(blindTarget.hasClass('blind')){
          $('.frm_add_reply_wrap').addClass('blind');  // 모든 답글 입력화면 닫기
          blindTarget.removeClass('blind');            // 답글 입력화면 열기
        } else {
          blindTarget.addClass('blind');
        }
      })
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
    fnAnswerList();
    fnAnswerReplyAdd();
    fnBlind();
      
  </script>
  
  
  
  
<%@ include file="../layout/footer.jsp"%>