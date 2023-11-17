<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../mypage/info.jsp"></jsp:include>

<style>

  .sales_list {
    margin: 5px auto;
    display: flex;
    flex-wrap: wrap;
   }
  .sales_product {
    width: 200px;
    height:  230px;
    border: 1px solid gray;
    padding-top: 80px;
    margin: 10px 10px;
  }
  .sales_product:hover {
    background-color: silver;
    cursor: pointer;
  }
  h1 {
    margin: 30px 0;
  }

</style>

<div>

  <h1 class="text-center mb-4">나의 판매내역</h1>
  <div>
    <a href="${contextPath}/product/write.form">
      <button type="button" class="btn btn-primary">판매하기</button>
    </a>
  </div>
  
  <div class="wrap wrap_9">
    <div id="sales_list" class="sales_list"></div>  
  </div>
  
</div>

<script>

  $(() => {
	  fnGetSalesList();
	  //fnDetail();
  })

  // 전역 변수
  var page = 1;
  var totalPage = 0;
  var productNo;
  
  let sta = '';
  
  const fnGetSalesList = () => {
    $.ajax({
      // 요청
      type: 'get',
      url: '${contextPath}/mypage/getSalesList.do',
      data: 'page=' + page + '&sellerNo=${sessionScope.user.userNo}',
      // 응답
      dataType: 'json',
      success: (resData) => {   // resData = {"sellerNo": 1, "salesList": [], "totalPage" : 10}
        totalPage = resData.totalPage;
        sellerNo = resData.sellerNo;
        $.each(resData.salesList, (i, sp) => {
          let str = '<div class="sales_product" data-product_no="' + sp.productNo + '">';
          str += '<div>상품명: ' + sp.productName + '</div>';
          if(sp.sellerNo === null) {
            str += '<div>탈퇴한 판매자</div>';
          } else {
        	  str += '<div>판매자: ' + sp.sellerNo + '</div>';
          }
          switch(sp.state) {
            case 0: sta = '판매중'; break;
            case 1: sta = '예약중'; break;
            case 2: sta = '판매완료'; break;
            default: sta = '삭제'; break;
          }
          str += '<div>판매상태: ' + sta + '</div>';
          str += '<div>생성: ' + sp.productCreatedAt + '</div>';
          str += '</div>';
          $('#sales_list').append(str);
        })
      }
    })
  }
  
  /*
  const fnDetail = () => {
    $(document).on('click', '.sales_product', function(ev) {
      productNo = $(this).data('productNo');
      console.log(productNo);
      location.href = '${contextPath}/product/detail.do?productNo=' + productNo;
    })
  }
  */
  


</script>



<%@ include file="../layout/footer.jsp" %>