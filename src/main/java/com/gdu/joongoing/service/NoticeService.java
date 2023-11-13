package com.gdu.joongoing.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;


public interface NoticeService {
  public void loadNoticeList(HttpServletRequest request, Model model);
  
}
