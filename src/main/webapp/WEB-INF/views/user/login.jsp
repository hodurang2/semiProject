<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="로그인" name="title"/>
</jsp:include>

<style>

  .title {
    text-align: center;
  }
  
  .btn {
    margin-top: 20px;
    margin-bottom: 20px;
  }

  .wrap_5 {
    width: 500px;
  }
  
  .wrap {
    padding: 10px;
    margin: 0 auto;  
  }
  
  .sub_menu {
    display: flex;
    justify-content: space-between;
  }
  
  .input-box{
    position:relative;
    margin:10px 0;
  }
  
  .input-box > input{
    background:transparent;
    border:none;
    border-bottom: solid 1px #ccc;
    padding:20px 0px 5px 0px;
    font-size:14pt;
    width:100%;
  }
  
  input::placeholder{
    color:transparent;
  }
  
  input:placeholder-shown + label{
    color:#aaa;
    font-size:14pt;
    top:15px;
  }
  
  input:focus + label, label{
    color:#8aa1a1;
    font-size:10pt;
    pointer-events: none;
    position: absolute;
    left:0px;
    top:0px;
    transition: all 0.2s ease ;
    -webkit-transition: all 0.2s ease;
    -moz-transition: all 0.2s ease;
    -o-transition: all 0.2s ease;
  }
  
  input:focus, input:not(:placeholder-shown){
    border-bottom: solid 1px #8aa1a1;
    outline:none;
  }
  
  div, ul, li, ol {
    padding: 0;
    margin: 0;
    position: relative;
    box-sizing: border-box;
  }
  
</style>
  
  <div class="wrap wrap_5">
    <h3 class="title">로그인</h3>
    <form method="post" action="${contextPath}/user/login.do">
      <div class="input-box">      
        <input type="text" name="email" id="email" placeholder="이메일" >
        <label for="email">아이디</label>
      </div>
      <div class="input-box">      
        <input type="password" name="pw" id="pw" placeholder="비밀번호">
        <label for="pw">비밀번호</label>
      </div>
      <div class="d-grid gap-2">
        <input type="hidden" name="referer" value="${referer}">
        <button class="btn btn-outline-success btn-lg" type="submit">로그인</button>
      </div>
    </form>
    <ul class="sub_menu">
      <li><a href="${contextPath}/user/agree.form">회원가입</a>
      <li><a href="${contextPath}/user/find.form">아이디/비밀번호 찾기</a>
    </ul>
    <hr>
    <div style="text-align: center;">
      <a href="${naverLoginURL}">
        <img src="${contextPath}/resources/image/btnW_완성형.png" width="200px">
      </a>
    </div>
  </div>

<%@ include file="../layout/footer.jsp" %>