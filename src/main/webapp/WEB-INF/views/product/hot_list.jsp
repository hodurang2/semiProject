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
  .producthot_list {
    margin: 5px auto;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    align-items: center;
   }
   
  .productHot {
    width: 200px;
    height:  230px;
    border: 1px solid gray;
    padding-top: 80px;
    margin: 10px 10px;
    
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


<h3>인기 조회수</h3>


<div class="wrap wrap_9">
  <div id="producthot_list" class="producthot_list"></div>
</div>

<script>

  $(() => {
	  fnGetProductHotList();
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
        $.each(resData.productHotList, (i, producthot) => {
          let str = '<div class="productHot" data-productNo="' + producthot.productNo + '">';
          str += '<div>' + producthot.productName + '</div>';    
          str += '<div>' + producthot.sellerNo + '</div>';
          str += '<div>' + producthot.productCreatedAt + '</div>';
          str += '</div>';
          $('#producthot_list').append(str);
        })
      }
    })  
  
  }
  
  </script>





<%@ include file="../layout/footer.jsp" %>