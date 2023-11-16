package com.gdu.joongoing.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface AlarmService {

  public void loadAlarmList(HttpServletRequest request, Model model);

}
