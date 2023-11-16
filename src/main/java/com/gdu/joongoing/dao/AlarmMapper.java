package com.gdu.joongoing.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.joongoing.dto.AlarmDto;

@Mapper
public interface AlarmMapper {

  int getAlarmCount();
  List<AlarmDto> getAlarmList(Map<String, Object> map);

}
