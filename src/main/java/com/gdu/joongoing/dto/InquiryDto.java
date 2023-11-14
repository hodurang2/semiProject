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
  private int answerNo;
  private int inquiryNo;
  private String contents;
  private Timestamp createdAt;
  private int depth;
  private int status;
  private int groupNo;
  
}
