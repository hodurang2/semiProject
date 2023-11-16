<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="dt" value="<%=System.currentTimeMillis() %>"/>

<jsp:include page="./layout/header.jsp">
  <jsp:param value="공지 사항" name="title"/>
</jsp:include>


<div class="admin">
  
<hr>
 
  <div>
    <table border="1" class="table">
      <thead>
        <tr>
          <td>알람번호</td>
          <td>제목</td>
          <td>작성일자</td>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${alarmList}" var="a" varStatus="vx">
          <tr>
            <td>${i.inquiryNo}</td>
            <td><a href="${contextPath}/inquiry/detail.do?inquiryNo=${a.inquiryNo}">${i.inquiryTitle}</a></td>
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

<%@ include file="./layout/footer.jsp"%>