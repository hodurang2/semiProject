<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="메인" name="title"/>
</jsp:include>

<style>
    ul {
      list-style: none;
      padding: 0;
      margin: 0;
  }
  
  li {
      display: inline;
      margin-right: 10px; /* Adjust the margin as needed */
  }
  
  .btn_five{
    text-align: center;
    font-size: 120px;
  }
  

  
</style>



  <br>
<div>
  <ul class="btn_five">
    <li><button type="button" class="btn btn-outline-primary"><a href="${contextPath}/product/list.do">최신</a></button></li>
    <li><button type="button" class="btn btn-outline-primary"><a href="${contextPath}/product/hot_list.do">인기</a></button></li>
    <li><button type="button" class="btn btn-outline-primary"><a href="${contextPath}/product/interest_list.do">관심지역</a></button></li>
    <li><button type="button" class="btn btn-outline-primary"><a href="${contextPath}/product/myarea_list.do">내 주변 매물</a></button></li> 
    <li><button type="button" class="btn btn-outline-primary"><a href="${contextPath}/product/latest_list.do">최근에 본 상품</a></button></li>
  </ul>
</div>


<br><hr><br>
<h4>전체상품보기</h3>

<div class="wrap wrap_9">
  <div id="product_list" class="product_list"></div>
</div>

<script>

$(() => {
	fnGetProductList();
	fnproductDetail();
	fnScroll();
})

  // 전역 변수
  var page = 1;
  var totalPage = 0;

  const fnGetProductList = () =>{
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

  const fnScroll = () => {
    
    var timerId;  // 최초 undefined 상태
    
    $(window).on('scroll', () => {
      
      if(timerId){  // timerId가 undefined이면 false로 인식, timerId가 값을 가지면 true로 인식
        clearTimeout(timerId);
      }
      
      timerId = setTimeout(() => {  // setTimeout 실행 전에는 timerId가 undefined 상태, setTimeout이 한 번이라도 동작하면 timerId가 값을 가짐
        
        let scrollTop = $(window).scrollTop();     // 스크롤바 위치(스크롤 된 길이)
        let windowHeight = $(window).height();     // 화면 전체 크기
        let documentHeight = $(document).height(); // 문서 전체 크기
        
        if((scrollTop + windowHeight + 100) >= documentHeight) {  // 스크롤이 바닥에 닿기 100px 전에 true가 됨
          if(page > totalPage){  // 마지막 페이지를 보여준 이후에 true가 됨
            return;              // 마지막 페이지를 보여준 이후에는 아래 코드를 수행하지 말 것 
          }
          page++;
          fnGetproductList();
        }
        
      }, 200);  // 200밀리초(0.2초) 후 동작(시간은 임의로 조정 가능함)
      
    })
    
  }
  
  </script>

<%@ include file="footer.jsp" %>