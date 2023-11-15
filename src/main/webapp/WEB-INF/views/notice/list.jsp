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
  .wrap {
    max-width: 1170px;
    position: relative;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
  }
  .support_left_wrap {
    width: 245px;
    padding-right: 45px;
  }
  .support_right_wrap {
    width: 1000px;
  }
  .left_menu ul {
    border-bottom: 1px solid #EAEAEA;
  }
  .left_menu ul li {
    display: block;
    border: 1px solid #F4F4F4;
    border-bottom: none;
    padding: 0 15px;
  }
  a {
    text-decoration: none;
    color: inherit;
  }
  ul {
    list-style: none;
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
  .notice_title {
    margin-bottom: 25px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 22px;
    margin-top: 10px;
  }
  
  .support_right_wrap table {
    border-top: 1.5px black solid;
    border-left: 0;
    border-right: 0;
    border-collapse: collapse;
  }
  
</style>

  <div class="support_title">고객센터</div>
  
<div class="wrap">
  <div class="support_left_wrap">
    <div class="left_menu">
      <ul class="btn_support">
        <li class="on"><a href="${contextPath}/notice/list.do"><span>공지사항</span></a></li>
        <li class="off"><a href="${contextPath}/inquiry/list.do"><span>1:1문의</span></a></li>
      </ul>
    </div>
  </div>   

<div class="admin">
  <div>
    <a href="${contextPath}/notice/write.form">
      <button type="button" class="btn btn-primary">새글작성</button>
    </a>
  </div>
  
 
    <div class="support_right_wrap">
      <div class="notice_title">공지사항</div>
      <table border="1" class="table">
        <thead>
          <tr>
            <td>글번호</td>
            <td>제목</td>
            <td>작성일자</td>
            <td>최신상태</td>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${noticeList}" var="n" varStatus="vx">
            <tr>
              <td>${num[vx.index]}</td>
              <td><a href="${contextPath}/notice/detail.do?noticeNo=${n.noticeNo}">${n.title}</a></td>
              <td>
                <fmt:formatDate pattern="yyyy-MM-dd" value="${n.createdAt}"/>
              </td>
              <td>
                <c:choose> 
                  <c:when test="${noticeHour[vx.index] != null && noticeHour[vx.index] < 24 && noticeHour[vx.index] > 0}">
                    <div>${noticeHour[vx.index]}시간 전</div>
                  </c:when> 
                  <c:when test="${noticeHour[vx.index] == 0}">
                    <div>${noticeMinute[vx.index]}분 전</div>
                  </c:when> 
                </c:choose>
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
</div>
<script>
	
</script>

<%@ include file="../layout/footer.jsp"%>