package com.gdu.joongoing.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.joongoing.dto.InquiryDto;

@Mapper
public interface InquiryMapper {

  public int getBlogCount();

  public List<InquiryDto> getInquiryList(Map<String, Object> map);

  
  

}
