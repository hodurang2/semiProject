<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="${blog.blogNo}번 블로그" name="title"/>
</jsp:include>

<style>
  .blind {
    display: none;
  }
  .ico_remove_comment {
    cursor: pointer;
  }
</style>

<div class="wrap wrap_8">

  <!-- 블로그 상세보기 -->
  <div>
    <div class="text-center">
      <!-- 블로그의 작성자는 편집/삭제를 수행할 수 있다. -->
      <c:if test="${sessionScope.user.userNo == blog.userDto.userNo}">
        <form id="frm_btn" method="post">
          <input type="hidden" name="blogNo" value="${blog.blogNo}">
          <input type="hidden" name="title" value="${blog.title}">
          <input type="hidden" name="contents" value='${blog.contents}'>
          <button type="button" id="btn_edit" class="btn btn-warning btn-sm">편집</button>
          <button type="button" id="btn_remove" class="btn btn-danger btn-sm">삭제</button>
        </form>
      </c:if>
    </div>
    
    
    <article class="detail_product">
      <div class="product_image">
        <div>
          <img alt fetchpriority="high" decoding="async" data-nimg="fill" class="css-zvtu8" 
            src="https://d3207f93x8dmgd.cloudfront.net/images/6552a6705e2f1319d5618620?size=lg"
            style="position: absolute; height: 100%; width: 100%; inset: 0px; color: transparent;">
        </div>
      </div>
     
      <!-- 카테고리, 제품 이름, 가격, 찜버튼 -->      
      <div>
        <!-- 제품 이름  -->
        <div class="title mt-4">
          <h1>${product.productName}</h1>
        </div>
        <div class="seller_user">
          <div>${product.sellerNo}</div>
        </div>
        <!-- 카테고리 -->
        <div class="category_tag">
          <a href="category?categoryid=??">${category.name}</a>
        </div>
        <div>조회수 : ${hit}</div>
        <div>가격 : ${product.productPrice}</div>
        <hr>
        <div>${product.productInfo}</div>
        <div>거래지역 : ${product.productCreatedAt}</div>
      </div>
    </article>
    
    
  </div>
  <script>
    
    var frmBtn = $('#frm_btn');
  
    const fnEditBlog = () => {
      $('#btn_edit').click(() => {
        frmBtn.attr('action', '${contextPath}/blog/edit.form');
        frmBtn.submit();
      })
    }
    
    const fnRemoveBlog = () => {
      $('#btn_remove').click(() => {
        if(confirm('블로그를 삭제하면 모든 댓글이 함께 삭제됩니다. 삭제할까요?')){
          frmBtn.attr('action', '${contextPath}/blog/remove.do');
          frmBtn.submit();          
        }
      })
    }
    
    const fnModifyResult = () => {
      let modifyResult = '${modifyResult}';
      if(modifyResult !== ''){
        if(modifyResult === '1'){
          alert('게시글이 수정되었습니다.');
        } else {
          alert('게시글이 수정되지 않았습니다.');
        }
      }
    }
    
    fnEditBlog();
    fnRemoveBlog();
    fnModifyResult();
    
  </script>
  
  <hr>
  
  <!-- 댓글 작성 화면 -->
  <div>
    <form id="frm_comment_add">
      <div class="input-group mb-3">
        <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
        <input type="hidden" name="blogNo" value="${blog.blogNo}">
        <textarea rows="5" name="contents" class="form-control" id="contents" placeholder="댓글을 작성해 주세요"></textarea>
        <button type="button" class="btn btn-primary btn-sm" id="btn_comment_add">작성완료</button>
      </div>
    </form>
  </div>

  <hr class="my-3">

  <!-- 블로그 댓글 목록 -->
  <div id="comment_list"></div>
  <div id="paging"></div>
  
  <script>
    
    const fnContentsClick = () => {
      $('#contents').click(() => {
        if('${sessionScope.user}' === ''){
          if(confirm('로그인이 필요한 기능입니다. 로그인할까요?')){
            location.href = '${contextPath}/user/login.form';
          } else {
            return;
          }
        }
      })
    }
  
    const fnCommentAdd = () => {
      $('#btn_comment_add').click(() => {
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
          url: '${contextPath}/blog/addComment.do',
          data: $('#frm_comment_add').serialize(),
          // 응답
          dataType: 'json',
          success: (resData) => {  // {"addCommentResult": 1}
            if(resData.addCommentResult === 1){
              alert('댓글이 등록되었습니다.');
              $('#contents').val('');
              fnCommentList();
            }
          }
        })
      })
    }
    
    // 전역 변수
    var page = 1;
    
    const fnCommentList = () => {
      $.ajax({
        // 요청
        type: 'get',
        url: '${contextPath}/blog/commentList.do',
        data: 'page=' + page + '&blogNo=${blog.blogNo}',
        // 응답
        dataType: 'json',
        success: (resData) => {  // resData = {"commentList": [], "paging": "<div>...</div>"}
          $('#comment_list').empty();
          $('#paging').empty();
          if(resData.commentList.length === 0){
            $('#comment_list').html('<div class="text-center my-3">첫 번째 댓글의 주인공이 되어 보세요</div>');
            $('#paging').text('');
            return;
          }
          $.each(resData.commentList, (i, c) => {
            let str = '';
            if(c.depth === 0){
              str += '<div">';
            } else {
              str += '<div style="padding-left: 32px;">';
            }
            if(c.status === 0){
              str += '<div>삭제된 댓글입니다.</div>';
            } else {
              str += '  <div>' + c.userDto.name + '</div>';
              str += '  <div>' + c.contents + '</div>';
              str += '  <div style="font-size: 12px;">' + c.createdAt + '</div>';
              str += '  <div>';
              if(c.depth === 0){
                str += '  <button type="button" class="btn btn-outline-primary btn-sm btn_open_reply">답글달기</button>';
              }
              if('${sessionScope.user.userNo}' == c.userDto.userNo){                
                str += '  <input type="hidden" value="' + c.commentNo + '">';
                str += '  <i class="fa-regular fa-circle-xmark ico_remove_comment"></i>';
              }
              str += '  </div>';
              /************************** 답글 입력 창 **************************/
              str += '  <div class="blind frm_add_reply_wrap">';
              str += '    <form class="frm_add_reply">';
              str += '      <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">';
              str += '      <input type="hidden" name="blogNo" value="${blog.blogNo}">';
              str += '      <input type="hidden" name="groupNo" value="' + c.groupNo + '">';
              str += '      <div class="input-group mb-3">';
              str += '        <textarea rows="2" name="contents" class="form-control" placeholder="답글을 입력하세요"></textarea>';
              str += '        <button type="button" class="btn btn-success btn-sm btn_add_reply">답글작성완료</button>';
              str += '      </div>';
              str += '    </form>';
              str += '  </div>';
              /******************************************************************/
            }
            str += '</div>';
            str += '<hr class="my-3">';
            $('#comment_list').append(str);
          })
          $('#paging').append(resData.paging);  // fnAjaxPaging() 함수가 호출되는 곳
        }
      })
    }
    
    const fnAjaxPaging = (p) => {
      page = p;
      fnCommentList();
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
    
    const fnCommentReplyAdd = () => {
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
          url: '${contextPath}/blog/addCommentReply.do',
          data: frmAddReply.serialize(),
          // 응답
          dataType: 'json',
          success: (resData) => {  // resData = {"addCommentReplyResult": 1}
            if(resData.addCommentReplyResult === 1){
              alert('답글이 등록되었습니다.');
              fnCommentList();
              frmAddReply.find('textarea').val('');
            } else {
              alert('답글이 등록되지 않았습니다.');
            }
          }
        })
      })
    }
    
    const fnCommentRemove = () => {
      $(document).on('click', '.ico_remove_comment', (ev) => {
        if(!confirm('해당 댓글을 삭제할까요?')){
          return;
        }
        $.ajax({
          // 요청
          type: 'post',
          url: '${contextPath}/blog/removeComment.do',
          data: 'commentNo=' + $(ev.target).prev().val(),
          // 응답
          dataType: 'json',
          success: (resData) => {  // resData = {"removeResult": 1}
            if(resData.removeResult === 1){
              alert('해당 댓글이 삭제되었습니다.');
              fnCommentList();
            } else {
              alert('댓글이 삭제되지 않았습니다.');
            }
          }
        })
      })
    }
    
    fnContentsClick();
    fnCommentAdd();
    fnCommentList();
    fnBlind();
    fnCommentReplyAdd();
    fnCommentRemove();
    
    /*
    <div>

      // 삭제된 댓글/답글
      <div>삭제된 댓글입니다</div>
    
      // 정상 댓글/답글
      <div>이름</div>
      <div>내용</div>
      <div style="font-size: 12px;">작성일자</div>
      <div>
        <button type="button" class="btn btn-outline-primary btn-sm btn_open_reply">답글달기</button>
        // 댓글 작성자만 삭제
        <input type="hidden" value="commentNo값">
        <i class="fa-regular fa-circle-xmark ico_remove_comment"></i>        
      </div>
      <div class="blind frm_add_reply_wrap">
        <form class="frm_add_reply">
          <input type="hidden" name="userNo" value="">
          <input type="hidden" name="blogNo" value="">
          <input type="hidden" name="groupNo" value="">
          <div class="input-group mb-3">
            <textarea rows="2" name="contents" class="form-control" placeholder="답글을 입력하세요"></textarea>
            <button type="button" class="btn btn-success btn-sm btn_add_reply">답글작성완료</button>
          </div>
        </form>
      </div>
      
    </div>
    <hr class="my-3">
    */
    
  </script>

</div>

<%@ include file="../layout/footer.jsp" %>