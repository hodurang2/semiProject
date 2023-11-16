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
<style>
  .interest_list {
    margin: 5px auto;
    display: flex;
    flex-wrap: wrap;
   }
  .interest {
    width: 200px;
    height:  230px;
    border: 1px solid gray;
    padding-top: 80px;
    margin: 10px 10px;
    
  }
  .interest:hover {
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

  <h3>관심지역 리스트 게시판</h3>
<div class="wrap wrap_9">
  
  <div id="interest_list" class="interest_list"></div>

</div>

<script>

$(() => {
	
	fnGetInterestList();
	fnproductDetail();
	})

//전역 변수
var page = 1;
var totalPage = 0;

	const fnGetInterestList = () =>{
		$.ajax({
			type:'get',
			url : '${contextPath}/product/getInterestList.do',
			data: {"page": page
    		      ,"userNo": '${sessionScope.user.userNo}'},
			// 응답
			dataType: 'json',
			success : (resData)  => {
				totalPage = resData.totalPage;
				$.each(resData.interestList, (i, interest) => {
					let str = '<div class="interest" data-productNo="' + interest.productNo + '">';
					str += '<div>상품명: ' + interest.productName + '</div>';		
					str += '<div>작성일: ' + interest.productCreatedAt + '</div>';
					str += '<div>거래지역: ' + interest.tradeAddress + '</div>';
					str += '</div>';
					$('#interest_list').append(str);
				}) 
			}
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

  const fnproductDetail = () => {
      $(document).on('click', '.interest', function(){
        location.href = '${contextPath}/product/detail.do?productNo=' + $(this).data('productno');
      })
    }

</script>

<%@ include file="../layout/footer.jsp" %>