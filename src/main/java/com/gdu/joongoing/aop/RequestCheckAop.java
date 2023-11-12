package com.gdu.joongoing.aop;

import java.util.Arrays;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Aspect
@Component
public class RequestCheckAop {

  @Pointcut("execution(* com.gdu.joongoing.controller.*Controller.*(..))")
  public void setPointCut() { }
  
  @Around("setPointCut()")
  public Object aroundAdvice(ProceedingJoinPoint proceedingJoinPoint) throws Throwable {
    
    ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes)RequestContextHolder.getRequestAttributes();
    HttpServletRequest request = servletRequestAttributes.getRequest();
    
    Map<String, String[]> map = request.getParameterMap();
    String params = "";
    if(map.isEmpty()) {
      params += "No Parameter";
    } else {
      for(Map.Entry<String, String[]> entry : map.entrySet()) {
        params += entry.getKey() + ":" + Arrays.toString(entry.getValue()) + " ";
      }
    }
    
    log.info("==================================================================");
    log.info("{} {}", request.getMethod(), request.getRequestURI());
    log.info("{}", params);    
    
    Object obj = proceedingJoinPoint.proceed();

    log.info("==================================================================\n");      // 포인트컷 실행 이전에 실행(@Before 이전에 동작)
    
    return obj;
    
  }
}
