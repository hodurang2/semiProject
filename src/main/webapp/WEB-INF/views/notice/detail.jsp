<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="dt" value="<%=System.currentTimeMillis() %>"/>

<jsp:include page="../layout/header.jsp">
  <jsp:param value="공지 상세" name="title"/>
</jsp:include>
<script src="${contextPath}/resources/js/.js?dt=${dt}"></script>

  <div>제목 : ${title}</div>
  <div>작성자 : 관리자</div>
  <div>작성일자 : <fmt:formatDate pattern="yyyy-MM-dd hh:MM:ss" value="${createdAt}"/></div>
  
<%@ include file="../layout/footer.jsp"%>