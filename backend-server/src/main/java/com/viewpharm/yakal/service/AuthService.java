package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.MobileUser;
import com.viewpharm.yakal.security.JwtProvider;
import com.viewpharm.yakal.type.ELoginProvider;
import com.viewpharm.yakal.repository.MobileUserRepository;
import com.viewpharm.yakal.type.ERole;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.dto.response.JwtTokenDto;
import com.viewpharm.yakal.utils.OAuth2Util;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Slf4j
@Service
@RequiredArgsConstructor
public class AuthService {

    private final MobileUserRepository mobileUserRepository;
    private final JwtProvider jwtProvider;
    private final OAuth2Util oAuth2Util;

    public Map<String, String> getRedirectUrl(final ELoginProvider loginProvider) {
        String url = null;

        switch (loginProvider) {
            case KAKAO -> {
                url = oAuth2Util.getKakaoRedirectUrl();
            }
            case GOOGLE -> {
                 url = oAuth2Util.getGoogleRedirectUrl();
            }
            case APPLE -> {
                url = oAuth2Util.getAppleRedirectUrl();
            }
            default -> {
                assert (true): "Invalid Type Error";
            }
        }

        final Map<String, String> urlMap = new HashMap<>(1);
        urlMap.put("url", url);

        return urlMap;
    }

    @Transactional
    public JwtTokenDto login(final String authorizationAccessToken, final ELoginProvider loginProvider, final ERole role) {
        String socialId = null;

        switch (loginProvider) {
            case KAKAO -> {
                socialId = oAuth2Util.getKakaoUserInformation(authorizationAccessToken);
            }
            case GOOGLE -> {
                socialId = oAuth2Util.getGoogleUserInformation(authorizationAccessToken);
            }
            case APPLE -> {
                socialId = oAuth2Util.getAppleUserInformation(authorizationAccessToken);
            }
            default -> {
                assert (false): "Invalid Type Error";
            }
        }

        if (socialId == null) {
            throw new CommonException(ErrorCode.NOT_FOUND_USER);
        }

        final String finalSocialId = socialId;

        final Random random = new Random();
        final String defaultName = "user#" + String.format("%06d", random.nextInt(1000000));
        final MobileUser user = mobileUserRepository.findBySocialIdAndLoginProvider(socialId, loginProvider)
                .orElseGet(() -> mobileUserRepository.save(new MobileUser(finalSocialId, loginProvider, role, defaultName)));

        final JwtTokenDto jwtTokenDto = jwtProvider.createTotalToken(user.getId(), user.getRole());
        user.setRefreshToken(jwtTokenDto.getRefreshToken());

        return jwtTokenDto;
    }

    @Transactional
    public void logout(final Long userId) {
        final MobileUser user = mobileUserRepository.findByIdAndIsLoginAndRefreshTokenIsNotNull(userId, true)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        user.logout();
    }

    @Transactional
    public JwtTokenDto reissue(final HttpServletRequest request) {
        return jwtProvider.reissue(request);
    }

    @Transactional
    public JwtTokenDto reissue(final String refreshToken) {
        return jwtProvider.reissue(refreshToken);
    }

    @Deprecated
    @Transactional
    public JwtTokenDto createUser() {
        final Random random = new Random();
        final String defaultName = "user#" + String.format("%06d", random.nextInt(1000000));
        final MobileUser user = mobileUserRepository.save(new MobileUser("0", ELoginProvider.KAKAO, ERole.ROLE_MOBILE, defaultName));

        final JwtTokenDto jwtTokenDto = jwtProvider.createTotalToken(user.getId(), user.getRole());
        user.setRefreshToken(jwtTokenDto.getRefreshToken());

        return jwtTokenDto;
    }

    /**
     * Dev Release 때, Back Test 쉽게 하라고 만든 함수이므로 마지막 Product Release 전에 지울 것
     * 2023-08-15
     * Github: HyungJoonSon
     */
    @Deprecated
    public String getAccessToken(final String authorizationCode, final ELoginProvider provider) {
        String authorizationAccessToken = null;

        switch (provider) {
            case KAKAO -> {
                authorizationAccessToken = oAuth2Util.getKakaoAccessToken(authorizationCode);
            }
            case GOOGLE -> {
                authorizationAccessToken = oAuth2Util.getGoogleAccessToken(authorizationCode);
            }
            case APPLE -> {
                // 애플의 경우 authorizationCode 그대로 accessToken으로 사용
                authorizationAccessToken = authorizationCode;
            }
            default -> {
                assert (false): "Invalid Type Error";
            }
        }

        return authorizationAccessToken;
    }
}
