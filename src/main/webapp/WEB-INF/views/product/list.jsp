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

<style>

</style>

<h2 class="ProductNewstyle">
   기본정보
  <span>&nbsp;*필수항목</span>
</h2>
    <br> 
  <form method="post" action="${contextPath}/product/add.do" enctype="multipart/form-data">
    
    <div class="attached_list mt-2" id="attached_list"></div>
    <div class="mt-3">
      <label for="files" class="form-label">첨부</label>
      <input type="file" name="files" id="files" class="form-control" accept="image/*" onchange="setThumbnail(event);" multiple/>
      <div id="image_container"></div>
    </div>
    <div>
      <label for="name" class="form-label">판매자</label>
      <input type="text" name="sellerDto" id="sellerDto" class="form-control" value="${sessionScope.user.name}" readonly>
    </div>
    <br>
    <div>
      <label for="name" class="form-label">상품명</label>
      <input type="text" name="productName" id="productName" class="form-control">
    </div>
    <br>
    <div>카테고리
      <select name="categoryId">
        <option value="select" selected="selected">선택</option>
        <option value="1">가전제품</option>
        <option value="2">잡화</option>
        <option value="3">식품</option>
      </select>
    </div>
    <br>
    <div>
      <label for="productPrice" class="form-label">가격</label>
      <input type="text" name="productPrice" id="productPrice" class="form-control" placeholder="가격을 입력해 주세요. (원)">
    </div>
    <br>
    <div>제품상태<br>
      <input type="radio" value="newProduct" id="newProduct" name="state">
      <label for="newProduct"> 새 상품(미사용)</label><br>
      <input type="radio" value="goodProduct" id="goodProduct" name="state">
      <label for="goodProduct"> 사용감 적음</label><br>
      <input type="radio" value="badProduct" id="badProduct" name="state">
      <label for="badProduct"> 사용감 많음</label><br>
      <input type="radio" value="breakProduct" id="breakProduct" name="state">
      <label for="breakProduct"> 고장/파손 상품</label>
    </div>
    <div>
    <br>
      <label for="name" class="form-labelST">거래지역</label>
      <br>
      <input type="text" name="tradeAddress" id="tradeAddress" class="form_tradeAddress">
    </div>
    <div>
    <br>
      <label for="contents" class="form-labelCT">설명</label>
      <textarea rows="5" name="productInfo" id="productInfo" class="form-control"></textarea>
    </div>
    <div class="d-grid gap-2 col-6 mx-auto">
      <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
      <button type="submit" class="btn btn-primary" style="margin: 32px;">등록하기</button>
    </div>
  </form>
  
  <div id="file_list"></div>
   
<script>

const fnFileCheck = () => {
    $('#files').change((ev) => {
        for (var image of event.target.files) {
          var reader = new FileReader();

          reader.onload = function(event) {
            var img = document.createElement("img");
            img.setAttribute("src", event.target.result);
            img.setAttribute("width", "200px");
            document.querySelector("div#image_container").appendChild(img);
          };

          console.log(image);
          reader.readAsDataURL(image);
        }
      $('#attached_list').empty();
      let maxSize = 1024 * 1024 * 100;
      let maxSizePerFile = 1024 * 1024 * 10;
      let totalSize = 0;
      let files = ev.target.files;
      for(let i = 0; i < files.length; i++){
        totalSize += files[i].size;
        if(files[i].size > maxSizePerFile){
          alert('각 첨부파일의 최대 크기는 10MB입니다.');
          $(ev.target).val('');
          $('#attached_list').empty();
          return;
        }
      }
      if(totalSize > maxSize){
        alert('전체 첨부파일의 최대 크기는 100MB입니다.');
        $(ev.target).val('');
        $('#attached_list').empty();
        return;
      }
    })
  }
  
  const fnSubmit = () => {
     $('#frm_upload_add').submit((ev) => {
        if($('#title').val() === ''){
           alert('제목은 반드시 입력해야 합니다.');
           $('#title').focus();
           ev.preventDefault();
           return;
        }
     })
  }
  
  
  fnFileCheck();
  fnSubmit();
  
</script>

<%@ include file="../layout/footer.jsp" %>