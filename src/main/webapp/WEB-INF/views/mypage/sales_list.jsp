<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../mypage/info.jsp"></jsp:include>

<div>

  <h1 class="text-center mb-4">나의 판매내역</h1>
  <div>
    <a href="${contextPath}/product/write.form">
      <button type="button" class="btn btn-primary">판매하기</button>
    </a>
  </div>
  
  <div id="sales_list" class="sales_list"></div>
  
</div>

<script>

  // 전역 변수
  var page = 1;
  var totalPage = 0;
  var sellerNo = 0;
  
  const fnGetSalesList = () => {
    $.ajax({
      // 요청
      type: 'get',
      url: '${contextPath}/mypage/getSalesList.do',
      data: 'page=' + page + '&sellerNo=' + sellerNo,
      // 응답
      dataType: 'json',
      success: (resData) => {   // resData = {"uploadList": [], "totalPage" : 10}
        totalPage = resData.totalPage;
        sellerNo = resData.sellerNo;
        $.each(resData.salesList, (i, sales) => {
          let str = '<div class="sales" data-product_no="' + sales.productNo + '">';
          str += '<div>상품명: ' + sales.productName + '</div>';
          if(sales.sellerDto === null) {
            str += '<div>탈퇴한 작성자</div>';
          } else {
          str += '<div>작성자: ' + sales.sellerDto.name + '</div>';
          }
          str += '<div>생성: ' + sales.productCreatedAt + '</div>';
          str += '</div>';
          $('#sales_list').append(str);
        })
      }
    })
  }
  
  fnGetSalesList();

</script>



<%@ include file="../layout/footer.jsp" %>