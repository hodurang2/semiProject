<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="리뷰작성" name="title"/>
</jsp:include>

<style>

.rev {
    background-color: #e8e8e8;
    height: 100%;
}
a, a:hover, a:visited, a:active{
    text-decoration: none;
    color: #000;
}
a:hover{
    color: #a00;
}
h1{
    text-align: center;
    background-color: #fff;
    padding: 5px;
    margin: 0;
}

/* 레이아웃 외곽 너비 400px 제한*/
.wrap{
    max-width: 480px;
    margin: 0 auto; /* 화면 가운데로 */
    background-color: #fff;
    height: 100%;
    padding: 20px;
    box-sizing: border-box;

}
.reviewform textarea{
    width: 100%;
    padding: 10px;
    box-sizing: border-box;
}
.rating .rate_radio {
    position: relative;
    display: inline-block;
    z-index: 20;
    opacity: 0.001;
    width: 60px;
    height: 60px;
    background-color: #fff;
    cursor: pointer;
    vertical-align: top;
    display: none;
}
.rating .rate_radio + label {
    position: relative;
    display: block;
    float: left;
    z-index: 10;
    width: 60px;
    height: 60px;
    background-image:  url(../resources/image/star/starrate.png);
    background-repeat: no-repeat;
    background-size: 60px 60px;
    cursor: pointer;
}
.rating .ratefill {
    background-color: #ff8;
    width: 0;
    height: 60px;
    position: absolute;
}

.cmd{
    margin-top: 20px;
    text-align: right;
}
.cmd input[type="button"]{
    padding: 10px 20px;
    border: 1px solid #e8e8e8;
    background-color: #fff;
    background-color:#000;  
    color: #fff;
}

.warning_msg {
    display: none;
    position: relative;
    text-align: center;
    background: #ffffff;
    line-height: 26px;
    width: 100%;
    color: red;
    padding: 10px;
    box-sizing: border-box;
    border: 1px solid #e0e0e0;
}

</style>
<div class="rev">

  <form id="frm_review" method="post" action="${contextPath}/mypage/reviewSave.do">
  
    <h1 class="text-center mb-4">${purchaseProduct.productName} 리뷰작성하기</h1>
    <div>
      <div>상품명</div>
      <input type="text" id="productName" name="productName" value="${purchaseProduct.productName}" readOnly>
    </div>
    <div>
      <div>판매자번호</div>
      <input type="text" id="sellerNo" name="sellerNo" value="${purchaseProduct.sellerNo}" readOnly>
    </div>

    <input type="hidden" name="productNo" id="productNo" value="${purchaseProduct.productNo}"/>
    <p class="title_star">별점과 구매 후기를 남겨주세요.(최대 400자)</p>

    <div class="review_rating rating_point">
        <div class="rating">
            <div class="ratefill"></div>
            <!-- [D] 해당 별점이 선택될 때 그 점수 이하의 input엘리먼트에 checked 클래스 추가 -->
            <input type="checkbox" name="reviewScore" id="rating1" value="1" class="rate_radio" title="1점">
            <label for="rating1"></label>
            <input type="checkbox" name="reviewScore" id="rating2" value="2" class="rate_radio" title="2점">
            <label for="rating2"></label>
            <input type="checkbox" name="reviewScore" id="rating3" value="3" class="rate_radio" title="3점" >
            <label for="rating3"></label>
            <input type="checkbox" name="reviewScore" id="rating4" value="4" class="rate_radio" title="4점">
            <label for="rating4"></label>
            <input type="checkbox" name="reviewScore" id="rating5" value="5" class="rate_radio" title="5점">
            <label for="rating5"></label>
        </div>
    </div>
    <div class="review_contents">
        <textarea rows="10" class="review_textarea" id="reviewContents" name="reviewContents"></textarea>
    </div>
    <div class="pl">
      <button type="button" id="btn_purchase_list">구매목록보기</button>
    </div>
    <div class="cmd">
        <button type="submit" name="save" id="save">등록</button>
    </div>

  </form>
  
</div>

<script>
	
  document.addEventListener('DOMContentLoaded', function(){
    //별점선택 이벤트 리스너
    const rateForms = document.querySelectorAll('.rating'); /* 별점 선택 템플릿을 모두 선택 */
    rateForms.forEach(function(item){//클릭 이벤트 리스너 각각 등록
    item.addEventListener('click',function(e){
      let elem = e.target;
      if(elem.classList.contains('rate_radio')){
        rating.setRate(elem.parentElement, parseInt(elem.value)); // setRate() 에 ".rating" 요소를 첫 번째 파라메터로 넘김
      }
    })
  });

    //상품평 작성 글자수 초과 체크 이벤트 리스너
    document.querySelector('.review_textarea').addEventListener('keydown',function(){
        //리뷰 400자 초과 안되게 자동 자름
        let review = document.querySelector('.review_textarea');
        let lengthCheckEx = /^.{400,}$/;
        if(lengthCheckEx.test(review.value)){
            //400자 초과 컷
            review.value = review.value.substr(0,400);
        }
    });

    //저장 전송전 필드 체크 이벤트 리스너
    document.querySelector('#save').addEventListener('click', function(e){
        //별점 선택 안했으면 메시지 표시
        if(rating.rate == 0){
            alert('별점을 선택하세요.');
            e.preventDefault();
            return;
        }
        //리뷰 5자 미만이면 메시지 표시
        if(document.querySelector('.review_textarea').value.length < 5){
            alert('5자 이상의 리뷰 내용을 작성해 주세요.');
            e.preventDefault();
            return;
        }
    //폼 서밋
    //실제로는 서버에 폼을 전송하고 완료 메시지가 표시되지만 저장된 것으로 간주하고 폼을 초기화 함.
    alert("리뷰가 저장되었습니다.");
    location.href = '${contextPath}/mypage/purchaseList.do';
    });
  });


  //별점 마킹 모듈 프로토타입으로 생성
  function Rating(){};
  Rating.prototype.rate = 0;
  Rating.prototype.setRate = function(rateobj, newrate){
    //별점 마킹 - 클릭한 별 이하 모든 별 체크 처리
    this.rate = newrate;
    let checks = null;
    //요소가 파라메터로 넘어오면 별점 클릭, 없으면 저장 후 전체 초기화
    if(rateobj){
      rateobj.querySelector('.ratefill').style.width = parseInt(newrate * 60) + 'px'; // 현재 별점 갯수 채색
      checks = rateobj.querySelectorAll('.rate_radio'); // 넘어온 요소 하위의 라디오버튼만 선택
    } else{
    //전체 별점 채색 초기화
    const rateFills = document.querySelectorAll('.ratefill');
    rateFills.forEach(function(item){
      item.style.width = parseInt(newrate * 60) + 'px';
    });
    //전체 라디오 버튼 초기화
    checks = document.querySelectorAll('.rate_radio');
  }
  //별점 체크 라디오 버튼 처리
  if(checks){
    checks.forEach(function(item, idx){
      if(idx < newrate){
        item.checked = true;
      }else{
        item.checked = false;
      }
    });
  }
}

let rating = new Rating();//별점 인스턴스 생성

  const fnBack = () => {
	  $(document).on('click', '#btn_purchase_list', () => {
		  location.href='${contextPath}/mypage/purchaseList.do';
	  })
  }
  fnBack();

</script>

<%@ include file="../layout/footer.jsp" %>