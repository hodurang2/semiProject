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
    width: 150px;
    height:  180px;
    border: 1px solid gray;
    padding-top: 80px;
    margin: 10px 10px;
    text-align:left;
  }
  .purchase_product:hover {
    background-color: silver;
    cursor: pointer;
  }

</style>

<div>

  <h1 class="text-center mb-4">나의 구매내역</h1>
  
  <div class="wrap wrap_9">
    <div id="purchase_list" class="purchase_list"></div>  
  </div>
  
</div>

<script>

  // 전역 변수
  var page = 1;
  var totalPage = 0;
  
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
        buyerNo = resData.buyerNo;
        $.each(resData.purchaseList, (i, pp) => {
          let str = '<div class="purchase_product" data-product_no="' + pp.productNo + '">';
          str += '<div>상품명: ' + pp.productName + '</div>';
          if(pp.buyerNo === null) {
            str += '<div>탈퇴한 판매자</div>';
          } else {
            str += '<div>판매자: ' + pp.buyerNo + '</div>';
          }
          str += '<div>등록일: ' + pp.productCreatedAt + '</div>';
          str += '<button type="button" class="btn_review" id="btn' + pp.productNo + '">리뷰작성</button>';
          str += '</div>';
          $('#purchase_list').append(str);
        })
      }
    })
  }
  
  fnGetPurchaseList();
  
  /*
  fnReview();
  
  const fnReview = () => {
	  $('.btn_review').on('click', () => {
		  
		  $(ev.target).prop('id')
	  })
  }
  */

</script>

<%@ include file="../layout/footer.jsp" %>