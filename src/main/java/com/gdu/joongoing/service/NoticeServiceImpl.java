package com.gdu.joongoing.service;

import java.io.File;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.joongoing.dao.NoticeMapper;
import com.gdu.joongoing.dto.NoticeAttachDto;
import com.gdu.joongoing.dto.NoticeDto;
import com.gdu.joongoing.util.MyFileUtils;
import com.gdu.joongoing.util.MyPageUtils;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Transactional
@Service
public class NoticeServiceImpl implements NoticeService{
  private final NoticeMapper noticeMapper;
  private final MyPageUtils myPageUtils;
  private final MyFileUtils myFileUtils;
  
  @Override
  public void loadNoticeList(HttpServletRequest request, Model model) {
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int total = noticeMapper.getNoticeCount();
    int display = 10;
    
    
    myPageUtils.setPaging(page, total, display);
    
    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
                                   , "end", myPageUtils.getEnd());
    
    List<NoticeDto> noticeList = noticeMapper.getNoticeList(map);
    
    Timestamp today = new Timestamp(System.currentTimeMillis());
    
    model.addAttribute("today", today);
    model.addAttribute("noticeList", noticeList);
    model.addAttribute("paging", myPageUtils.getMvcPaging(request.getContextPath() + "/notice/list.do"));
    model.addAttribute("beginNo", total - (page - 1) * display);
  }
  
  @Override
  public NoticeDto getNotice(int noticeNo, Model model) {
    NoticeDto notice = noticeMapper.getNotice(noticeNo);
    Timestamp today = new Timestamp(System.currentTimeMillis());
    
    model.addAttribute("diffHour", null);
    return notice;
  }
  
  @Override
  public int addNotice(HttpServletRequest request) {
    String title = request.getParameter("title");
    String contents = request.getParameter("contents");
    
    NoticeDto notice = NoticeDto.builder()
                          .title(title)
                          .contents(contents)
                          .build();
    int addResult = noticeMapper.insertNotice(notice);
    
    handleImageAttachments(contents, addResult);
    
    return addResult;
  }
  
  @Override
  public void handleImageAttachments(String contents, int noticeNo) {
    Document document = Jsoup.parse(contents);
    Elements elements = document.getElementsByTag("img");

    if (elements != null) {
        for (Element element : elements) {
            String src = element.attr("src");
            String filesystemName = src.substring(src.lastIndexOf("/") + 1);
            NoticeAttachDto noticeAttach = NoticeAttachDto.builder()
                    .noticeNo(noticeNo)
                    .path(contents)
                    .filesystemName(filesystemName)
                    .build();

            noticeMapper.insertNoticeAttach(noticeAttach);
        }
    }
  }
  @Override
  public Map<String, Object> imageUpload(MultipartHttpServletRequest multipartRequest) {
    
    String imagePath = myFileUtils.getBlogImagePath();
    File dir = new File(imagePath);
    if(!dir.exists()) {
      dir.mkdirs();
    }

    MultipartFile upload = multipartRequest.getFile("upload");
    
    String originalFilename = upload.getOriginalFilename();
    String filesystemName = myFileUtils.getFilesystemName(originalFilename);
    

    File file = new File(dir, filesystemName);
    
    try {
      upload.transferTo(file);
    } catch (Exception e) {
      e.printStackTrace();
    }

    return Map.of("uploaded", true
                , "url", multipartRequest.getContextPath() + imagePath + "/" + filesystemName);
  }
}
