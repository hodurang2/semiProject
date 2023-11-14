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


<div class="admin">
  <div>
    <a href="${contextPath}/notice/write.form">
      <button type="button" class="btn btn-primary">새글작성</button>
    </a>
  </div>
  
<hr>
 
  <div>
    <table border="1" class="table">
      <thead>
        <tr>
          <td>글번호</td>
          <td>제목</td>
          <td>작성자</td>
          <td>작성일자</td>
          <td>최신상태</td>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${noticeList}" var="n" varStatus="vx">
          <tr>
            <td>${n.noticeNo}</td>
            <td><a href="${contextPath}/notice/detail.do?noticeNo=${n.noticeNo}">${n.title}</a></td>
            <td>관리자</td>
            <td>
              <fmt:formatDate pattern="yyyy-MM-dd" value="${n.createdAt}"/>
            </td>
            <td>
              <c:if test="${noticeHour[vx.index] != null}">
                  <div>${noticeHour[vx.index]}시간 전</div>
              </c:if>
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