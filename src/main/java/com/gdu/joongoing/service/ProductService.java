package com.gdu.joongoing.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.joongoing.dto.ProductDto;

public interface ProductService {
  public boolean addProduct(MultipartHttpServletRequest multipartRequest) throws Exception; 
  public Map<String, Object> getProductList(HttpServletRequest request);
  public void loadProduct(HttpServletRequest request, Model model); // 상세보기
  public void removeTempFiles();
  public ProductDto getProduct(int productNo);
  public int modifyProduct(ProductDto product);
  public Map<String, Object> getProductImageList(HttpServletRequest request);
  public Map<String, Object> removeProductImage(HttpServletRequest request);
  public int removeProduct(int productNo);
  public Map<String, Object> getInterestList(HttpServletRequest request);
  public Map<String, Object> getSearchProductList(HttpServletRequest request);

  public void addSearch(HttpServletRequest request, Model model);
  
  public Map<String, Object> addProductComment(HttpServletRequest request);
  public Map<String, Object> getHotList(HttpServletRequest request);
  public Map<String, Object> loadProductCommentList(HttpServletRequest request);
  public Map<String, Object> addProductCommentReply(HttpServletRequest request);
  public Map<String, Object> removeProductComment(int commentNo);
  
}