package com.gdu.joongoing.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.joongoing.dto.UserDto;

@Mapper
public interface MypageMapper {
  public UserDto getUser2(Map<String, Object> map);
  public int updateUserPw(UserDto user);
  public int updateUserInterest(UserDto user);
  public int updateUser(UserDto user);
}
