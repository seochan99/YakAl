package com.viewpharm.yakal.common.jwt.filter;

import com.viewpharm.yakal.common.Constants;
import com.viewpharm.yakal.common.exception.type.ErrorCode;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.UnsupportedJwtException;
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
        } catch (SecurityException e) {
            log.error("FilterException throw SecurityException Exception : {}", e.getMessage());
            request.setAttribute("exception", ErrorCode.ACCESS_DENIED_ERROR);
        } catch (MalformedJwtException e) {
            log.error("FilterException throw MalformedJwtException Exception : {}", e.getMessage());
            request.setAttribute("exception", ErrorCode.TOKEN_MALFORMED_ERROR);
        } catch (IllegalArgumentException e) {
            log.error("FilterException throw IllegalArgumentException Exception : {}", e.getMessage());
            request.setAttribute("exception", ErrorCode.TOKEN_TYPE_ERROR);
        } catch (ExpiredJwtException e) {
            log.error("FilterException throw ExpiredJwtException Exception : {}", e.getMessage());
            request.setAttribute("exception", ErrorCode.TOKEN_EXPIRED_ERROR);
        } catch (UnsupportedJwtException e) {
            log.error("FilterException throw UnsupportedJwtException Exception : {}", e.getMessage());
            request.setAttribute("exception", ErrorCode.TOKEN_UNSUPPORTED_ERROR);
        } catch (JwtException e) {
            log.error("FilterException throw JwtException Exception : {}", e.getMessage());
            request.setAttribute("exception", ErrorCode.TOKEN_UNKNOWN_ERROR);
        } catch (Exception e) {
            log.error("FilterException throw Exception Exception : {}", e.getMessage());
            request.setAttribute("exception", ErrorCode.NOT_FOUND_USER);
        }

        filterChain.doFilter(request, response);
    }

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) {
        for (String noNeedAuthUrlRegex : Constants.NO_NEED_AUTH_URLS_REGEX) {
            if (request.getRequestURI().matches(noNeedAuthUrlRegex)) {
                return true;
            }
        }

        return false;
    }
}
