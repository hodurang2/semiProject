<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<jsp:include page="../layout/header.jsp">
  <jsp:param value="인기게시판" name="title"/>
</jsp:include>


<link rel="stylesheet" href="css/list.css">


<h3>인기 조회수</h3>


<div class="wrap wrap_9">
  <div id="product_list" class="product_list"></div>
</div>

<script>

  $(() => {
	  fnGetProductHotList();
	  fnproductDetail();
  })

  // 전역 변수
  var page = 1;
  var totalPage = 0;
  
  const fnGetProductHotList = () =>{
    $.ajax({
      type:'get',
      url : '${contextPath}/product/getHotList.do',
      data: 'page=' + page,
      // 응답
      dataType: 'json',
      success : (resData)  => {
    	console.log(resData);
        $.each(resData.productHotList, (i, product) => {
          let str = '<div class="product" data-productNo="' + product.productNo + '">';
          str += '<div>' + product.productName + '</div>';    
          str += '<div>' + product.sellerNo + '</div>';
          str += '<div>' + product.productCreatedAt + '</div>';
          str += '</div>';
          $('#product_list').append(str);
        })
      }
    })  
  
  }

  const fnproductDetail = () => {
	    $(document).on('click', '.product', function(){
	      location.href = '${contextPath}/product/detail.do?productNo=' + $(this).data('productno');
	    })
	  }
  </script>





<%@ include file="../layout/footer.jsp" %>