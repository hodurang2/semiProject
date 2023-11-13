package com.gdu.joongoing.service;

import org.springframework.stereotype.Service;

import com.gdu.joongoing.dao.ProductMapper;
import com.gdu.joongoing.util.MyFileUtils;
import com.gdu.joongoing.util.MyPageUtils;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ProductServiceImpl implements ProductService {
  private final ProductMapper ProductMapper;  // 매퍼 이용할 용도
  private final MyFileUtils myFileUtils;    // 파일첨부할 용도
  private final MyPageUtils myPageUtils;    // 목록 다룰 용도
  
}
