package com.gdu.joongoing.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;

import com.gdu.joongoing.dto.UserDto;


public interface UserService {
  public UserDto getUser(String email);
  public void login(HttpServletRequest request, HttpServletResponse response) throws Exception;
  public void logout(HttpServletRequest request, HttpServletResponse response);
  public ResponseEntity<Map<String, Object>> checkEmail(String email);
  public ResponseEntity<Map<String, Object>> sendCode(String email);
  public void join(HttpServletRequest request, HttpServletResponse response);
  public UserDto findId(UserDto user);
  public void findPw(UserDto user, HttpServletResponse response) throws Exception;
  public String getNaverLoginURL(HttpServletRequest request) throws Exception;
  public String getNaverLoginAccessToken(HttpServletRequest request) throws Exception;
  public UserDto getNaverProfile(String accessToken) throws Exception;
  public void naverJoin(HttpServletRequest request, HttpServletResponse response);
  public void naverLogin(HttpServletRequest request, HttpServletResponse response, UserDto naveProfile) throws Exception;
}
