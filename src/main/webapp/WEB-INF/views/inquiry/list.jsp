<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="dt" value="<%=System.currentTimeMillis() %>"/>

<jsp:include page="../layout/header.jsp">
  <jsp:param value="공지 사항" name="title"/>
</jsp:include>
<style>
  .support_title {
    text-align: center;
    font-size: 1.75rem;
    font-weight: 500;
    color: #333;
    margin-bottom: 20px;
  }
  .wrap2 {
    max-width: 1170px;
    position: relative;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
  }
  .support_left_wrap {
    width: 245px;
    padding-right: 50px;
  }
  .support_right_wrap {
    width: 1000px;
  }
  .left_menu ul li:last-child {
    border-bottom: 1px solid #EAEAEA;
     
  }
  .left_menu ul li {
    display: block;
    border: 1px solid #F4F4F4;
    border-bottom: none;
    
  }
  a {
    text-decoration: none;
    color: inherit;
  }
  ul {
    list-style: none;
  }
  .inquiry_head {
    display: flex;
  }
  .btn_write{
    flex-grow: 1;
  }
  .btn_support {
    width: 168px;
  }
  .btn_support li{
    width: 168px;
    height: 56px;
    text-align: left;
    padding-left: 10px;
    line-height: 56px;
  }
  .on {
    border: 1px solid #222;
    background-color: #222;
  }
  .on span {
    color: #fff;
   }
  .support_right_wrap thead tr {
    background-color: #FCFCFC;
    color: #555;
  }
  .inquiry_title {
    margin-bottom: 25px;
    align-items: center;
    justify-content: space-between;
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 22px;
    margin-top: 10px;
    flex-grow: 1;
  }
  
  .support_right_wrap table {
    border-top: 1.5px black solid;
    border-left: 0;
    border-right: 0;
    border-collapse: collapse;
  }
  
</style>

  <div class="support_title">고객센터</div>
  
<div class="wrap2">
  <div class="support_left_wrap">
    <div class="left_menu">
      <ul class="btn_support">
        <li class="off"><a href="${contextPath}/notice/list.do"><span>공지사항</span></a></li>
        <li class="on"><a href="${contextPath}/inquiry/list.do"><span>1:1문의</span></a></li>
      </ul>
    </div>  
   </div>
   <div class="support_right_wrap">
      <div class="inquiry_head">
          <div class="inquiry_title">1:1문의</div>
              <div>
                <a href="${contextPath}/inquiry/write.form">
                  <button type="button" class="btn btn-dark btn_write">새글작성</button>
                </a>
              </div>
          </div>
        <table border="1" class="table">
          <thead>
            <tr>
              <td>글번호</td>
              <td>제목</td>
              <td>작성자</td>
              <td>작성일자</td>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${inquiryList}" var="i" varStatus="vx">
              <tr>
                <td>${i.inquiryNo}</td>
                <td><a href="${contextPath}/inquiry/detail.do?inquiryNo=${i.inquiryNo}">${i.inquiryTitle}</a></td>
                <td>${i.userDto.email}</td>
                <td>
                  <fmt:formatDate pattern="yyyy-MM-dd" value="${i.inquiryCreatedAt}"/>
                </td>
              </tr>
            </c:forEach>
          </tbody>
          <tfoot> 
            <tr>
              <td colspan="5">${paging}</td>
            </tr>
          </tfoot>
        </table>    
      </div>
</div> 
<script>
  
</script>

<%@ include file="../layout/footer.jsp"%>