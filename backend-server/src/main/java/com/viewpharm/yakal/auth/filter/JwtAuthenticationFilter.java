package com.viewpharm.yakal.auth.filter;

import com.viewpharm.yakal.auth.domain.UserPrincipal;
import com.viewpharm.yakal.auth.service.JwtProvider;
import com.viewpharm.yakal.auth.service.UserDetailServiceForLoad;
import com.viewpharm.yakal.base.constants.Constants;
import com.viewpharm.yakal.base.exception.CommonException;
import com.viewpharm.yakal.base.exception.ErrorCode;
import com.viewpharm.yakal.base.type.ERole;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Slf4j
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtProvider jwtProvider;
    private final UserDetailServiceForLoad userDetailsService;

    public JwtAuthenticationFilter(final JwtProvider jwtProvider, final UserDetailServiceForLoad userDetailsService) {
        this.jwtProvider = jwtProvider;
        this.userDetailsService = userDetailsService;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ExpiredJwtException, JwtException, ServletException, IOException {
        final String token = jwtProvider.refineToken(request);
        final Claims claims = jwtProvider.validateToken(token);

        final String id = claims.get(Constants.USER_ID_CLAIM_NAME).toString();
        final ERole role = ERole.valueOf(claims.get(Constants.USER_ROLE_CLAIM_NAME).toString());

        final UserPrincipal userDetails = (UserPrincipal) userDetailsService.loadUserByUsername(id);
        final SimpleGrantedAuthority authority = (SimpleGrantedAuthority) userDetails.getAuthorities().iterator().next();

        if (role != ERole.valueOf(authority.getAuthority())) {
            throw new CommonException(ErrorCode.ACCESS_DENIED_ERROR);
        }

        final UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
                userDetails, null, userDetails.getAuthorities());
        authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

        final SecurityContext securityContext = SecurityContextHolder.createEmptyContext();
        securityContext.setAuthentication(authentication);
        SecurityContextHolder.setContext(securityContext);

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