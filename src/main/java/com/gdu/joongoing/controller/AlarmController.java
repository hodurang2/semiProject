package com.gdu.joongoing.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.gdu.joongoing.service.AlarmService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class AlarmController {
  
  private final AlarmService alarmService;
  
  @GetMapping("/alarmList.do")
  public String AlarmList(HttpServletRequest request, Model model) {
    alarmService.loadAlarmList(request, model);
    return "alarmlist";
  }
  
}
