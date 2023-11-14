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

<style>
  .product_list {
    margin: 5px auto;
    display: flex;
    flex-wrap: wrap;
   }
  .product {
    width: 150px;
    height:  180px;
    border: 1px solid gray;
    padding-top: 80px;
    margin: 10px 10px;
    text-align:left;
  }
  .product:hover {
    background-color: silver;
    cursor: pointer;
  }
  
  #image_box{
    width : 70px;
    height : 70px;
    border: 1px solid gray;
    padding-bottom : 10px;
    margin : 10px 10px;
  }
  
</style>


<div class="hot_list">

  <div class="list">
    <ul>
      <div class="img_hot"><img src="../resources/image/banner_dum.png"></div>
      <li>#{product.productNo}</li>
      <li>#{product.productName}</li>
      <li>#{product.productPrice}</li>
      <li>#{product.productAt}</li>
      <li>#{product.productHit}</li>
    </ul>
  </div>
  
  <c:foreach var="hot" items="${map.hotList}">
    <tr>
      <td><img src="${contextPath}/resources/logo.png" /><a href="hotList.do?productNo=${hot.productNo}"></a></td>
      <td>${hot.productHit}</td>   
      <td>${hot.productNo}</td>
      <td>${hot.productName}</td>
    </tr>
  </c:foreach>

</div>










<%@ include file="../layout/footer.jsp" %>