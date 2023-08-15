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
    public JwtTokenDto login(final String authorizationAccessToken, final ELoginProvider loginProvider) {
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
                .orElseGet(() -> mobileUserRepository.save(new MobileUser(finalSocialId, loginProvider, ERole.ROLE_MOBILE, defaultName)));

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
}
