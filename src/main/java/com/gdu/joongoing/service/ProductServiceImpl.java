package com.gdu.joongoing.service;

import java.io.File;
import java.nio.file.Files;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.joongoing.dao.ProductMapper;
import com.gdu.joongoing.dto.CategoryDto;
import com.gdu.joongoing.dto.ProductDto;
import com.gdu.joongoing.dto.ProductImageDto;
import com.gdu.joongoing.dto.UserDto;
import com.gdu.joongoing.util.MyFileUtils;
import com.gdu.joongoing.util.MyPageUtils;

import lombok.RequiredArgsConstructor;
import net.coobird.thumbnailator.Thumbnails;

@RequiredArgsConstructor
@Service
public class ProductServiceImpl implements ProductService {
  private final ProductMapper productMapper;  // 매퍼 이용할 용도
  private final MyFileUtils myFileUtils;      // 파일첨부할 용도
  private final MyPageUtils myPageUtils;      // 목록 다룰 용도
  
  
  @Override
  public int addProduct(MultipartHttpServletRequest multipartRequest) throws Exception {

    String productName = multipartRequest.getParameter("productName");
    int categoryId = Integer.parseInt(multipartRequest.getParameter("categoryId"));
    int productPrice = Integer.parseInt(multipartRequest.getParameter("productPrice"));
    String tradeAddress = multipartRequest.getParameter("tradeAddress");
    String productInfo = multipartRequest.getParameter("productInfo");
    int sellerNo = Integer.parseInt(multipartRequest.getParameter("userNo"));
    
    ProductDto product = ProductDto.builder()
        .productName(productName)
        .categoryDto(CategoryDto.builder()
                     .categoryId(categoryId)
                     .build())
        .productPrice(productPrice)
        .tradeAddress(tradeAddress)
        .productInfo(productInfo)
        .sellerDto(UserDto.builder()
            .userNo(sellerNo)
            .build())
        .build();
    
    int productCount = productMapper.insertProduct(product);
    System.out.println(productCount);
    /* 이미지버튼 파일첨부기능 만들고 이거 주석해제하면 됨.
     * List<MultipartFile> files = multipartRequest.getFiles("files");
     * 
     * 
     * 
     * int productImageCount; if(files.get(0).getSize() == 0) { // 첨부가 없었으면,
     * productImageCount = 1; } else { productImageCount = 0; }
     * 
     * for(MultipartFile multipartFile : files) {
     * 
     * if(multipartFile != null && !multipartFile.isEmpty()) {
     * 
     * String path = myFileUtils.getUploadPath(); File dir = new File(path);
     * if(!dir.exists()) { dir.mkdirs(); }
     * 
     * String imageOriginalName = multipartFile.getOriginalFilename(); String
     * filesystemName = myFileUtils.getFilesystemName(imageOriginalName); File file
     * = new File(dir, filesystemName);
     * 
     * multipartFile.transferTo(file);
     * 
     * String contentType = Files.probeContentType(file.toPath()); int hasThumbnail
     * = (contentType != null && contentType.startsWith("image")) ? 1 : 0;
     * 
     * if(hasThumbnail == 1) { File thumbnail = new File(dir, "s_" +
     * filesystemName); Thumbnails.of(file) .size(100, 100) .toFile(thumbnail); }
     * 
     * ProductImageDto productImage = ProductImageDto.builder() .path(path)
     * .imageOriginalName(imageOriginalName) .filesystemName(filesystemName)
     * .hasThumbnail(hasThumbnail) .productNo(product.getProductNo()) .build();
     * 
     * productImageCount += productMapper.insertProductImage(productImage);
     * 
     * } // if
     * 
     * } // for
        
    return (productCount == 1) && (files.size() == productImageCount);   // 1이면 성공. productImageCount와 파일사이즈가 같으면 성공. 
    */
    return productMapper.insertProduct(product);
  }

  @Transactional(readOnly=true)
  @Override
  public Map<String, Object> getProductList(HttpServletRequest request) {

    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int total = productMapper.getProductCount();
    int display = 9;
    
    myPageUtils.setPaging(page, total, display);
    
    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
                                   , "end", myPageUtils.getEnd());
    
    List<ProductDto> productList = productMapper.getProductList(map);
    
