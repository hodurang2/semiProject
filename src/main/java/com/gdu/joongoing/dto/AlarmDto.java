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
public class AlarmDto {

  public int alarmNo;
  public String alarmContents;
  public String notifiType;
  public Timestamp createdAt;
  public Timestamp notifiAt;
  public ProductDto productDto;
  public InquiryDto InquiryDto;
  
}
