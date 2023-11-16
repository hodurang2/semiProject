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
public class NoticeDto {
  private int noticeNo;
  private String title;
  private String contents;
  private Timestamp createdAt;
  private int num;
  private int yearAgo;
  private int monthAgo;
  private int dayAgo;
  private int hourAgo;
  private int minuteAgo;
  private int secondAgo;
}