    return Map.of("productList", productList
                , "totalPage", myPageUtils.getTotalPage());
    
  }
  
  @Transactional(readOnly=true)
  @Override
  public void loadProduct(HttpServletRequest request, Model model) {
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("productNo"));
    int productNo = Integer.parseInt(opt.orElse("0"));  // productNo는 정수변환이 필요하니까 파스인트쓰고, 전달이 안됐을 때는 0을 사용한다.
    
    // 게시판내용 + 첨부된 첨부파일목록 2가지를 가지고 컨트롤러로 넘긴다.
    model.addAttribute("product", productMapper.getProduct(productNo));               // 게시판내용
    model.addAttribute("ProductList", productMapper.getProductImageList(productNo));  // 첨부내역
    
  }
  
  @Override
  public void removeTempFiles() {
    File tempDir = new File(myFileUtils.getTempPath());
    File[] targetList = tempDir.listFiles();
    if(targetList != null) {
      for(File target : targetList) {
        target.delete();
      }
    }
  }
  
  @Transactional(readOnly=true)
  @Override
  public ProductDto getProduct(int productNo) {
    return productMapper.getProduct(productNo);
  }
  
  @Override
  public int modifyProduct(ProductDto product) {
    return productMapper.updateProduct(product);
  }
  
  @Override
  public Map<String, Object> getProductImageList(HttpServletRequest request) {
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("productNo"));
    int imageNo = Integer.parseInt(opt.orElse("0"));
    
    return Map.of("productImageList", productMapper.getProductImageList(imageNo));
    
  }
  
  @Override
  public Map<String, Object> removeProductImage(HttpServletRequest request) {
    Optional<String> opt = Optional.ofNullable(request.getParameter("imageNo"));
    int imageNo = Integer.parseInt(opt.orElse("0"));

    // 상품이미지 삭제
    ProductImageDto productImage = productMapper.getProductImage(imageNo);
    File file = new File(productImage.getPath(), productImage.getFilesystemName());
    if(file.exists()) {
      file.delete();
    }
    
    // 상품 썸네일 삭제
    if(productImage.getHasThumbnail() == 1) {
      File thumbnail = new File(productImage.getPath(), "s_" + productImage.getFilesystemName());
      if(thumbnail.exists()) {
        thumbnail.delete();
      }
    }
    
    // PRODUCT_IMAGE 테이블 삭제
    int removeResult = productMapper.deleteProductImage(imageNo);
    
    return Map.of("removeResult", removeResult);
  }
    
  @Override
  public Map<String, Object> addProductImage(MultipartHttpServletRequest multipartRequest) throws Exception {
    
    List<MultipartFile> files =  multipartRequest.getFiles("files");
    
    int productImageCount;
    if(files.get(0).getSize() == 0) {
      productImageCount = 1;
    } else {
      productImageCount = 0;
    }
    
    for(MultipartFile multipartFile : files) {
      
      if(multipartFile != null && !multipartFile.isEmpty()) {
        
        String path = myFileUtils.getUploadPath();
        File dir = new File(path);
        if(!dir.exists()) {
          dir.mkdirs();
        }
        
        String imageOriginalName = multipartFile.getOriginalFilename();
        String filesystemName = myFileUtils.getFilesystemName(imageOriginalName);
        File file = new File(dir, filesystemName);
        
        multipartFile.transferTo(file);
        
        String contentType = Files.probeContentType(file.toPath());
        int hasThumbnail = (contentType != null && contentType.startsWith("image")) ? 1 : 0;
        
        if(hasThumbnail == 1) {
          File thumbnail = new File(dir, "s_" + filesystemName);
          Thumbnails.of(file)
                    .size(100, 100)      // 가로 100px, 세로 100px
                    .toFile(thumbnail);
        }
        
        ProductImageDto productImage = ProductImageDto.builder()
                            .path(path)
                            .imageOriginalName(imageOriginalName)
                            .filesystemName(filesystemName)
                            .hasThumbnail(hasThumbnail)
                            .productNo(Integer.parseInt(multipartRequest.getParameter("productNo")))
                            .build();
        
        productImageCount += productMapper.insertProductImage(productImage);
        
      }
      
    }
    
    return Map.of("productImageResult", files.size() == productImageCount);
    
  }
  
  @Override
  public int removeProduct(int productNo) {
    
    // 파일 삭제
    List<ProductImageDto> productImageList = productMapper.getProductImageList(productNo);
    for(ProductImageDto productImage : productImageList) {
      
      File file = new File(productImage.getPath(), productImage.getFilesystemName());
      if(file.exists()) {
        file.delete();
      }
      
      // 썸네일 삭제
      if(productImage.getHasThumbnail() == 1) {
        File thumbnail = new File(productImage.getPath(), "s_" + productImage.getFilesystemName());
        if(thumbnail.exists()) {
          thumbnail.delete();
        }
      }
      
    }
    
    // PRODUCT_T 삭제
    return productMapper.deleteProduct(productNo);
    
  }

  
  @Transactional(readOnly=true)
  @Override
  public Map<String, Object> getHotList(HttpServletRequest request) {
  
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int total = productMapper.getProductCount();
    int display = 9;
    
    myPageUtils.setPaging(page, total, display);
    
    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
                                     ,"end", myPageUtils.getEnd());
    
    List<ProductDto> hotList = productMapper.getHotList(map);
    
    return Map.of("hotList", hotList
                  ,"totalPage", myPageUtils.getTotalPage());
  }
  
  
}