package com.gdu.joongoing.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;

import com.gdu.joongoing.dto.UserDto;

public interface MypageService {
  // 마이페이지
  public UserDto getUser2(String email);
  public void modifyPw(HttpServletRequest request, HttpServletResponse response);
  public void modifyInterest(HttpServletRequest request, HttpServletResponse response);
  public ResponseEntity<Map<String, Object>> modify(HttpServletRequest request);
  
  // 판매목록
  //public Map<String, Object> getSalesList(HttpServletRequest request);
  
}
