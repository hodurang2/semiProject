package com.gdu.joongoing.service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.gdu.joongoing.dao.InquiryMapper;
import com.gdu.joongoing.dto.InquiryDto;
import com.gdu.joongoing.util.MyFileUtils;
import com.gdu.joongoing.util.MyPageUtils;

import lombok.RequiredArgsConstructor;

@Transactional
@RequiredArgsConstructor
@Service
public class InquiryServiceImpl implements InquiryService{
  
  private final InquiryMapper inquiryMapper;
  private final MyFileUtils myFileUtils;
  private final MyPageUtils myPageUtils;

  @Transactional(readOnly=true)
  @Override
  public void loadInquiryList(HttpServletRequest request, Model model) {
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int total = inquiryMapper.getBlogCount();
    int display = 10;
    
    myPageUtils.setPaging(page, total, display);
    
    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
                                   , "end", myPageUtils.getEnd());
    
    List<InquiryDto> blogList = inquiryMapper.getInquiryList(map);
    
    model.addAttribute("blogList", blogList);
    model.addAttribute("paging", myPageUtils.getMvcPaging(request.getContextPath() + "/blog/list.do"));
    model.addAttribute("beginNo", total - (page - 1) * display);
    
    
  }
  
}
