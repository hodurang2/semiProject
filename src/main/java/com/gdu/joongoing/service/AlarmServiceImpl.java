package com.gdu.joongoing.service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gdu.joongoing.dao.AlarmMapper;
import com.gdu.joongoing.dto.AlarmDto;
import com.gdu.joongoing.util.MyPageUtils;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class AlarmServiceImpl implements AlarmService{
  
  private final AlarmMapper alarmMapper;
  private final MyPageUtils myPageUtils;
  
  
  @Override
  public void loadAlarmList(HttpServletRequest request, Model model) {
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int total = alarmMapper.getAlarmCount();
    int display = 10;
    
    myPageUtils.setPaging(page, total, display);
    
    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
                                   , "end", myPageUtils.getEnd());
    
    List<AlarmDto> alarmList = alarmMapper.getAlarmList(map);
    
    model.addAttribute("alarmList", alarmList);
    model.addAttribute("paging", myPageUtils.getMvcPaging(request.getContextPath() + "/alarmlist.do"));
    model.addAttribute("beginNo", total - (page - 1) * display);
  }    
  
}
