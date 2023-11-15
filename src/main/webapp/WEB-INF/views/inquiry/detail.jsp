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
    			frmBtn.attr('action', '${contextPath}/notice/remove.do');
    			frmBtn.submit();
  			}
  		})	
  	}
    fnEditNotice();
    fnRemoveNotice();
  </script>
  
  <div>
    <form id="frm_answer_add">
      <textarea rows="3" cols="50" name="contents" id="contents" placeholder="댓글을 작성해 주세요"></textarea>
      <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
      <input type="hidden" name="blogNo" value="${blog.blogNo}">
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
            data: $('#frm_comment_add').serialize(),
            // 응답
            dataType: 'json',
            success: (resData) => {  // {"addCommentResult": 1}
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
    
    const fnAnswerList = () => {
      $.ajax({
        // 요청
        type: 'get',
        url: '${contextPath}/inquiry/answerList.do',
        data: 'page=' + page + '&inquiryNo=${inquiry.inquiryNo}',
        // 응답
        dataType: 'json',
        success: (resData) => {  // resData = {"commentList": [], "paging": "<div>...</div>"}
          $('#comment_list').empty();
          $('#paging').empty();
          if(resData.commentList.length === 0){
            $('#comment_list').text('첫 번째 댓글의 주인공이 되어 보세요');
            $('#paging').text('');
            return;
          }
          $.each(resData.commentList, (i, c) => {
            let str = '';
            if(c.depth === 0){
              str += '<div style="width: 100%; border-bottom: 1px solid gray;">';
            } else {
              str += '<div style="width: 100%; border-bottom: 1px solid gray; margin-left: 32px;">';
            }
            if(c.status === 0){
              str += '<div>삭제된 댓글입니다.</div>';
            } else {
              str += '  <div>' + c.userDto.name + '</div>';
              str += '  <div>' + c.contents + '</div>';
              str += '  <div style="font-size: 12px;">' + c.createdAt + '</div>';
              if(c.depth === 0){
                str += '  <div><button type="button" class="btn_open_reply">답글달기</button></div>';
              }
              /************************** 답글 입력 창 **************************/
              str += '  <div class="blind frm_add_reply_wrap">';
              str += '    <form class="frm_add_reply">';
              str += '      <textarea rows="3" cols="50" name="contents" placeholder="답글을 입력하세요"></textarea>';
              str += '      <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">';
              str += '      <input type="hidden" name="blogNo" value="${blog.blogNo}">';
              str += '      <input type="hidden" name="groupNo" value="' + c.groupNo + '">';
              str += '      <button type="button" class="btn_add_reply">답글작성완료</button>';
              str += '    </form>';
              str += '  </div>';
              /******************************************************************/
              if('${sessionScope.user.userNo}' == c.userDto.userNo){                
                str += '  <div>';
                str += '    <input type="hidden" value="' + c.commentNo + '">';
                str += '    <i class="fa-regular fa-circle-xmark ico_remove_comment"></i>';
                str += '  </div>';
              }
            }
            str += '</div>';
            $('#comment_list').append(str);
          })
          $('#paging').append(resData.paging);  // fnAjaxPaging() 함수가 호출되는 곳
        }
      })
    }
       
    
    
    
      fnAnswerAdd();
      fnAnswerList();
    
  </script>
  
  
  
<%@ include file="../layout/footer.jsp"%>