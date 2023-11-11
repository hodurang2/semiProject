<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="회원가입" name="title"/>
</jsp:include>

<script src="${contextPath}/resources/js/user_join.js?dt=${dt}"></script>

<div>

  <form id="frm_join" method="post" action="${contextPath}/user/join.do">
    
    <h1>회원가입</h1>
    
    <div>
      <div>
        <label for="email">이메일</label>
        <input type="text" name="email" id="email">
        <button type="button" id="btn_get_code">인증코드받기</button>
        <span id="msg_email"></span>
      </div>
      <div>
        <input type="text" id="code" placeholder="인증코드입력" disabled>
        <button type="button" id="btn_verify_code" disabled>인증하기</button>
      </div>
    </div>
    
    <div>
      <label for="pw">비밀번호</label>
      <input type="password" name="pw" id="pw">
      <span id="msg_pw"></span>
    </div>
    
    <div>
      <label for="pw2">비밀번호 확인</label>
      <input type="password" id="pw2">
      <span id="msg_pw2"></span>
    </div>
    
    <div>
      <label for="name">이름</label>
      <input type="text" name="name" id="name">
      <span id="msg_name"></span>
    </div>
    
    <div>
      <input type="radio" name="gender" value="NO" id="none" checked>
      <label for="none">선택안함</label>
      <input type="radio" name="gender" value="M" id="man">
      <label for="man">남자</label>
      <input type="radio" name="gender" value="F" id="woman">
      <label for="woman">여자</label>
    </div>
    
    <div>
      <label for="mobile">휴대전화번호</label>
      <input type="text" name="mobile" id="mobile">
      <span id="msg_mobile"></span>
    </div>
    
    <div>    
      <input type="text" name="postcode" id="postcode" onclick="execDaumPostcode()" placeholder="우편번호" readonly>
      <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
      <input type="text" name="roadAddress" id="roadAddress" placeholder="도로명주소" readonly>
      <input type="text" name="jibunAddress" id="jibunAddress" placeholder="지번주소" readonly>
      <span id="guide" style="color:#999;display:none"></span>
      <input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소">
      <input type="text" id="extraAddress" placeholder="참고항목">
    </div>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
      //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
      function execDaumPostcode() {
        new daum.Postcode({
          oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
              extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
              extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
              extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("roadAddress").value = roadAddr;
            document.getElementById("jibunAddress").value = data.jibunAddress;
            
            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if(roadAddr !== ''){
              document.getElementById("extraAddress").value = extraRoadAddr;
            } else {
              document.getElementById("extraAddress").value = '';
            }

            var guideTextBox = document.getElementById("guide");
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
              var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
              guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
              guideTextBox.style.display = 'block';
            } else if(data.autoJibunAddress) {
              var expJibunAddr = data.autoJibunAddress;
              guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
              guideTextBox.style.display = 'block';
            } else {
              guideTextBox.innerHTML = '';
              guideTextBox.style.display = 'none';
            }
          }
        }).open();
      }
    </script>
    
    <div>
      <input type="hidden" name="event" value="${event}">
      <button type="submit">회원가입하기</button>
    </div>
    
  </form>

</div>

<%@ include file="../layout/footer.jsp" %>