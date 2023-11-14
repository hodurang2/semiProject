package com.gdu.joongoing.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.joongoing.dto.NoticeDto;


public interface NoticeService {
  public void loadNoticeList(HttpServletRequest request, Model model);
  public NoticeDto getNotice(int noticeNo, Model model);
  public int addNotice(HttpServletRequest request);
  public Map<String, Object> imageUpload(MultipartHttpServletRequest multipartRequest);
  public void handleImageAttachments(String contents, int noticeNo);
}
