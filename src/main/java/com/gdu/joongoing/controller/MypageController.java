package com.gdu.joongoing.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gdu.joongoing.service.MypageService;

import lombok.RequiredArgsConstructor;

@RequestMapping(value="/mypage")
@RequiredArgsConstructor
@Controller
public class MypageController {
  
  private final MypageService mypageService;
  
  @GetMapping("/detail.do")
  public String myPage() {
    return "mypage/detail";
  }
  
  @GetMapping("/modifyPw.form")
  public String modifyPwForm() {
    return "mypage/pw";
  }

  @GetMapping("/modify.form")
  public String modifyUser() {
    return "mypage/modify";
  }
  
  @PostMapping(value="/modify.do", produces=MediaType.APPLICATION_JSON_VALUE)
  public ResponseEntity<Map<String, Object>> modify(HttpServletRequest request) {
    return mypageService.modify(request);
  }
  
  @GetMapping("/modifyInterest.do")
  public String modifyInterest() {
    return "mypage/interest";
  }
  
}