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

    <h1>회원정보수정</h1>

    <div>
      <button type="button" id="btn_modify_pw">비밀번호변경</button>
    </div>
    
    <table>
      <tr>
        <td>이메일</td>
        <td>${sessionScope.user.email}</td>
      </tr>
      <tr>
        <td>가입일</td>
        <td>${sessionScope.user.joinedAt}</td>
      </tr>
      <tr>
        <td><label for="name">이름</label></td>
        <td><input type="text" name="name" id="name" value="${sessionScope.user.name}"></td>
        <td><span id="msg_name"></span></td>
      </tr>
      <tr>
        <td>성별</td>
        <td>
          <input type="radio" name="gender" value="NO" id="none">
          <label for="none">선택안함</label>
          <input type="radio" name="gender" value="M" id="man">
          <label for="man">남자</label>
          <input type="radio" name="gender" value="F" id="woman">
          <label for="woman">여자</label>
        </td>
      </tr>
      <tr>
        <td><label for="phone">휴대폰번호</label></td>
        <td><input type="text" name="phone" id="phone" value="${sessionScope.user.phone}"></td>
        <td><span id="msg_phone"></span></td>
      </tr>
      <tr>
        <td>이벤트 알림 동의(선택)</td>
        <td>
          <input type="radio" name="event" id="event_on" value="on"><label for="event_on">동의함</label>
          <input type="radio" name="event" id="event_off" value="off"><label for="event_off">동의안함</label>
        </td>
      </tr>
      <tr>
        <td><label for="sido">주소</label></td>
      </tr>
      <tr>
        <td>시도</td>
      </tr>
      <tr>
        <td>시군구</td>
      </tr>
    </table>

    <script>
      $(':radio[value=${sessionScope.user.gender}]').prop('checked', true);
    </script>

    <script>
      if('${sessionScope.user.agree}' === '0') {   // 필수만 선택한 사람
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