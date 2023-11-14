package com.gdu.joongoing.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class NoticeAttachDto {
  private int attachNo;
  private int noticeNo;
  private String path;
  private String filesystemName;
}
