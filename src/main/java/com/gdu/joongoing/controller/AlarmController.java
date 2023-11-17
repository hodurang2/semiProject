package com.gdu.joongoing.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.joongoing.service.AlarmService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class AlarmController {
  
  private final AlarmService alarmService;

  @ResponseBody
  @PostMapping(value="/addAlarm.do", produces="application/json")
  public Map<String, Object> addAlarm(HttpServletRequest request) {
    return alarmService.addAlarm(request);
  }
  
  @GetMapping("/alarmList.do")
  public String AlarmList(HttpServletRequest request, Model model) {
    alarmService.loadAlarmList(request, model);
    return "alarmlist";
  }
  
  
}
