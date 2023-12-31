<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../mypage/info.jsp"></jsp:include>

<style>

  .purchase_list {
    margin: 5px auto;
    display: flex;
    flex-wrap: wrap;
   }
  .purchase_product {
    width: 200px;
    height:  230px;
    border: 1px solid gray;
    padding-top: 80px;
    margin: 10px 10px;
  }
  .purchase_product:hover {
    background-color: silver;
    cursor: pointer;
  }
  h1 {
    margin: 30px 0;
  }
  .btn_review {
    margin-top: 20px;
  }

</style>

<div>

  <h1 class="text-center mb-4">나의 구매내역</h1>
  
  <div class="wrap wrap_9">
    <div id="purchase_list" class="purchase_list"></div>  
  </div>
  
</div>

<script>

  $(() => {
	  
	  fnGetPurchaseList();
	  fnReview();
	  fnDetail();
	  fnViewReview();
	  
  })

  // 전역 변수
  var page = 1;
  var totalPage = 0;
  var productNo;
  
  const fnGetPurchaseList = () => {
    $.ajax({
      // 요청
      type: 'get',
      url: '${contextPath}/mypage/getPurchaseList.do',
      data: 'page=' + page + '&buyerNo=${sessionScope.user.userNo}',
      // 응답
      dataType: 'json',
      success: (resData) => {   // resData = {"buyerNo": 1, "purchaseList": [], "totalPage" : 10}
        totalPage = resData.totalPage;
        $.each(resData.purchaseList, (i, pp) => {
          let str = '<div class="purchase_product" data-product-no="' + pp.productNo + '">';
          str += '<div>상품명: ' + pp.productName + '</div>';
          if(pp.buyerNo === null) {
            str += '<div>탈퇴한 판매자</div>';
          } else {
            str += '<div>판매자: ' + pp.sellerNo + '</div>';
          }
          str += '<div>등록일: ' + pp.productCreatedAt + '</div>';
          str += '</div>';
    
          if(pp.reviewContents === null) {
            // 작성한 리뷰가 없을 때만 버튼 생성
        	  str += '<button type="button" class="btn_review">리뷰작성</button>';
          } else if(pp.reviewContents !== null) {
            // 작성한 리뷰가 있을 때만 버튼 생성
        	  str += '<button type="button" class="btn_view_review">내가 쓴 리뷰보기</button>';
          }
          
          $('#purchase_list').append(str);
        
        })
      }
    })
  }
  
  const fnReview = () => {
	  $(document).on('click', '.btn_review', (ev) => {
		  productNo = $(ev.target).prev().data('productNo');
		  location.href = '${contextPath}/mypage/writeReview.form?productNo=' + productNo;
	  })
  }
  

  const fnDetail = () => {
	  $(document).on('click', '.purchase_product', function(ev) {
		  productNo = $(this).data('productNo');
		  location.href = '${contextPath}/product/detail.do?productNo=' + productNo;
	  })
  }
  
  const fnViewReview = () => {
	  $(document).on('click', '.btn_view_review', (ev) => {
		  productNo = $(ev.target).prev().data('productNo');
		  location.href = '${contextPath}/mypage/viewReview.do?productNo=' + productNo;
	  })
  }

</script>

<%@ include file="../layout/footer.jsp" %>