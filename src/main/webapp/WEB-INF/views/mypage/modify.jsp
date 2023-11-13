<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="마이페이지" name="title"/>
</jsp:include>

<div>

  <form id="frm_mypage_modify" method="post">

    <h1 class="text-center mb-4">회원정보수정</h1>

    <c:if test="${sessionScope.user.state == 0}">
      <div class="text-center">
        <button type="button" id="btn_modify_pw" class="btn btn-danger">비밀번호변경하기</button>
      </div>      
      <hr class="my-3">
    </c:if>
    
    <div class="row mb-4">
      <div class="col-sm-3">이메일</div>
      <div class="col-sm-9">${sessionScope.user.email}</div>
    </div>
    <div class="row mb-4">
      <div class="col-sm-3">가입일</div>
      <div class="col-sm-9">${sessionScope.user.joinedAt}</div>
    </div>
    
    <div class="row mb-2">
      <label for="name" class="col-sm-3 col-form-label">이름</label>
      <div class="col-sm-9"><input type="text" name="name" value="${sessionScope.user.name}" id="name" class="form-control"></div>
      <div class="col-sm-3"></div>
      <div class="col-sm-9 mb-3" id="msg_name"></div>
    </div>

    <div class="row mb-2">
      <label class="col-sm-3 form-label">성별</label>
      <div class="col-sm-3">
        <input type="radio" name="gender" value="NO" id="none" class="form-check-input">
        <label class="form-check-label" for="none">선택안함</label>
      </div>
      <div class="col-sm-3">
        <input type="radio" name="gender" value="M" id="man" class="form-check-input">
        <label class="form-check-label" for="man">남자</label>
      </div>
      <div class="col-sm-3">
        <input type="radio" name="gender" value="F" id="woman" class="form-check-input">
        <label class="form-check-label" for="woman">여자</label>
      </div>
    </div>
    
    <script>
      $(':radio[value=${sessionScope.user.gender}]').prop('checked', true);
    </script>
    
    <div class="row mb-2">
      <label for="phone" class="col-sm-3 col-form-label">휴대폰번호</label>
      <div class="col-sm-9"><input type="text" name="phone" value="${sessionScope.user.phone}" id="phone" class="form-control"></div>
      <div class="col-sm-3"></div>
      <div class="col-sm-9 mb-3" id="msg_phone"></div>
    </div>
    
    <div class="row mb-2">
      <div class="col-sm-3">주소</div>
      <select name="sido" id="sido"></select>
      <select name="sigungu" id="sigungu"></select>
    </div>
    
    <script>
      $(':select[name=sido] option[value=${sessionScope.user.sido}]').prop('selected', true);
      $(':select[name=sigungu] option[value=${sessionScope.user.sigungu}]').prop('selected', true);
    </script>
    
     <hr class="my-3">
      
    <div class="row mt-3">
      <label class="col-sm-12 form-label">이벤트 알림 동의(선택)</label>
    </div>
    <div class="row mb-2">
      <div class="col-sm-3">
        <input type="radio" name="event" value="on" id="event_on" class="form-check-input">
        <label class="form-check-label" for="event_on">동의함</label>
      </div>
      <div class="col-sm-3">
        <input type="radio" name="event" value="off" id="event_off" class="form-check-input">
        <label class="form-check-label" for="event_off">동의안함</label>
      </div>
    </div>
    <script>
      if('${sessionScope.user.agree}' === '0'){
        $('#event_off').prop('checked', true);
      } else if('${sessionScope.user.agree}' === '1'){
        $('#event_on').prop('checked', true);
      }
    </script>
    
    <div>
      <input type="hidden" name="userNo" value="${sessionScope.user.userNo}"> 
      <button type="button" id="btn_modify">수정완료</button>
    </div>
        
  </form>
  
</div>

