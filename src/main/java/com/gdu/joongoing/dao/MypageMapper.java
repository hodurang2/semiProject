package com.gdu.joongoing.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.joongoing.dto.ProductDto;
import com.gdu.joongoing.dto.UserDto;

@Mapper
public interface MypageMapper {
  public UserDto getUser2(Map<String, Object> map);
  public int updateUserPw(UserDto user);
  public int updateUserInterest(UserDto user);
  public int updateUser(UserDto user);
  
  // 판매목록
  public int getSalesCount(int sellerNo);
  public List<ProductDto> getSalesList(Map<String, Object> map);

  // 구매목록
  public int getPurchaseCount(int buyerNo);
  public List<ProductDto> getPurchaseList(Map<String, Object> map);
  
  // 구매상품 리뷰
  public ProductDto getPurchaseProduct(int productNo);
  public int updateReview(ProductDto purchaseProduct);
  
}
