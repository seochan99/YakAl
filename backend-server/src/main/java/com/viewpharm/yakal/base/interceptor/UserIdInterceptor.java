package com.viewpharm.yakal.base.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;

@Slf4j
public class UserIdInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        request.setAttribute("USER_ID", authentication.getName());
        return HandlerInterceptor.super.preHandle(request, response, handler);
    }
}