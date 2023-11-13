<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="상품판매등록" name="title"/>
</jsp:include>

<div>

  <h1 style="text-align: center;">기본정보
    <span>*필수항목</span>
  </h1>
  
  <form method="post" action="${contextPath}/product/add.do" enctype="multipart/form-data">
    <div>
      <label for="title" class="form-label">상품이미지</label>
      <input type="text" name="title" id="title" class="form-control">
      <span>*</span>
      <small>
      "("
      "0"
      "/10)"
      </small>
    </div>
    <div class ="ProductNewstyle__Content-sc-7fge4a-7 nqDMw">
      <li>
      <label for="files" class="form-label">이미지 등록</label>
      <input type="file" name="files" id="files" class="form-control" multiple>
      </li>
    </div>
    <div>
      <label for="name" class="form-label">작성자</label>
      <input type="text" id="name" class="form-control-plaintext" value="${sessionScope.user.name}" readonly>
    </div>
    <div>
      <label for="contents" class="form-label">내용</label>
      <textarea rows="3" name="contents" id="contents" class="form-control"></textarea>
    </div>
    <div class="d-grid gap-2 col-6 mx-auto">
      <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
      <button type="submit" class="btn btn-primary" style="margin: 32px;">작성완료</button>
    </div>
  </form>
  
  <div id="file_list"></div>
  
</div>
  
<script>

  const fnFileCheck = () => {
    $('#files').change((ev) => {
      $('#file_list').empty();
      let maxSize = 1024 * 1024 * 100;
      let maxSizePerFile = 1024 * 1024 * 10;
      let totalSize = 0;
      let files = ev.target.files;
      for(let i = 0; i < files.length; i++){
        totalSize += files[i].size;
        if(files[i].size > maxSizePerFile){
          alert('각 첨부파일의 최대 크기는 10MB입니다.');
          $(ev.target).val('');
          $('#file_list').empty();
          return;
        }
        $('#file_list').append('<div>' + files[i].name + '</div>');
      }
      if(totalSize > maxSize){
        alert('전체 첨부파일의 최대 크기는 100MB입니다.');
        $(ev.target).val('');
        $('#file_list').empty();
        return;
      }
    })
  }
  
  fnFileCheck();
  
</script>
  
<%@ include file="../layout/footer.jsp" %>