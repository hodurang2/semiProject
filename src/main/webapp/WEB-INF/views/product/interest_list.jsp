<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="업로드게시판" name="title"/>
</jsp:include>

<div class="wrap wrap_9">
 
  <h3>관심지역 리스트 게시판</h3>

  
  <div id="interest_list" class="interest_list"></div>

</div>

<script>

//전역 변수
var page = 1;
var totalPage = 0;

	const fnGetInterestList = () =>{
		$.ajax({
			type:'get',
			url : '${contextPath}/product/getProductList.do',
			data: 'page=' + page,
			// 응답
			dataType: 'json',
			success : (resData)  => {
				totalPage = resData.totalPage;
				
				$.each(resData.productList, (i, product) => {
					let str = '<div class="product" data-productNo="' + product.productNo + '">';
					str += '<div>' + product.productName + '</div>';		
					if(product.UserDto == null){
						str += '<div>' + product.sellerNo + '</div>';
					} else {
						str += '<div>' + product.sellerNo + '</div>';
					} 
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