package com.gdu.joongoing.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class InquiryAttachDto {
  private int attachNo;
  private int inquiryNo;
  private String path;
  private String filesystemName;
}
