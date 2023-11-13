package com.gdu.joongoing.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class ProductImageDto {
  private int imageNo;
  private int productNo;
  private String path;
  private String filesystemName;
  private String imageOriginalName;
  private int hasThumbnail;
}