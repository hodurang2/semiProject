package com.gdu.joongoing.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.gdu.joongoing.dto.InquiryDto;

public interface InquiryService {

  public void loadInquiryList(HttpServletRequest request, Model model);
  public InquiryDto getInquiry(int inquiryNo, Model model);
  public int addInquiry(HttpServletRequest request);
  
  public Map<String, Object> addComment(HttpServletRequest request);
  public Map<String, Object> loadAnswerList(HttpServletRequest request);
  public Map<String, Object> addAnswerReply(HttpServletRequest request);
  
}
