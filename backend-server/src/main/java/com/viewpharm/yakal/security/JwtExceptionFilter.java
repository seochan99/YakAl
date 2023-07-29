package com.viewpharm.yakal.security;

import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Slf4j
public class JwtExceptionFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        response.setCharacterEncoding("utf-8");

        try {
            filterChain.doFilter(request, response);
            return;
        } catch (CommonException e) {
            log.error("[JwtExceptionFilter] catch CommonException Exception : {}", e.getMessage());
            request.setAttribute("exception", e.getErrorCode());
        } catch (Exception e) {
            log.error("[JwtExceptionFilter] catch Exception Exception : {}", e.getMessage());
            request.setAttribute("exception", ErrorCode.NOT_FOUND_USER);
        }

        filterChain.doFilter(request, response);
    }

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) {
//        for (String noNeedAuthUrlRegex : Constants.NO_NEED_AUTH_URLS_REGEX) {
//            if (request.getRequestURI().matches(noNeedAuthUrlRegex)) {
//                return true;
//            }
//        }
//
//        return false;
        return true;
    }
}
