package com.viewpharm.yakal.filter;

import com.viewpharm.yakal.domain.CustomUserDetail;
import com.viewpharm.yakal.service.JwtService;
import com.viewpharm.yakal.service.CustomUserDetailService;
import com.viewpharm.yakal.common.Constants;
import io.jsonwebtoken.Claims;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Slf4j
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtService jwtService;
    private final CustomUserDetailService userDetailsService;

    public JwtAuthenticationFilter(final JwtService jwtService, final CustomUserDetailService userDetailsService) {
        this.jwtService = jwtService;
        this.userDetailsService = userDetailsService;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String token = JwtService.refineToken(request);
        Claims claims = jwtService.validateToken(token);

        String id = claims.get("id").toString();

        CustomUserDetail userDetails = (CustomUserDetail) userDetailsService.loadUserByUsername(id);
        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
                userDetails, null, userDetails.getAuthorities());
        authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

        SecurityContextHolder.getContext().setAuthentication(authentication);

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