package com.gdu.second.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MvcController {

  @GetMapping({"/", "/index.do"})
  public String main() {
    return "/index";
  }
  
}