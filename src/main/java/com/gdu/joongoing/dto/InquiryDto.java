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
  int answerNo;
  int inquiryNo;
  String contents;
  Timestamp createdAt;
  int depth;
  int status;
  int groupNo;
  
}
