package com.viewpharm.yakal.common.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Slf4j
public class LoggerInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        log.info("[Global] HTTP Request Received! ({} {})", request.getMethod(), request.getRequestURI());

        final long currentTime = System.currentTimeMillis();
        request.setAttribute("INTERCEPTOR_PRE_HANDLE_TIME", currentTime);

        return HandlerInterceptor.super.preHandle(request, response, handler);
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        final long currentTime = System.currentTimeMillis();
        final long preHandleTime = (long) request.getAttribute("INTERCEPTOR_PRE_HANDLE_TIME");

        final long processedTime = currentTime - preHandleTime;

        log.info("[Global] HTTP Request Has Been Processed! It Tokes {}ms. ({} {})", processedTime, request.getMethod(), request.getRequestURI());

        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
    }
}