<script>

  $(() => {
	  fnModifyPwForm();
  })
  
  /* 전역변수 선언 */
  var area0 = ["시/도 선택","서울특별시","인천광역시","대전광역시","광주광역시","대구광역시","울산광역시","부산광역시","경기도","강원도","충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주도"];
  var area1 = ["강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구","용산구","은평구","종로구","중구","중랑구"];
  var area2 = ["계양구","남구","남동구","동구","부평구","서구","연수구","중구","강화군","옹진군"];
  var area3 = ["대덕구","동구","서구","유성구","중구"];
  var area4 = ["광산구","남구","동구",     "북구","서구"];
  var area5 = ["남구","달서구","동구","북구","서구","수성구","중구","달성군"];
  var area6 = ["남구","동구","북구","중구","울주군"];
  var area7 = ["강서구","금정구","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구","기장군"];
  var area8 = ["고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시","동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시","오산시","용인시","의왕시","의정부시","이천시","파주시","평택시","포천시","하남시","화성시","가평군","양평군","여주군","연천군"];
  var area9 = ["강릉시","동해시","삼척시","속초시","원주시","춘천시","태백시","고성군","양구군","양양군","영월군","인제군","정선군","철원군","평창군","홍천군","화천군","횡성군"];
  var area10 = ["제천시","청주시","충주시","괴산군","단양군","보은군","영동군","옥천군","음성군","증평군","진천군","청원군"];
  var area11 = ["계룡시","공주시","논산시","보령시","서산시","아산시","천안시","금산군","당진군","부여군","서천군","연기군","예산군","청양군","태안군","홍성군"];
  var area12 = ["군산시","김제시","남원시","익산시","전주시","정읍시","고창군","무주군","부안군","순창군","완주군","임실군","장수군","진안군"];
  var area13 = ["광양시","나주시","목포시","순천시","여수시","강진군","고흥군","곡성군","구례군","담양군","무안군","보성군","신안군","영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"];
  var area14 = ["경산시","경주시","구미시","김천시","문경시","상주시","안동시","영주시","영천시","포항시","고령군","군위군","봉화군","성주군","영덕군","영양군","예천군","울릉군","울진군","의성군","청도군","청송군","칠곡군"];
  var area15 = ["거제시","김해시","마산시","밀양시","사천시","양산시","진주시","진해시","창원시","통영시","거창군","고성군","남해군","산청군","의령군","창녕군","하동군","함안군","함양군","합천군"];
  var area16 = ["서귀포시","제주시","남제주군","북제주군"];

  /* 함수 정의 */
  const fnModifyPwForm = () => {
	  $('#btn_modify_pw').click(() => {
		  location.href = '${contextPath}/mypage/modifyPw.form';
	  })
  }
  
  const fnCheckName = () => {
	  $('#name').blur((ev) => {
	    let name = ev.target.value;
	    let bytes = 0;
	    for(let i = 0; i < name.length; i++){
	      if(name.charCodeAt(i) > 128){  // 코드값이 128을 초과하는 문자는 한 글자 당 2바이트임
	        bytes += 2;
	      } else {
	        bytes++;
	      }
	    }
	    namePassed = (bytes <= 50);
	    if(!namePassed){
	      $('#msg_name').text('이름은 50바이트 이내로 작성해야 합니다.');
	    }
	  })
	}

	const fnCheckMobile = () => {
	  $('#phone').keyup((ev) => {
	    ev.target.value = ev.target.value.replaceAll('-', '');
	    // 휴대폰번호 검사 정규식 (010숫자8개)
	    let regMobile = /^010[0-9]{8}$/;
	    mobilePassed = regMobile.test(ev.target.value);
	    if(mobilePassed){
	      $('#msg_phone').text('');
	    } else {
	      $('#msg_phnoe').text('휴대폰번호를 확인하세요.');       
	    }
	  })
	}

	const fnModifyUser = () => {
	  $('#btn_modify').click(() => {
	    if(!namePassed){
	      alert('이름을 확인하세요.');
	      return;
	    } else if(!mobilePassed){
	      alert('휴대전화번호를 확인하세요.');
	      return;
	    }
	    $.ajax({
	      // 요청
	      type: 'post',
	      url: '${contextPath}/mypage/modify.do',
	      data: $('#frm_mypage_modify').serialize(),
	      // 응답
	      dataType: 'json',
	      success: (resData) => {  // {"modifyResult": 1}
	        if(resData.modifyResult === 1){
	          alert('회원 정보가 수정되었습니다.');
	        } else {
	          alert('회원 정보가 수정되지 않았습니다.');
	        }
	      }
	    })
	  })
	}
	
  
  
</script>

<%@ include file="../layout/footer.jsp" %>