<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="dt" value="<%=System.currentTimeMillis() %>"/>

<jsp:include page="../layout/header.jsp">
  <jsp:param value="공지 편집" name="title"/>
</jsp:include>
<script src="${contextPath}/resources/js/.js?dt=${dt}"></script>

<style>
  .ck.ck-editor {
    max-width: 1000px;
  }
  .ck-editor__editable {
    min-height: 400px;
  }
  .ck-content {
    color: gray;
  }
</style>


<div>

  <form id="frm_notice_add" method="post" action="${contextPath}/notice/modifyNotice.do">
    
     <h1 style="text-align: center;">${notice.noticeNo}번 공지 편집</h1>
    
    <div>
      <label for="title">제목</label>
      <input type="text" name="title" id="title" class="form-control" value="${notice.title}">
    </div>
    
    <div>
      <label for="contents">내용</label>
      <textarea name="contents" id="contents" style="display: none;"></textarea>
      <div id="toolbar-container"></div>
      <div id="ckeditor">${notice.contents}</div>
    </div>
    
    <div>
      <input type="hidden" name="blogNo" value="${notice.noticeNo}">
      <button class="btn btn-primary col-12" type="submit">수정완료</button>
    </div>
    
  </form>

</div>


<script>

  const fnCkeditor = () => {
    DecoupledEditor
      .create(document.getElementById('ckeditor'), {
        ckfinder: {
          // 이미지 업로드 경로
          uploadUrl: '${contextPath}/Notice/imageUpload.do'         
        }
      })
      .then(editor => {
        const toolbarContainer = document.getElementById('toolbar-container');
        toolbarContainer.appendChild(editor.ui.view.toolbar.element);
      })
      .catch(error => {
        console.error(error);
      });
  }
  
  const fnNoticeModify = () => {
    $('#frm_notice_modify').submit(() => {
      $('#contents').val($('#ckeditor').html());
    })
  }
  
  fnCkeditor();
  fnNoticeModify();
  
</script>
<%@ include file="../layout/footer.jsp"%>