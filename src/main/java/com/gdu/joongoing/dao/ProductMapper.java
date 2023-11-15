package com.gdu.joongoing.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.joongoing.dto.ProductDto;
import com.gdu.joongoing.dto.ProductImageDto;

@Mapper
public interface ProductMapper {
  public int insertProduct(ProductDto product);

  /* public int insertProductImage(ProductImageDto productImage); */
  public int getProductCount();
  public List<ProductDto> getProductList(Map<String, Object> map);  // 매퍼.xml 에서는 ProductMap 으로 적었지만, 자바가 인식하기는 ProductDto로 인식한다.
  public ProductDto getProduct(int productNo);
  public List<ProductImageDto> getProductImageList(int imageNo);
  public ProductImageDto getProductImage(int imageNo);
  public int updateProduct(ProductDto product);
  public int deleteProductImage(int imageNo);
  public int deleteProduct(int productNo);
  public List<ProductDto> getHotList(Map<String, Object> map);
  
}