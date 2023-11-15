package com.gdu.joongoing.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gdu.joongoing.dao.InquiryMapper;
import com.gdu.joongoing.dto.AnswerDto;
import com.gdu.joongoing.dto.InquiryDto;
import com.gdu.joongoing.dto.UserDto;
import com.gdu.joongoing.util.MyPageUtils;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class InquiryServiceImpl implements InquiryService{
  
  private final InquiryMapper inquiryMapper;
  private final MyPageUtils myPageUtils;

  @Override
  public void loadInquiryList(HttpServletRequest request, Model model) {
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int total = inquiryMapper.getInquiryCount();
    int display = 10;
    
    myPageUtils.setPaging(page, total, display);
    
    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
                                   , "end", myPageUtils.getEnd());
    
    List<InquiryDto> inquiryList = inquiryMapper.getInquiryList(map);
    
    model.addAttribute("inquiryList", inquiryList);
    model.addAttribute("paging", myPageUtils.getMvcPaging(request.getContextPath() + "/inquiry/list.do"));
    model.addAttribute("beginNo", total - (page - 1) * display);
    
  }
  
  @Override
  public InquiryDto getInquiry(int inquiryNo, Model model) {
    return inquiryMapper.getInquiry(inquiryNo);
  }
  
  @Override
  public int addInquiry(HttpServletRequest request) {
    
    String title = request.getParameter("title");
    String contents = request.getParameter("contents");
    int userNo = Integer.parseInt(request.getParameter("userNo"));
    
    System.out.println(userNo);
    
    InquiryDto inquiry = InquiryDto.builder()
                          .inquiryTitle(title)
                          .inquiryContent(contents)
                          .userDto(UserDto.builder()
                                    .userNo(userNo)
                                    .build())
                          .build();
                          
    
    int addResult = inquiryMapper.insertInquiry(inquiry);
    
    return addResult;
  }
  
  @Override
  public Map<String, Object> addAnswer(HttpServletRequest request) {
    
    int inquiryNo = Integer.parseInt(request.getParameter("inquiryNo"));
    String contents = request.getParameter("contents");
    
    System.out.println(inquiryNo);
    System.out.println(contents);
    
    AnswerDto answer = AnswerDto.builder()
                          .inquiryNo(inquiryNo)
                          .contents(contents)
                          .build();
    
    int addAnswerResult = inquiryMapper.insertAnswer(answer);
    
    return Map.of("addAnswerResult", addAnswerResult);
  }
    
  @Override
  public Map<String, Object> loadAnswerList(HttpServletRequest request) {
    System.out.println("서비스시작");

    int inquiryNo = Integer.parseInt(request.getParameter("inquiryNo"));
    int page = Integer.parseInt(request.getParameter("page"));
    int total = inquiryMapper.getAnswerCount(inquiryNo);
    System.out.println("문의번호" + inquiryNo);
    System.out.println("댓글개수" + total);
    int display = 10;
    
    myPageUtils.setPaging(page, total, display);
    
    Map<String, Object> map = Map.of("inquiryNo", inquiryNo
                                   , "begin", myPageUtils.getBegin()
                                   , "end", myPageUtils.getEnd());
    
    List<AnswerDto> answerList = inquiryMapper.getAnswerList(map);
    String paging = myPageUtils.getAjaxPaging();
    
    Map<String, Object> result = new HashMap<String, Object>();
    result.put("answerList", answerList);
    result.put("paging", paging);
    return result;
  }
  
  @Override
  public Map<String, Object> addAnswerReply(HttpServletRequest request) {
    String contents = request.getParameter("contents");
    int inquiryNo = Integer.parseInt(request.getParameter("inquiryNo"));
    int groupNo = Integer.parseInt(request.getParameter("groupNo"));
    
    AnswerDto answer = AnswerDto.builder()
                          .inquiryNo(inquiryNo)
                          .contents(contents)
                          .groupNo(groupNo)
                          .build();
    
    int addAnswerReplyResult = inquiryMapper.insertAnswerReply(answer);
    
    return Map.of("addAnswerReplyResult", addAnswerReplyResult);
    
  }
  
  
}
