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


<script>
//게시판 목록 페이지로 이동하게 하는 함수
function list(page){
    console.log("페이지를 이동합니다.");
    location.href="list.do?curPage="+page;
};
 
</script>

<div class="product_list" id="product_list">
  <div class="data-upload">
    <!-- 갤러리형 핫 갤러리~ --> 
 <c:forEach var = "row" items = "${map.list}"> <!-- 컨트롤러에서 map안에 list를 넣었기 때문에 이렇게 받는다. -->
    <tr>
        <td>${row.rk}</td>                <!-- 게시글 순위 -->
        <td>${row.member_bno}</td>        <!-- 글번호 -->
        <!-- 클릭하면 컨트롤러의 view.do로 이동하고, 게시물번호, 페이지 번호, 검색옵션, 키워드를 같이 넘긴다 -->
        <td>
        <a href="best_board_view.do?member_bno=${row.member_bno}">${row.title}</a>
<c:if test="${row.rcnt > 0}"> 
   <span style="color:red;">( ${row.rcnt} )</span> 
</c:if>  
</td>
        <td>${row.user_id}</td>    <!-- 작성자의 이름 -->
        <td>${row.content}</td>    <!-- 글의내용 -->
        <td>${row.reg_date}</td>    <!-- 날짜의 출력형식을 변경함 -->
        <td>${row.viewcnt}</td>    <!-- 조회수 -->
        <td>${row.recommend}</td>    <!-- 추천수 -->
    </tr>
    </c:forEach>
  </div>
</div>








<%@ include file="../layout/footer.jsp" %>