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
  
  <div class="text-left">
   <div>
    <form id ="frm_btn" method="post">
      <div>작성자:   ${sessionScope.user.name}</div>
      <div>상품명:   ${product.productName}</div>
      <div>카테고리: ${product.categoryDto.categoryId}</div>
      <div>상품가격: ${product.productPrice}</div>
      <div>거래지역: ${product.tradeAddress}</div>
      <div>설명:     ${product.productInfo}</div>
      <div>조회수 : ${product.hit}</div>
      <input type="hidden" name="productNo"     value="${product.productNo}">
      <c:if test="${sessionScope.user.userNo == product.sellerNo}">
        <button type="button" id="btn_edit" class="btn btn-warning btn-sm">수정</button>
        <button type="button" id="btn_remove" class="btn btn-danger btn-sm">삭제</button>
      </c:if>
      <div>작성일:   ${product.productCreatedAt}</div>
      <div>수정일:   ${product.productModifiedAt}</div>
    </form>
   </div>

  <!-- 구분선 -->
  <hr class="my-3">
 
  <script>
  	// 게시글 수정	
  	var frmBtn = $('#frm_btn');
  	
  	// 수정
  	const fnEditProduct = () =>{
  		$('#btn_edit').click(() => {
  			frmBtn.attr('action', '${contextPath}/product/edit.form');
  			frmBtn.attr('method', 'get')
  			frmBtn.submit();
  		})
  	}
  	
  	
  	// 삭제
  	const fnRemoveProduct = () => {
  		$('#btn_remove').click(() => {
  			if(confirm('게시글을 삭제하시겠습니까?')){
  				frmBtn.attr('action', '${contextPath}/product/removeProduct.do');
  				frmBtn.submit();
  			}
  		})
  	}
  	
  	fnEditProduct();
  	fnRemoveProduct();
  	

  </script>

  <hr>
  
<!-- 댓글 -->
<div>
  <form id="frm_comment_add">
    <textarea rows="3" cols="50" name="contents" placeholder="댓글을 작성해 주세요"></textarea>
    <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
  <input type="hidden" name="productNo" value="${product.productNo}">
  <button type="button" id="btn_comment_add">작성완료</button>
</form>

<!-- 댓글 목록 -->
  <div style="width: 100%; border-bottom: 1px solid gray;"></div>
  <div id="productCommentList"></div>
  <div id="paging"></div>

<script>

  
  const fnProductCommentAdd = () => {
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
		url: '${contextPath}/product/addProductComment.do',
		data: $('#frm_comment_add').serialize(),
		// 응답
		dataType: 'json',
		success: (resData) => {
		  if(resData.addProductCommentResult === 1){
			 alert('댓글 등록완료');
			 $('#contents').val('');
			 fnProductCommentList();
		  }
		}
	  })
	})
  }
  
  var page = 1;
  
  const fnProductCommentList = () => {
	$.ajax({
	  // 요청
	  type: 'get',
	  url: '${contextPath}/product/productCommentList.do',
	  data: 'page=' + page + '&productNo=${product.productNo}',
	  // 응답
	  dataType: 'json',
	  success: (resData) => {
		$('#productCommentList').empty();
		$('#paging').text('');
		if(resData.productCommentList.length === 0){
		  $('#productCommentList').text('댓글이 없습니다.');
		  $('#paging').text('');
          return;
	  }
	  $.each(resData.productCommentList, (i, c) => {
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
              str += '  <div><button type="button" class="btn_open_reply"> 답글달기</button></div>'; 
            }
            /************************** 답글 ***********************************/
            str += '  <div class="blind frm_add_reply_wrap">';  
            str += '    <form class="frm_add_reply">';
            str += '      <textarea rows="3" cols="50" name="contents" placeholder="답글을 입력하세요"></textarea>';
            str += '      <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">';
            str += '      <input type="hidden" name="productNo" value="${product.productNo}">';
            str += '      <input type="hidden" name="groupNo" value="' + c.groupNo + '">';
            str += '      <button type="button" class="btn_add_reply">답글작성완료</button>';
            str += '    </form>';
            str += '  </div>';
            /******************************************************************/
            if('${sessionScope.user.userNo}' == c.userDto.userNo){          	  
              str += '  <div>';
              str += '    <input type="hidden" value="' + c.commentNo + '">';
              str += '    <i class="fa-solid fa-trash ico_remove_comment"></i>';
              str += '  </div>';												 			  		   	
            }
          }
          str += '</div>';												 			  		
          $('#productCommentList').append(str); 
        })
        $('#paging').append(resData.paging);  
      }
    })
  }
	
  const fnAjaxPaging = (p) => {
    	page = p;
    	fnProductCommentList(); 
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
          $('.frm_add_reply_wrap').addClass('blind'); 
        	blindTarget.removeClass('blind');		 
        } else {
          blindTarget.addClass('blind');
        }
	 })
  }
  
  const fnProductCommentReplyAdd = () => {
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
     		 url: '${contextPath}/product/addProductCommentReply.do',
     		 data: frmAddReply.serialize(),	
     	     // 응답
     	     dataType: 'json',
     	     success: (resData) => {	
     	       if(resData.addProductCommentReplyResult === 1){
     	    	  alert('답글이 등록되었습니다.');
     	    	  fnProductCommentList();	 
     	    	  frmAddReply.find('textarea').val(''); 
     	       } else {
     	    	  alert('답글이 등록되지 않았습니다.');
     	       }
     	     }
     	  })
  	})
    }
  
  const fnProductCommentRemove = () => {
    	$(document).on('click', '.ico_remove_comment', (ev) => {
    		if(!confirm('해당 댓글을 삭제할까요?')){
    			return;
    		}
    		$.ajax({
    			// 요청
    			type: 'post',
    			url: '${contextPath}/product/removeProductComment.do',
    			data: 'commentNo=' + $(ev.target).prev().val(),	  
    			// 응답
    			dataType: 'json',
    			success: (resData) => {  // resData = {"removeProductCommentResult": 1}
    				if(resData.removeProductCommentResult === 1){
    					alert('해당 댓글이 삭제되었습니다.');
    					fnProductCommentList();
    				} else {
    					alert('댓글이 삭제되지 않았습니다.');
    				}
    			}
    		})
    	})
    }
  
  // 호출
  fnProductCommentAdd();
  fnProductCommentList();
  fnBlind();
  fnProductCommentReplyAdd();
  fnProductCommentRemove();
  
</script>
</div>

</div>



<%@ include file="../layout/footer.jsp" %>

