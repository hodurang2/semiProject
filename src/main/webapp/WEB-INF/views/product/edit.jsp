<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="${product.productName} 게시글수정" name="title"/>
</jsp:include>

<div class="wrap wrap_9">


<h1 class="title">수정</h1>

   <div>
    <form id ="frm_product_edit" method="post" action="${contextPath}/product/modify.do">
      <div>작성자:   ${sessionScope.user.name}</div>
      <div>상품명:   <input type="text" name="productName" value="${product.productName}"></div>
      <div>카테고리: ${product.categoryDto.categoryId}</div>
      <div>상품가격: <input type="text" name="productPrice" value="${product.productPrice}"></div>
      <div>거래지역: <input type="text" name="tradeAddress" value="${product.tradeAddress}"></div>
      <div>설명</div>
      <div><textarea name="productInfo" rows="5">${product.productInfo}</textarea></div>
      <input type="hidden" name="ProductNo"     value="${product.productNo}">
      <c:if test="${sessionScope.user.userNo == product.sellerNo}">
        <button type="submit" id="btn_modify" class="btn btn-warning btn-sm">수정</button>
      </c:if>
      <div>작성일:   ${product.productCreatedAt}</div>
      <div>수정일:   ${product.productModifiedAt}</div>
    </form>
   </div>

</div>

<script>

  
  
  const fnproductModify = () => {
    $('#frm_product_edit').submit((ev) => {
      if($('#productName').val() === ''){
        alert('제목은 반드시 입력해야 합니다.');
        $('#productName').focus();
        ev.preventDefault();
        return;
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
  
  fnproductModify();
  fnModifyResult();
  
</script>

<%@ include file="../layout/footer.jsp" %>