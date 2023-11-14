<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="약관동의" name="title"/>
</jsp:include>

<div class="grid text-center">

  <form id="frm_agree" action="${contextPath}/user/join.form">
    
    <h1 class="grid text-center">약관 동의하기</h1>
    
    <div>
      <input type="checkbox" id="chk_all">
      <label for="chk_all">모두 동의합니다</label>
    </div>
    
    <hr>
    
    <div>
      <input type="checkbox" name="service" id="service" class="chk_each">
      <label for="service">서비스 이용약관 동의(필수)</label>
    </div>
    <div>
      <textarea rows="5" cols="50">
        제1조(목적) 이 약관은 업체 회사(전자상거래 사업자)가 운영하는 업체 중고잉에서 제공하는 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 중고잉과 이용자의 권리․의무 및 책임사항을 규정함을 목적으로 합니다.
        ※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다.」
       </textarea>
    </div>
    
    <div>
      <input type="checkbox" name="privacy" id="privacy" class="chk_each">
      <label for="privacy">개인정보 수집 및 이용 동의(필수)</label>
    </div>
    <div>
      <textarea rows="5" cols="50">개인정보처리방침
        [차례]
        1. 총칙
        2. 개인정보 수집에 대한 동의
        3. 개인정보의 수집 및 이용목적
        4. 수집하는 개인정보 항목
        5. 개인정보 자동수집 장치의 설치, 운영 및 그 거부에 관한 사항
        6. 목적 외 사용 및 제3자에 대한 제공
        7. 개인정보의 열람 및 정정
        8. 개인정보 수집, 이용, 제공에 대한 동의철회
        9. 개인정보의 보유 및 이용기간
        10. 개인정보의 파기절차 및 방법
        11. 아동의 개인정보 보호
        12. 개인정보 보호를 위한 기술적 대책
        13. 개인정보의 위탁처리
        14. 의겸수렴 및 불만처리
        15. 부 칙(시행일)
        </textarea>
    </div>
    
    <div>
      <input type="checkbox" name="event" id="event" class="chk_each">
      <label for="event">이벤트 알림 동의(선택)</label>
    </div>
    <div>
      <textarea rows="5" cols="50">
        본 이벤트 약관("약관")은 중고잉과 귀하 또는 귀하가 대표하는 단체("귀하") 사이의 계약입니다. 
        이 이벤트("이벤트")에 등록하거나 참여함으로써, 귀하는 본 약관과 중고잉의 이용 약관 및 개인정보 보호정책("개인정보 보호정책")을 읽고 이해했음을 확인합니다. 
        본 약관은 중고잉 웹사이트에 개정판을 게시하거나 귀하에게 기타 통지함으로써 언제든 수정될 수 있습니다. 
        이벤트에 참여함으로써, 귀하는 본 약관의 최신판에 동의합니다.
      </textarea>
    </div>

    <div>
      <button type="submit">다음</button>
    </div>
    
  </form>

</div>
<script>

$(() => {
	fnChkAll();
	fnChkEach();
	fnJoinForm();
  })


  const fnChkAll = () => {
    $('#chk_all').click((ev) => {
       $('.chk_each').prop('checked', $(ev.target).prop('checked'));
    })
  }
  
  const fnChkEach = () => {
  	$(document).on('click', '.chk_each', () => {
      var total = 0;
      $.each($('.chk_each'), (i, elem) => {
    	total += $(elem).prop('checked');
      })
      $('#chk_all').prop('checked', total === $('.chk_each').length);
  	})
  }
  
  const fnJoinForm = () => {
	$('#frm_agree').submit((ev) => {
	  if(!$('#service').is(':checked') || !$('#privacy').is(':checked')) {
		alert('필수 약관에 동의하세요.');
		ev.preventDefault();
		return;
	  }
	})
  }

</script>

<%@ include file="../layout/footer.jsp" %>