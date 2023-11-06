package com.viewpharm.yakal.base.filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Slf4j
@Order(1)
@Component
public class GlobalLoggerFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        log.info("[Global] HTTP Request Received! ({} {})", request.getMethod(), request.getRequestURI());

        request.setAttribute("INTERCEPTOR_PRE_HANDLE_TIME",  System.currentTimeMillis());

        filterChain.doFilter(request, response);

        final long preHandleTime = (long) request.getAttribute("INTERCEPTOR_PRE_HANDLE_TIME");
        final long processedTime = System.currentTimeMillis() - preHandleTime;

        log.info("[Global] HTTP Request Has Been Processed! It Tokes {}ms. ({} {})", processedTime, request.getMethod(), request.getRequestURI());
    }
}
