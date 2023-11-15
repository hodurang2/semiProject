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
  .section
  {
    margin: 0px;
    padding: 0px;
    border: 0px;
    font: inherit;
    vertical-align: baseline;
  }
  .fGSdXi {
    height: 100px;
    color: rgb(25, 25, 25);
    font-size: 26px;
    font-weight: 400;
    display: flex;
    -webkit-box-align: center;
    align-items: center;
    border-bottom: 2px solid rgb(25, 25, 25);
  }
  .hcyuoc {
    padding-top: 0.5rem;
  }
  
  ul {
    list-style: none;
  }
  .iZffvT {
    width: 100%;
    display: flex;
    padding: 2rem 0px;
    border-bottom: 1px solid rgb(246, 246, 246);
  }
  .cosfJW {
    width: 10.5rem;
    font-size: 18px;
    font-weight: 400;
    color: rgb(25, 25, 25);
  }
  .cosfJW > span {
    color: rgb(216, 12, 24);
  }
  .cosfJW > small {
    color: rgb(178, 178, 178);
    font-size: 16px;
    font-weight: 400;
    line-height: 20px;
    margin-left: 0.25rem;
  }
  .nqDMw {
    flex: 1 1 0%;
    position: relative;
  }
  .btn-primary {
    height: 3.5rem;
    width: 10rem;
    color: rgb(255, 255, 255); 
    font-size: 20px;
    font-weight: 700;
    border-radius: 2px;
    background: rgb(50, 205, 50);
    display: flex;
    -webkit-box-align: center;
    align-items: center;
    -webkit-box-pack: center;
    justify-content: center;
  }
  .btn_productImage {
    border: 1px solid white;;
  }

  
</style>

<section class="ProductNewstyle_Basic-sc-7fge4a-3 bsIKMq">
<h2 class="ProductNewstyle_SectionTitle-sc-7fge4a-1 fGSdXi">
   기본정보
  <span>&nbsp*필수항목</span>
</h2>
<ul class="ProductNewstyle_Groups-sc-7fge4a-4 hcyuoc">
  <li class="ProductNewstyle_Groups-sc-7fge4a-5 iZffvT">
    <div class="ProductNewstyle_Label-sc-7fge4a-6 cosfJW">
      상품이미지<small>(0/12)</small>
    </div>
    <div class="ProductNewstyle_Content-sc-7fge4a-7 nqDMw">
      <ul class="sc-FQuPU eUN1GD">
        <li class="sc-iuDHTM bXMOKO">
         <button type="button" class="btn_productImage"><img alt="이미지등록" src="../resources/image/productImage.png" width="200"></button>
        </li>
      </ul>
    </div>
   </li>
</ul>
  <form method="post" action="${contextPath}/product/add.do" enctype="multipart/form-data">
    <div>
      <label for="name" class="form-label">상품명</label>
      <input type="text" name="productName" id="productName" class="form-control">
    </div>
    <div>${SessionScope.categoryList.name}</div>
    <div>
      <select name="categoryId">
        <option value="select" name="categoryId" selected="selected">선택</option>
        <option value="1">가전제품</option>
        <option value="2">잡화</option>
        <option value="3">식품</option>
      </select>
    </div>
    <div>
      <label for="productPrice" class="form-label">가격</label>
      <input type="text" name="productPrice" id="productPrice" class="form-control" placeholder="가격을 입력해 주세요."> 원
    </div>
    <div>
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
      <label for="name" class="form-labelST">거래지역</label>
      <input type="text" name="tradeAddress" id="tradeAddress" class="form_tradeAddress">
    </div>
    <div>
      <label for="contents" class="form-labelCT">설명</label>
      <textarea rows="5" name="productInfo" id="productInfo" class="form-control"></textarea>
    </div>
    <div class="d-grid gap-2 col-6 mx-auto">
      <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
      <button type="submit" class="btn btn-primary" style="margin: 32px;">등록하기</button>
    </div>
  </form>
  
  <div id="file_list"></div>
  
</section>
  
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