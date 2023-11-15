package com.gdu.joongoing.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.joongoing.dto.AnswerDto;
import com.gdu.joongoing.dto.InquiryDto;

@Mapper
public interface InquiryMapper {

  public int getInquiryCount();
  public List<InquiryDto> getInquiryList(Map<String, Object> map);
  public InquiryDto getInquiry(int inquiryNo);
  public int insertInquiry(InquiryDto inquiry);
  
  public int insertAnswer(AnswerDto answer);
  public int getAnswerCount(int inquiryNo);
  public List<AnswerDto> getAnswerList(Map<String, Object> map);
  public int insertAnswerReply(AnswerDto answer);
  
  
}
