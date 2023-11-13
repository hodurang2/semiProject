package com.gdu.joongoing.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.gdu.joongoing.dao.MypageMapper;
import com.gdu.joongoing.dto.UserDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class MypageServiceImpl implements MypageService {

  private final MypageMapper mypageMapper;
  
  @Override
  public UserDto getUser2(String email) {
    return mypageMapper.getUser2(Map.of("email", email));
  }
  
}
