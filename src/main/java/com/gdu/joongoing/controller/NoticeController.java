package com.gdu.joongoing.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.joongoing.service.NoticeService;

import lombok.RequiredArgsConstructor;
import oracle.jdbc.proxy.annotation.Post;

@RequestMapping("/notice")
@RequiredArgsConstructor
@Controller
public class NoticeController {
  private final NoticeService noticeService;
  
  @GetMapping("/list.do")
  public String list(HttpServletRequest request, Model model) {
    noticeService.loadNoticeList(request, model);
    return "notice/list";
  }
  
  @GetMapping("/detail.do")
  public String detail(int noticeNo, Model model) {
    model.addAttribute("notice", noticeService.getNotice(noticeNo, model));
    return "notice/detail";
  }
  
  @GetMapping("/write.form")
  public String write() {
    return "notice/write";
  }
  
  @PostMapping(value = "/addNotice.do", produces = "application/json")
  public String addNotice(HttpServletRequest request, RedirectAttributes redirectAttributes) {
    redirectAttributes.addFlashAttribute("addResult", noticeService.addNotice(request));
    return "redirect:/notice/list.do"; 
  }
  
  @PostMapping(value = "/imageUpload.do", produces = "application/json")
  @ResponseBody
  public Map<String, Object> imageUpload(MultipartHttpServletRequest multipartRequest) {
    return imageUpload(multipartRequest);
  }
  
 }
