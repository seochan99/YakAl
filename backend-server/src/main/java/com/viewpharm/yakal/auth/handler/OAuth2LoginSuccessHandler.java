package com.viewpharm.yakal.auth.handler;

import com.viewpharm.yakal.auth.info.OAuth2UserInfo;
import com.viewpharm.yakal.auth.info.factory.OAuth2UserInfoFactory;
import com.viewpharm.yakal.auth.dto.response.JwtTokenDto;
import com.viewpharm.yakal.auth.util.JwtProvider;
import com.viewpharm.yakal.base.type.ELoginProvider;
import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.user.repository.UserRepository;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;

@Slf4j
@Component
@RequiredArgsConstructor
public class OAuth2LoginSuccessHandler implements AuthenticationSuccessHandler {
    private final JwtProvider jwtProvider;
    private final UserRepository userRepository;

    @Override
    @Transactional
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException {
        OAuth2AuthenticationToken authToken = (OAuth2AuthenticationToken) authentication;
        ELoginProvider provider = ELoginProvider.valueOf(authToken.getAuthorizedClientRegistrationId().toUpperCase());

        OidcUser oidcUser = (OidcUser) authentication.getPrincipal();
        OAuth2UserInfo userInfo = OAuth2UserInfoFactory.getOAuth2UserInfo(provider, oidcUser.getAttributes());

        log.info("OAuth2User: {}", userInfo.getId());
        User user = userRepository.findBySocialIdAndLoginProvider(userInfo.getId(), provider)
                .orElseThrow(IllegalArgumentException::new);

        JwtTokenDto jwtTokenDto = jwtProvider.createTotalToken(user.getId(), user.getRole());
        userRepository.updateRefreshToken(user.getId(), jwtTokenDto.refreshToken());
        user.setIsLogin(true);

        final String FRONTEND_HOST = "https://localhost:5173"; // Front Server Host -> 배포 시 변경

        final Cookie refreshTokenSecureCookie = new Cookie("refreshToken", jwtTokenDto.refreshToken());
        refreshTokenSecureCookie.setPath("/");
        refreshTokenSecureCookie.setHttpOnly(true);
        refreshTokenSecureCookie.setSecure(true);
        refreshTokenSecureCookie.setMaxAge(jwtProvider.getWebRefreshTokenExpirationSecond());

        final Cookie accessTokenCookie = new Cookie("accessToken", jwtTokenDto.accessToken());
        accessTokenCookie.setPath("/");

        response.addCookie(refreshTokenSecureCookie);
        response.addCookie(accessTokenCookie);

        response.sendRedirect(FRONTEND_HOST + "/login/social");
    }
}
