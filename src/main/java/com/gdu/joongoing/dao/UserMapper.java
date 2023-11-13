package com.gdu.joongoing.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.joongoing.dto.InactiveUserDto;
import com.gdu.joongoing.dto.LeaveUserDto;
import com.gdu.joongoing.dto.UserDto;


@Mapper
public interface UserMapper {
  public UserDto getUser(Map<String, Object> map);
  public LeaveUserDto getLeaveUser(Map<String, Object> map);
  public InactiveUserDto getInactiveUser(Map<String, Object> map);
  public int insertUser(UserDto user);
  public int insertAccess(String email);
}