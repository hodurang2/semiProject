<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="상세리뷰보기" name="title"/>
</jsp:include>

<style>
.review_info td {
  width: 200px;
  height: 30px;
}
#modify_review {
  margin-top: 30px;
}
</style>

<div class="rev">
  
  <form id="frm_modify_review" method="get">
    <input type="hidden" id="productNo" name="productNo" value="${purchaseProduct.productNo}"/>
  </form>
  <h1 class="text-center mb-4">${purchaseProduct.productName} 구매 후기</h1>
  <div>
    <table class="review_info">
      <tr>
        <td>판매자번호</td>
        <td>${purchaseProduct.productNo}</td>
      </tr>
      <tr>
        <td>상품명</td>
        <td>${purchaseProduct.productName}</td>
      </tr>
      <tr>
        <td>상품설명</td>
        <td>${purchaseProduct.productInfo}</td>
      </tr>
      <tr>
        <td>상품가격</td>
        <td>${purchaseProduct.productPrice}</td>
      </tr>
      
      <tr>
        <td>별점</td>
        <td>${purchaseProduct.reviewScore}</td>
      </tr>
      <tr>
        <td>후기내용</td>
        <td>${purchaseProduct.reviewContents}</td>
      </tr>
      <tr>
        <td>후기작성일</td>
        <td>${purchaseProduct.createdAt}</td>
      </tr>
    </table>
    
  </div>  
  <div class="cmd">
    <button type="button" class="modify_review">리뷰 수정하러가기</button>
  </div>
  <div class="pl">
    <button type="button" id="btn_purchase_list">구매목록보기</button>
  </div>
  
</div>

<script>

  $(() => {
  	fnModifyReview();
    fnBack();
  })
  
  var productNo;
  
  const fnModifyReview = () => {
    $(document).on('click', '.modify_review', () => {
      productNo = $('#productNo').val();
      location.href = '${contextPath}/mypage/writeReview.form?productNo=' + productNo;
    })
  }
  const fnBack = () => {
	    $(document).on('click', '#btn_purchase_list', () => {
	      location.href='${contextPath}/mypage/purchaseList.do';
	    })
	  }
  
</script>

<%@ include file="../layout/footer.jsp" %>