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


<h2 class="ProductNewstyle">
   기본정보
  <span>&nbsp;*필수항목</span>
</h2>
  <form method="post" action="${contextPath}/product/add.do" enctype="multipart/form-data">
    <div class="ProductNewstyle_Label">
      상품이미지
    </div>
    <!-- 이미지 영역 호버시 툴팁 -->
    <div>
      <a data-toggle="tooltip" title="이미지등록">
        <img id="productImage" width="200px">
      </a>
    </div>
    <br>
    
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

  	
    function loadImg(inputFile,num){
    if(inputFile.files.length == 1){
  
    var reader = new FileReader();
  
    reader.readAsDataURL(inputFile.files[0]);
    reader.onload = function(e){
      $("#productImage").attr("src", e.target.result);
    }
  
    } else {
        $("#productImage").attr("src", nul);
      }
    }
  
  const fnAddAttach = () => {
	  $('#btn_add_productImage').click(() => {
		  // 폼을 FormData 객체로 생성한다.
		  let formData = new FormData();
		  // 첨부된 파일들을 FormData에 추가한다.
		  let files = $('#files').prop('files');
		  $.each(files, (i, file) => {
			  formData.append('files', file);  // 폼에 포함된 파라미터명은 files이다. files는 여러 개의 파일을 가지고 있다.
		  })
		  // 현재 게시글 번호(productNo)를 FormData에 추가한다.
		  formData.append('productNo', '${product.productNo}');
		  // FormData 객체를 보내서 저장한다.
		  $.ajax({
			  // 요청
			  type: 'post',
			  url: '${contextPath}/product/addProduct.do',
			  data: formData,
			  contentType: false,
			  processData: false,
			  // 응답
			  dataType: 'json',
			  success: (resData) => {  // resData = {"attachResult": true}
				  if(resData.attachResult){
					  alert('첨부 파일이 추가되었습니다.');
					  fnAttachList();
				  } else {
					  alert('첨부 파일이 추가되지 않았습니다.');
				  }
			  }
		  })
	  })
  }

  const fnAttachList = () => {
	  $.ajax({
		  // 요청
		  type: 'get',
		  url: '${contextPath}/product/getProductImageList.do',
		  data: 'productNo=${product.productNo}',
		  // 응답
		  dataType: 'json',
		  success: (resData) => {  // resData = {"productImageList": []}
			  $('#productImageList').empty();
		    $.each(resData.productImageList, (i, productImage) => {
		    	let str = '<div>';
		    	str += '<span>' + productImage.imageOriginalname + '</span>';
  		    	str += '<span data-attach_no="' + attach.attachNo + '"><i class="fa-solid fa-xmark ico_remove_attach"></i></span>';
		    	str += '</div>';
		    	$('#attach_list').append(str);
		    })
		  }
	  })
  }
  
  const fnRemoveAttach = () => {
	  $(document).on('click', '.ico_remove_attach', (ev) => {
		  if(!confirm('해당 첨부 파일을 삭제할까요?')){
			  return;
		  }
		  $.ajax({
			  // 요청
			  type: 'post',
			  url: '${contextPath}/upload/removeAttach.do',
			  data: 'attachNo=' + $(ev.target).parent().data('attach_no'),
			  // 응답
			  dataType: 'json',
			  success: (resData) => {  // resData = {"removeResult": 1}
				  if(resData.removeResult === 1){
					  alert('해당 첨부 파일이 삭제되었습니다.');
					  fnAttachList();
				  } else {
					  alert('해당 첨부 파일이 삭제되지 않았습니다.');
				  }
			  }
		  })
	  })
  }


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
  
  loadImg();
  fnAddAttach();
  fnAttachList();
  fnRemoveAttach();
  fnFileCheck();
  
</script>

<%@ include file="../layout/footer.jsp" %>