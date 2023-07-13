package com.viewpharm.yakal.service;

import com.viewpharm.yakal.Oauth2Util;
import com.viewpharm.yakal.common.ErrorCode;
import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.domain.LoginProvider;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.domain.UserRole;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.security.jwt.JwtProvider;
import com.viewpharm.yakal.security.jwt.JwtToken;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.Random;

@Slf4j
@Service
@RequiredArgsConstructor
public class AuthenticationService {
    private final UserRepository userRepository;
    private final Oauth2Util oauth2Util;
    private final JwtProvider jwtProvider;

    public String getRedirectUrl(LoginProvider loginProvider) {
        switch (loginProvider) {
            case KAKAO -> {
                return oauth2Util.getKakaoRedirectUrl();
            }
            case GOOGLE -> {
//                return oauth2Util.getGoogleRedirectUrl();
            }
            case APPLE -> {
//                return oauth2Util.getAppleRedirectUrl();
            }
        }
        return null;
    }

    public JwtToken login(String authorizationAccessToken, LoginProvider loginProvider) {
        // Load User Data in Oauth Server
        String accessToken = null;
        String socialId = null;
        switch (loginProvider) {
            case KAKAO -> {
                socialId = oauth2Util.getKakaoUserInformation(authorizationAccessToken);
            }
            case GOOGLE -> {
            }
            case APPLE -> {
            }
        }

        // User Data 존재 여부 확인
        if (socialId == null) { throw new CommonException(ErrorCode.NOT_FOUND_USER); }

        // User 탐색
        Optional<User> user = userRepository.findBySocialIdAndProvider(socialId, loginProvider);
        User loginUser = null;

        // 기존 유저가 아니라면 새로운 Data 저장, 기존 유저라면 Load
        if (user.isEmpty()) {
            loginUser = userRepository.save(User.builder()
                    .socialId(socialId)
                    .provider(loginProvider)
                    .role(UserRole.USER)
                    .build());
        } else {
            loginUser = user.get();
        }

        // JwtToken 생성, 기존 Refresh Token 탐색
        JwtToken jwtToken = jwtProvider.createTotalToken(loginUser.getId(), loginUser.getRole());
        loginUser.setRefreshToken(jwtToken.getRefresh_token());
        loginUser.setIsLogin(true);

        // Jwt 반환
        return jwtToken;
    }
}
