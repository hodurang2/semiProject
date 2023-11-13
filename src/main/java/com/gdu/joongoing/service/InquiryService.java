package com.gdu.joongoing.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface InquiryService {

  void loadInquiryList(HttpServletRequest request, Model model);

}
