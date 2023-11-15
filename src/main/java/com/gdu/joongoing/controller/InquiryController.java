package com.gdu.joongoing.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.joongoing.dto.InquiryDto;
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
  
  @GetMapping("/detail.do")
  public String detail(int inquiryNo, Model model) {
    model.addAttribute("inquiry", inquiryService.getInquiry(inquiryNo, model));
    return "inquiry/detail";
  }
  
  @GetMapping("/write.form")
  public String write() {
    return "inquiry/write";
  }
  
  @PostMapping(value = "/addInquiry.do", produces = "application/json")
  public String addNotice(HttpServletRequest request, RedirectAttributes redirectAttributes) {
    redirectAttributes.addFlashAttribute("addResult", inquiryService.addInquiry(request));
    return "redirect:/inquiry/list.do"; 
  }
  
  @PostMapping("/edit.form")
  public String edit(@ModelAttribute("inquiry") InquiryDto inquiry) {
    return "inquiry/edit";
  }
  
  @PostMapping("/modifyInquiry.do")
  public String modifyInquiry(HttpServletRequest request, RedirectAttributes redirectAttributes) {
    int modifyResult = inquiryService.modifyInquiry(request);
    redirectAttributes.addFlashAttribute("modifyResult", modifyResult);
    return "redirect:/inquiry/detail.do?inquiryNo=" + request.getParameter("inquiryNo");
  }
  
  @PostMapping("/remove.do")
  public String remove(@RequestParam(value = "inquiryNo", required = false, defaultValue = "0") int inquiryNo, RedirectAttributes redirectAttributes) {
    int removeResult = inquiryService.removeInquiry(inquiryNo);
    redirectAttributes.addFlashAttribute("removeResult", removeResult);
    return "redirect:/inquiry/list.do";
  }
  
  @ResponseBody
  @PostMapping(value="/addAnswer.do", produces="application/json")
  public Map<String, Object> addComment(HttpServletRequest request) {
    return inquiryService.addComment(request);
  }
  
  
}
