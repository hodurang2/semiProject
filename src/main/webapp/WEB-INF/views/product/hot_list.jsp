<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />


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

<jsp:include page="../layout/header.jsp">
  <jsp:param value="인기게시판" name="title"/>
</jsp:include>

<h1>인기 조회수</h1>

<c:if test="${not empty productHotList}">
  <table>
    <thead>
      <tr>
        <th>제품명</th>
        <th>가격</th>
        <th>생성일</th>
        <th>조회수</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="product" items="${productHotList}">
        <tr>
          <td>${product.productName}</td>
          <td>${product.productPrice}</td>
          <td>${product.productCreatedAt}</td>
          <td>${product.hit}</td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</c:if>



<%@ include file="../layout/footer.jsp" %>