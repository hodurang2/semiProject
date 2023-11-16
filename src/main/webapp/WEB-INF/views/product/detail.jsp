<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="${product.productName}" name="title"/>
</jsp:include>

  <h1>${product.productName}</h1>
  
  <div class="text-left">
   <div>
    <c:if test="">
      <form id ="frn_btn" method="post">
        <input type="hidden" name="ProductNo"     value="${product.productNo}">
        <button type="button" id="btn_edit" class="btn btn-warning btn-sm">수정</button>
        <button type="button" id="btn_remove" class="btn btn-danger btn-sm">삭제</button>
      </form>
    </c:if>
   </div>
   
    <div>작성자:   ${product.sellerNo}</div>
    <div>상품명:   ${product.productName}</div>
    <div>카테고리: ${product.categoryDto}</div>
    <div>상품가격: ${product.productPrice}</div>
    <div>거래지역: ${product.tradeAddress}</div>
    <div>설명:     ${product.productInfo}</div>
    <div>작성일:   ${product.productCreatedAt}</div>
    <div>수정일:   ${product.productModifiedAt}</div>

  <!-- 구분선 -->
  <hr class="my-3">
 
  <script>
  	/* 게시글 수정  */	
  	var frmBtn = $('#frm_btn');
  	
  	// 수정
  	const fnEditProduct = () =>{
  		$('#btn_edit').click(() => {
  			frmBtn.attr('action', '${contextPath}/product/edit.form');
  			frmBtn.submit();
  		})
  	}
  	
 // 수정alert
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
  	
  	// 삭제
  	const fnRemoveProduct = () => {
  		$('#btn_remove').click(() => {
  			if(confirm('게시글을 삭제하시겠습니까?')){
  				frmBtn.attr('action', '${contextPath}/product/remove.do');
  				frmBtn.submit();
  			}
  		})
  	}
  	
  	fnEditProduct();
  	fnModifyResult();
  	fnRemoveProduct();
  	
  
  </script>
  
  <hr>
  
  <div>
    <form id="frm_comment_add">
      <div class="input-group mb-3">
         <input type="hidden" name="userNo" value="${sessionScope.user}"><!-- user 놔두기  -->
         <input type="hidden" name="productNo" value="${product.productNo}">
         <textarea rows="5" cols="contents" class="form-control"  id="contents" placeholder="댓글을 작성해주세요"></textarea>
         <button type="button" class="btn btn-primary btn-sm"  id="btn_comment_add">작성완료=</button>
      </div>
    </form>  
  </div>

<hr class="my-3">

<!-- 블로그 댓글 목록 -->
<div id="commnet_list"></div>
<div id="paging"></div>

<script>
	const fnCommentClick = () => {
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
				type:'post',
				url : '${contextPath}/product/addComment.do',
				data : $('#frm_comment_add').serialize(),
				// 응답
				dataType : 'json',
				success : (resData) => {
					if(resData.addCommentResult === 1){
						alert('댓글이 등록되었습니다.');
						$('#contents').val('');
						ffnCommentList();
					}
				}
				
			})
		})
		
	}
	
	var page = 1;
	
	const fnCommentList = () => {
		$.ajax({
			type:'get',
			url :'${contextPath}/product/commentList.do',
			 data: 'page=' + page + '&blogNo=${product.productNo}',
			// 응답
			dataType :'json',
			success : (resData) =>{
				$('#comment_list').empty();
				$('#paging').empty();
		          if(resData.commentList.length === 0){
		            $('#comment_list').html('<div class="text-center my-3">댓글을 통해 중고거래를 진행해보세요!</div>');
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
		                /* 일단은 써두는데, REVIEW 관련해서 이야기 좀 해야할듯*/
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
		      
	
</script>

</div>



<%@ include file="../layout/footer.jsp" %>

