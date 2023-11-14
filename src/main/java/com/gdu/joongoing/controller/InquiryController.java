package com.gdu.joongoing.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gdu.joongoing.service.InquiryService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/inquiry")
@RequiredArgsConstructor
@Controller
public class InquiryController {
  
  private final InquiryService inquiryService;

  @GetMapping("/list.do")
  public String list(HttpServletRequest request, Model model) {
    inquiryService.loadInquiryList(request, model);
    return "inquiry/list";
  }
  
  @GetMapping("/write.form")
  public String write() {
    return "blog/write";
  }
  
  @GetMapping("/detail.do")
  public String detail(int inquiryNo, Model model) {
    model.addAttribute("inquiry", inquiryService.getInquiry(inquiryNo, model));
    return "inquiry/detail";
  }
  
  
}
