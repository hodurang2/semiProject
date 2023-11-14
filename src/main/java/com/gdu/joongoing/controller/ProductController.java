package com.gdu.joongoing.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.joongoing.dto.ProductDto;
import com.gdu.joongoing.service.ProductService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class ProductController {
  
  private final ProductService productService;
  
  @GetMapping("/header.do")
  public String header() {
    return "layout/header";
  }
  
  @GetMapping("/product/list.do")
  public String list() {
    return "product/list";
  }
  
  @GetMapping("/product/write.form")
  public String write() {
    return "product/write";
  }
  
  @PostMapping("/product/add.do")
  public String add(MultipartHttpServletRequest multipartRequest
                  , RedirectAttributes redirectAttributes) throws Exception {
    boolean addResult = productService.addProduct(multipartRequest);
    redirectAttributes.addFlashAttribute("addResult", addResult);
    return "redirect:/product/list.do";
  }
 
  @ResponseBody
  @GetMapping(value="/getList.do", produces="application/json")
  public Map<String, Object> getList(HttpServletRequest request){
    return productService.getProductList(request);
  }
  
  @GetMapping("/detail.do")
  public String detail(HttpServletRequest request, Model model) {
    productService.loadProduct(request, model);
    return "product/detail";
  }
  
  @GetMapping("/edit.form")
  public String edit(@RequestParam(value="productNo", required=false, defaultValue="0") int productNo
                   , Model model) {
    model.addAttribute("product", productService.getProduct(productNo));
    return "product/edit";
  }
  
  @PostMapping("/modify.do")
  public String modify(ProductDto product, RedirectAttributes redirectAttributes) {
    int modifyResult = productService.modifyProduct(product);
    redirectAttributes.addFlashAttribute("modifyResult", modifyResult);
    return "redirect:/product/detail.do?productNo=" + product.getProductNo();  // 상세보기를 하고 싶으면 uploadNo를 전달.
  }
  
  @ResponseBody
  @GetMapping(value="/getProductImageList.do", produces="application/json")
  public Map<String, Object> getProductImageList(HttpServletRequest request) {
    return productService.getProductImageList(request);
  }
  
  @ResponseBody
  @PostMapping(value="/removeProductImage.do", produces="application/json")
  public Map<String, Object> removeProductImage(HttpServletRequest request) {
    return productService.removeProductImage(request);  
  }
  
  @ResponseBody
  @PostMapping(value="/addProductImage.do", produces="application/json")
  public Map<String, Object> addProductImage(MultipartHttpServletRequest multipartRequest) throws Exception {
    return productService.addProductImage(multipartRequest);
  }
  
  @PostMapping("/removeProduct.do")
  public String removeProduct(@RequestParam(value = "productNo", required = false, defaultValue = "0") int productNo
                        , RedirectAttributes redirectAttributes) {
    int removeResult = productService.removeProduct(productNo);
    redirectAttributes.addFlashAttribute("removeResult", removeResult);
    return "redirect:/product/header.do";
  }
    
}
