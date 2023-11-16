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
			data: 'userNo=' + ${sessionScope.user.userNo},
			// 응답
			dataType: 'json',
			success : (resData)  => {
				console.log(resData);
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

  const fnproductDetail = () => {
      $(document).on('click', '.interest', function(){
        location.href = '${contextPath}/product/detail.do?productNo=' + $(this).data('productno');
      })
    }

</script>

<%@ include file="../layout/footer.jsp" %>