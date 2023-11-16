package com.gdu.joongoing.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.joongoing.dto.ProductDto;
import com.gdu.joongoing.service.ProductService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/product")
@RequiredArgsConstructor
@Controller
public class ProductController {
  
  private final ProductService productService;
  
  @GetMapping("/header.do")
  public String header() {
    return "layout/header";
  }
  
  @GetMapping("/list.do")
  public String list() {
    return "product/list";
  }
  
  @GetMapping("/write.form")
  public String write() {
    return "product/write";
  }
  
  @PostMapping("/add.do")
  public String add(MultipartHttpServletRequest multipartRequest
                  , RedirectAttributes redirectAttributes) throws Exception {
    boolean addResult = productService.addProduct(multipartRequest);
    redirectAttributes.addFlashAttribute("addResult", addResult);
    
    return "redirect:/product/list.do";
  }
  
  @ResponseBody
  @GetMapping(value="/getProductList.do", produces="application/json")
  public Map<String, Object> getProductList(HttpServletRequest request){
    return productService.getProductList(request);
  }
  
  @ResponseBody
  @GetMapping(value="/getInterestList.do", produces="application/json")
  public Map<String, Object> getInterestList(HttpServletRequest request){
    System.out.println(request.getParameter("userNo"));
    return productService.getInterestList(request);
  }
  
  @GetMapping(value="/interest_list.do", produces="application/json")
  public String getInterestList(){
    return "product/interest_list";
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
  
  @PostMapping("/removeProduct.do")
  public String removeProduct(@RequestParam(value = "productNo", required = false, defaultValue = "0") int productNo
                        , RedirectAttributes redirectAttributes) {
    int removeResult = productService.removeProduct(productNo);
    redirectAttributes.addFlashAttribute("removeResult", removeResult);
    return "redirect:/product/list.do";
  }

//  @ResponseBody
//  @GetMapping(value = "/hot_list.do", produces="application/json")
//  public Map<String, Object> getHotProductList(HttpServletRequest request){
//    return productService.getHotProductList(request);
//  }


  
}