package com.gdu.joongoing.dao;

import java.util.List;
import java.util.Map;

import com.gdu.joongoing.dto.InquiryDto;

public interface InquiryMapper {

  int getBlogCount();

  List<InquiryDto> getInquiryList(Map<String, Object> map);

  
  

}
