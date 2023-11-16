package com.gdu.joongoing.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.joongoing.dto.ProductCommentDto;
import com.gdu.joongoing.dto.ProductDto;
import com.gdu.joongoing.dto.ProductImageDto;

@Mapper
public interface ProductMapper {
  public int getProductNo(int sellerNo);
  public int insertProduct(ProductDto product);
  public int insertProductImage(ProductImageDto productImage);
  public int getProductCount();
  public List<ProductDto> getProductList(Map<String, Object> map);  // 매퍼.xml 에서는 ProductMap 으로 적었지만, 자바가 인식하기는 ProductDto로 인식한다.
  public List<ProductDto> getInterestList(Map<String, Object> map);  // 매퍼.xml 에서는 ProductMap 으로 적었지만, 자바가 인식하기는 ProductDto로 인식한다.
  public List<ProductDto> getSearchList(Map<String, Object> map); 
  public ProductDto getProduct(int productNo);
  public List<ProductImageDto> getProductImageList(int productNo);
  public ProductImageDto getProductImage(int imageNo);
  public int updateProduct(ProductDto product);
  public int deleteProductImage(int imageNo);
  public int deleteProduct(int productNo);

  public int insertProductComment(ProductCommentDto productCommentDto);
  public List<ProductDto> getHotList(Map<String, Object> map);
  public int getProductCommentCount(int productNo);
  public List<ProductCommentDto> getProductCommentList(Map<String, Object> map);
  public int insertProductCommentReply(ProductCommentDto productCommentDto);
  public int deleteProductComment(int commentNo);
}
  