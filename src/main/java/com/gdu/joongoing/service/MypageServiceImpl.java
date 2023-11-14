package com.gdu.joongoing.service;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.gdu.joongoing.dao.MypageMapper;
import com.gdu.joongoing.dto.UserDto;
import com.gdu.joongoing.util.MySecurityUtils;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class MypageServiceImpl implements MypageService {

  private final MypageMapper mypageMapper;
  private final MySecurityUtils mySecurityUtils; 
  
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
  public ResponseEntity<Map<String, Object>> modifyInterest(HttpServletRequest request) {
    
    String interestSido = request.getParameter("interestSido");
    String interestSigungu = request.getParameter("interestSigungu");
    int userNo = Integer.parseInt(request.getParameter("userNo"));
    UserDto user = UserDto.builder()
                          //.interestSido(interestSido)
                          //.interestSigungu(interestSigungu)
                          .userNo(userNo)
                          .build();
    int modifyInterestResult = mypageMapper.updateUserInterest(user);

    if(modifyInterestResult == 1) {
      // session 정보 수정
      HttpSession session = request.getSession();
      UserDto sessionUser = (UserDto)session.getAttribute("user");
      //sessionUser.setInterestSido(interestSido);
      //sessionUser.setInterestSigungu(interestSigungu);
    }
    
    return new ResponseEntity<>(Map.of("modifyInterestResult", modifyInterestResult), HttpStatus.OK);
    
  }
  
  
  @Override
  public ResponseEntity<Map<String, Object>> modify(HttpServletRequest request) {
    
    String name = mySecurityUtils.preventXSS(request.getParameter("name"));
    String gender = request.getParameter("gender");
    String phone = request.getParameter("phone");
    String event = request.getParameter("event");
    int agree = event.equals("on") ? 1 : 0;
    
    String sido = request.getParameter("sido");
    String sigungu = request.getParameter("sigungu");
    
    int userNo = Integer.parseInt(request.getParameter("userNo"));
    
    UserDto user = UserDto.builder()
                          .name(name)
                          .gender(gender)
                          .phone(phone)
                          .agree(agree)
                          .sido(sido)
                          .sigungu(sigungu)
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
      sessionUser.setAgree(agree);
      sessionUser.setSido(sido);
      sessionUser.setSigungu(sigungu);
    }
    
    return new ResponseEntity<>(Map.of("modifyResult", modifyResult), HttpStatus.OK);
  }
  
}
