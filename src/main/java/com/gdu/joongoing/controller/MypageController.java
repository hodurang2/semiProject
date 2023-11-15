package com.gdu.joongoing.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.joongoing.service.MypageService;

import lombok.RequiredArgsConstructor;

@RequestMapping(value="/mypage")
@RequiredArgsConstructor
@Controller
public class MypageController {
  
  private final MypageService mypageService;
  
  @GetMapping("/detail.do")
  public String myPage() {
    return "mypage/sales_list";
  }
  
  @GetMapping("/modifyInterest.form")
  public String modifyInterest() {
    return "mypage/interest";
  }
  
  @PostMapping("/modifyInterest.do")
  public void modifyInterest(HttpServletRequest request, HttpServletResponse response) {
    mypageService.modifyInterest(request, response);
  }
  
  @GetMapping("/modify.form")
  public String modifyUser() {
    return "mypage/modify";
  }

  @GetMapping("/modifyPw.form")
  public String modifyPwForm() {
    return "mypage/pw";
  }
  
  @PostMapping("/modifyPw.do")
  public void modifyPw(HttpServletRequest request, HttpServletResponse response) {
    mypageService.modifyPw(request, response);
  }

  @PostMapping(value="/modify.do", produces=MediaType.APPLICATION_JSON_VALUE)
  public ResponseEntity<Map<String, Object>> modify(HttpServletRequest request) {
    return mypageService.modify(request);
  }
  
  @GetMapping("/salesList.do")
  public String salesList() {
    return "mypage/sales_list";
  }
  
  @GetMapping("/purchaseList.do")
  public String purchaseList() {
    return "mypage/purchase_list";
  }
  
  @GetMapping("/wishList.do")
  public String wishList() {
    return "mypage/wish_list";
  }
  
  @GetMapping("/reviewList.do")
  public String reviewList() {
    return "mypage/review_list";
  }
  
  /*
   * @ResponseBody
   * 
   * @GetMapping(value="/getSalesList.do", produces="application/json") public
   * Map<String, Object> getSalesList(HttpServletRequest request) { return
   * mypageService.getSalesList(request); }
   */
  
  
}