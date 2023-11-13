package com.gdu.joongoing.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gdu.joongoing.service.MypageService;

import lombok.RequiredArgsConstructor;

@RequestMapping(value="/mypage")
@RequiredArgsConstructor
@Controller
public class MypageController {
  
  private final MypageService mypageService;

}