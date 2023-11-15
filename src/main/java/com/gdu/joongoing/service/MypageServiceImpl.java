package com.gdu.joongoing.service;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gdu.joongoing.dao.MypageMapper;
import com.gdu.joongoing.dto.ProductDto;
import com.gdu.joongoing.dto.UserDto;
import com.gdu.joongoing.util.MyPageUtils;
import com.gdu.joongoing.util.MySecurityUtils;

import lombok.RequiredArgsConstructor;

@Transactional
@RequiredArgsConstructor
@Service
public class MypageServiceImpl implements MypageService {

  private final MypageMapper mypageMapper;
  private final MySecurityUtils mySecurityUtils;
  private final MyPageUtils myPageUtils;
  
  @Override
  public UserDto getUser2(String email) {
    return mypageMapper.getUser2(Map.of("email", email));
  }
  
  @Override
  public void modifyPw(HttpServletRequest request, HttpServletResponse response) {
    
    String pw = mySecurityUtils.getSHA256(request.getParameter("pw"));
    int userNo = Integer.parseInt(request.getParameter("userNo"));
    
    UserDto user = UserDto.builder()
                    .pw(pw)
                    .userNo(userNo)
                    .build();
    
    int modifyPwResult = mypageMapper.updateUserPw(user);
    
    try {
      
      response.setContentType("text/html; charset=UTF-8");
      PrintWriter out = response.getWriter();
      out.println("<script>");
      if(modifyPwResult == 1) {
        HttpSession session = request.getSession();
        UserDto sessionUser = (UserDto)session.getAttribute("user");
        sessionUser.setPw(pw);
        out.println("alert('비밀번호가 수정되었습니다.')");
        out.println("location.href='" + request.getContextPath() + "/mypage/modify.form'");
      } else {
        out.println("alert('비밀번호가 수정되지 않았습니다.')");
        out.println("history.back()");
      }
      out.println("</script>");
      out.flush();
      out.close();
      
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
  

  @Override
  public void modifyInterest(HttpServletRequest request, HttpServletResponse response) {
    
    String interestSido = request.getParameter("interestSido");
    String interestSigungu = request.getParameter("interestSigungu");
    int userNo = Integer.parseInt(request.getParameter("userNo"));
    
    UserDto user = UserDto.builder()
                          .interestSido(interestSido)
                          .interestSigungu(interestSigungu)
                          .userNo(userNo)
                          .build();
    int modifyInterestResult = mypageMapper.updateUserInterest(user);
    
    try {
      
      response.setContentType("text/html; charset=UTF-8");
      PrintWriter out = response.getWriter();
      out.println("<script>");
      if(modifyInterestResult == 1) {
        HttpSession session = request.getSession();
        UserDto sessionUser = (UserDto)session.getAttribute("user");
        sessionUser.setInterestSido(interestSido);
        sessionUser.setInterestSigungu(interestSigungu);
        out.println("alert('관심지역이 수정되었습니다.')");
        out.println("location.href='" + request.getContextPath() + "/mypage/detail.do'");
      } else {
        out.println("alert('관심지역이 수정되지 않았습니다.");
        out.println("history.back()");
      }
      out.println("</script>");
      out.flush();
      out.close();
      
    } catch(Exception e) {
      e.printStackTrace();
    }
    
  }
  
  
  @Override
  public ResponseEntity<Map<String, Object>> modify(HttpServletRequest request) {
    
    String name = mySecurityUtils.preventXSS(request.getParameter("name"));
    String gender = request.getParameter("gender");
    String phone = request.getParameter("phone");
    String sido = request.getParameter("sido");
    String sigungu = request.getParameter("sigungu");
    String event = request.getParameter("event");
    int agree = event.equals("on") ? 1 : 0;    
    int userNo = Integer.parseInt(request.getParameter("userNo"));
    
    UserDto user = UserDto.builder()
                          .name(name)
                          .gender(gender)
                          .phone(phone)
                          .sido(sido)
                          .sigungu(sigungu)
                          .agree(agree)
                          .userNo(userNo)
                          .build();
    int modifyResult = mypageMapper.updateUser(user);
    
    if(modifyResult == 1) {
      // session 정보 수정
      HttpSession session = request.getSession();
      UserDto sessionUser = (UserDto)session.getAttribute("user");
      sessionUser.setName(name);
      sessionUser.setGender(gender);
      sessionUser.setPhone(phone);
      sessionUser.setSido(sido);
      sessionUser.setSigungu(sigungu);
      sessionUser.setAgree(agree);
    }
    
    return new ResponseEntity<>(Map.of("modifyResult", modifyResult), HttpStatus.OK);
  }
  
  
  @Override
  public Map<String, Object> getSalesList(HttpServletRequest request) {
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    Optional<String> opt2 = Optional.ofNullable(request.getParameter("sellerNo"));
    int sellerNo = Integer.parseInt(opt2.orElse("0"));  // 판매자 번호
    int total = mypageMapper.getSalesCount(sellerNo);   // 판매 상품 갯수
    int display = 9;    // 3 x 3 목록 만들기 위해
    
    myPageUtils.setPaging(page, total, display);  // begin, end 계산
    
    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
                                   , "end", myPageUtils.getEnd()); 
    
    // 전달하고 목록 받기
    List<ProductDto> salesList = mypageMapper.getSalesList(map);
   
    return Map.of("salesList", salesList
                , "totalPage", myPageUtils.getTotalPage());   // 전체 페이지 이후에도 가져오려고 할 수도 있어서 전체 페이지 수도 같이 보낸다.
  }
  
}
