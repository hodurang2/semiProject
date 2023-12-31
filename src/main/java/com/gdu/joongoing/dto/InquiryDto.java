package com.gdu.joongoing.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class InquiryDto {
  private int inquiryNo;
  private String inquiryTitle;
  private String inquiryContent;
  private Timestamp inquiryCreatedAt;
  private UserDto userDto;
  
}
