package com.gdu.joongoing.service;

import java.io.File;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Iterator;
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
    
    int begin = myPageUtils.getBegin();
    int end = myPageUtils.getEnd();
    
    
    Map<String, Object> map = Map.of("begin", begin
                                   , "end", end);
    
    List<NoticeDto> noticeList = noticeMapper.getNoticeList(map);
    
    List<Integer> hour = new ArrayList<>();
    List<Integer> minute = new ArrayList<>();
    List<Integer> num = new ArrayList<>();
    
    for(NoticeDto notice : noticeList){
      hour.add(noticeMapper.getHour(notice.getNoticeNo()));
      minute.add(noticeMapper.getMinute(notice.getNoticeNo()));
      num.add(noticeMapper.getRownum(notice.getNoticeNo()));
    }
    
    
    model.addAttribute("num", num);
    model.addAttribute("noticeMinute", minute);
    model.addAttribute("noticeHour", hour);
    model.addAttribute("noticeList", noticeList);
    model.addAttribute("paging", myPageUtils.getMvcPaging(request.getContextPath() + "/notice/list.do"));
    model.addAttribute("beginNo", total - (page - 1) * display);
  }
  
  @Override
  public NoticeDto getNotice(int noticeNo, Model model) {
    NoticeDto notice = noticeMapper.getNotice(noticeNo);
    
    
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
    

    Document document = Jsoup.parse(contents);
    Elements elements = document.getElementsByTag("img");

    if (elements != null) {
        for (Element element : elements) {
            String src = element.attr("src");
            String filesystemName = src.substring(src.lastIndexOf("/") + 1);
            NoticeAttachDto noticeAttach = NoticeAttachDto.builder()
                    .noticeNo(notice.getNoticeNo())
                    .path(myFileUtils.getBlogImagePath())
                    .filesystemName(filesystemName)
                    .build();

            noticeMapper.insertNoticeAttach(noticeAttach);
        }
    }
    
    return addResult;
  }

  
  @Override
  public Map<String, Object> imageUpload(MultipartHttpServletRequest multipartRequest) {
    
    // 이미지가 저장될 경로
    String imagePath = myFileUtils.getBlogImagePath();
    File dir = new File(imagePath);
    if(!dir.exists()) {
      dir.mkdirs();
    }
    
    // 이미지 파일 (CKEditor는 이미지를 upload라는 이름으로 보냄)
    MultipartFile upload = multipartRequest.getFile("upload");
    
    // 이미지가 저장될 이름
    String originalFilename = upload.getOriginalFilename();
    String filesystemName = myFileUtils.getFilesystemName(originalFilename);
    
    // 이미지 File 객체
    File file = new File(dir, filesystemName);
    
    // 저장
    try {
      upload.transferTo(file);
    } catch (Exception e) {
      e.printStackTrace();
    }
    
    // CKEditor로 저장된 이미지의 경로를 JSON 형식으로 반환해야 함
    return Map.of("uploaded", true
                , "url", multipartRequest.getContextPath() + imagePath + "/" + filesystemName);
  }
  
  @Override
  public int ModifyNotice(HttpServletRequest request) {
    String title = request.getParameter("title");
    String contents = request.getParameter("contents");
    int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
    
    NoticeDto notice = NoticeDto.builder()
                        .title(title)
                        .contents(contents)
                        .noticeNo(noticeNo)
                        .build();
    
    int modifyResult = noticeMapper.updateNotice(notice);
    
    return modifyResult;
  }
  
  @Override
  public int removeNotice(int noticeNo) {
    return noticeMapper.deleteNotice(noticeNo);
  }
}
