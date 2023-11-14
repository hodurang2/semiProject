package com.gdu.joongoing.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gdu.joongoing.dao.UserMapper;
import com.gdu.joongoing.dto.InactiveUserDto;
import com.gdu.joongoing.dto.UserDto;
import com.gdu.joongoing.util.MyJavaMailUtils;
import com.gdu.joongoing.util.MySecurityUtils;

import lombok.RequiredArgsConstructor;

@Transactional
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
  
  private final UserMapper userMapper;
  private final MySecurityUtils mySecurityUtils;
  private final MyJavaMailUtils myJavaMailUtils;
  
  @Override
  public UserDto getUser(String email) {
    return userMapper.getUser(Map.of("email", email));
  }
  
  @Override
  public void login(HttpServletRequest request, HttpServletResponse response) throws Exception {
    
    String email = request.getParameter("email");
    String pw = mySecurityUtils.getSHA256(request.getParameter("pw"));
    
    Map<String, Object> map = Map.of("email", email
                                   , "pw", pw);

    HttpSession session = request.getSession();
    
    // 휴면 계정인지 확인하기
    InactiveUserDto inactiveUser = userMapper.getInactiveUser(map);
    if(inactiveUser != null) {
      session.setAttribute("inactiveUser", inactiveUser);
      response.sendRedirect(request.getContextPath() + "/user/active.form");
    }
    
    // 정상적인 로그인 처리하기
    UserDto user = userMapper.getUser(map);
    
    if(user != null) {
      request.getSession().setAttribute("user", user);
      userMapper.insertAccess(email);
      response.sendRedirect(request.getParameter("referer"));
    } else {
      response.setContentType("text/html; charset=UTF-8");
      PrintWriter out = response.getWriter();
      out.println("<script>");
      out.println("alert('일치하는 회원 정보가 없습니다.')");
      out.println("location.href='" + request.getContextPath() + "/main.do'");
      out.println("</script>");
      out.flush();
      out.close();
    }
    
  }
  
  @Override
  public void logout(HttpServletRequest request, HttpServletResponse response) {
    
    HttpSession session = request.getSession();
    
    session.invalidate();
    
    try {
      response.sendRedirect(request.getContextPath() + "/main.do");
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
  
  @Transactional(readOnly=true)
  @Override
  public ResponseEntity<Map<String, Object>> checkEmail(String email) {
    
    Map<String, Object> map = Map.of("email", email);
    
    boolean enableEmail = userMapper.getUser(map) == null
                       && userMapper.getLeaveUser(map) == null
                       && userMapper.getInactiveUser(map) == null;
    
    return new ResponseEntity<>(Map.of("enableEmail", enableEmail), HttpStatus.OK);
  }
  
  @Override
  public ResponseEntity<Map<String, Object>> sendCode(String email) {
    
    // RandomString 생성(6자리, 문자 사용, 숫자 사용)
    String code = mySecurityUtils.getRandomString(6, true, true);
    
    // 메일 전송
    myJavaMailUtils.sendJavaMail(email
                               , "중고잉 인증 코드"
                               , "<div>인증코드는 <strong>" + code + "</strong>입니다.</div>");
    
    return new ResponseEntity<>(Map.of("code", code), HttpStatus.OK);
    
  }
  
  @Override
  public void join(HttpServletRequest request, HttpServletResponse response) {
    
    String email = request.getParameter("email");
    String name = mySecurityUtils.preventXSS(request.getParameter("name"));
    String pw = mySecurityUtils.getSHA256(request.getParameter("pw"));
    String gender = request.getParameter("gender");
    String phone = request.getParameter("phone");
    String sido = request.getParameter("sido");
    String sigungu = request.getParameter("sigungu");
    String interestSido = request.getParameter("interestSido");
    String interestSigungu = request.getParameter("interestSigungu");
    String event = request.getParameter("event");
    
    UserDto user = UserDto.builder()
                    .email(email)
                    .name(name)
                    .pw(pw)
                    .gender(gender)
                    .phone(phone)
                    .agree(event.equals("on") ? 1 : 0)
                    .sido(sido)
                    .sigungu(sigungu)
                    .interestSido(interestSido)
                    .interestSigungu(interestSigungu)
                    .build();
    
    int joinResult = userMapper.insertUser(user);
    
try {
      
      response.setContentType("text/html; charset=UTF-8");
      PrintWriter out = response.getWriter();
      out.println("<script>");
      if(joinResult == 1) {
        request.getSession().setAttribute("user", userMapper.getUser(Map.of("email", email)));
        userMapper.insertAccess(email);
        out.println("alert('회원 가입되었습니다.')");
        out.println("location.href='" + request.getContextPath() + "/main.do'");
      } else {
        out.println("alert('회원 가입이 실패했습니다.')");
        out.println("history.go(-2)");
      }
      out.println("</script>");
      out.flush();
      out.close();
      
    } catch (Exception e) {
      e.printStackTrace();
    }
                    
    
  }

  @Override
  public UserDto findId(UserDto user) {
    return userMapper.findId(user);
  }
  
  @Override
  public void findPw(UserDto user, HttpServletResponse response) throws Exception {
    
    response.setContentType("text/html;charset=utf-8");
    PrintWriter out = response.getWriter();
    
    // RandomString 생성(10자리, 문자 사용, 숫자 사용) -- 임시 비밀번호
    String temporaryPw = mySecurityUtils.getRandomString(10, true, true);
    // 생성된 임시 비밀번호 암호화 처리
    String temporarySHAPw = mySecurityUtils.getSHA256(temporaryPw);
    
    int pwCheckResult = userMapper.findPwCheck(user);  // 1 or 0
    String email = user.getEmail();
    String name = user.getName();
    
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("email", email);
    map.put("name", name);
    map.put("pw", temporarySHAPw);
    
    if(pwCheckResult == 1) {
      userMapper.updatePw(map);
      myJavaMailUtils.sendJavaMail(email
          , "중고잉 임시 비밀번호발급"
          , "<div>임시 비밀번호는 <strong>" + temporaryPw + "</strong>입니다. 로그인 후 비밀번호를 변경해주세요.</div>");
      out.print(email + "로 임시 비밀번호가 전송되었습니다. 로그인 후 비밀번호를 변경해주세요.");
      out.close();
    } else {
      out.print("잘못된 정보입니다. 정보를 다시 입력하세요." );
      out.close();
    }
    
  }

  
  
}


