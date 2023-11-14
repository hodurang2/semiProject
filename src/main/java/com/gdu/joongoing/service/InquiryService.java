package com.gdu.joongoing.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.gdu.joongoing.dto.InquiryDto;

public interface InquiryService {

  public void loadInquiryList(HttpServletRequest request, Model model);

  public InquiryDto getInquiry(int inquiryNo, Model model);

}
