package com.gdu.joongoing.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class ProductCommentDto {
  private int commentNo;
  private int productNo ;
  private int userNo;
  private String contents;
  private String createdAt;
  private int depth;
  private int groupNo;
  private int status;
}
