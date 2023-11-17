package com.gdu.joongoing.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface AlarmService {

  public void loadAlarmList(HttpServletRequest request, Model model);
  public Map<String, Object> addAlarm(HttpServletRequest request);

}
