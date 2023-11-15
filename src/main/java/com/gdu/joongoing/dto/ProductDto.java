package com.gdu.joongoing.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class ProductDto {
  private int productNo;
  private String productName;
  private int productPrice;
  private String productInfo;
  private String productCreatedAt;
  private String productModifiedAt;
  private int hit;
  private int state;
  private String tradeAddress;
  private String reviewContents;
  private int reviewScore;
  private String createdAt;
  private String tradeAt;
  private UserDto sellerDto;
  private UserDto buyerDto;
  private CategoryDto categoryDto;
}
