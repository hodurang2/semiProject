package com.gdu.joongoing.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.gdu.joongoing.service.InquiryService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class InquiryController {
  
  private final InquiryService inquiryService;

  @GetMapping("/inquiry/list.do")
  public String list(HttpServletRequest request, Model model) {
    inquiryService.loadInquiryList(request, model);
    return "inquiry/list";
  }
  
  
}
