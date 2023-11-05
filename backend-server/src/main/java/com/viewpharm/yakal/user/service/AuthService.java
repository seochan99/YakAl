package com.viewpharm.yakal.user.service;

import com.viewpharm.yakal.prescription.domain.Prescription;
import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.prescription.repository.PrescriptionRepository;
import com.viewpharm.yakal.common.security.JwtProvider;
import com.viewpharm.yakal.base.type.EImageUseType;
import com.viewpharm.yakal.base.type.ELoginProvider;
import com.viewpharm.yakal.user.repository.UserRepository;
import com.viewpharm.yakal.base.type.EPlatform;
import com.viewpharm.yakal.base.type.ERole;
import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.exception.ErrorCode;
import com.viewpharm.yakal.common.JwtTokenDto;
import com.viewpharm.yakal.base.utils.OAuth2Util;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDate;
import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final JwtProvider jwtProvider;
    private final OAuth2Util oAuth2Util;
    private final PrescriptionRepository prescriptionRepository;

    @Value("${spring.image.path}")
    private String FOLDER_PATH;

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
                assert (true) : "Invalid Type Error";
            }
        }

        final Map<String, String> urlMap = new HashMap<>(1);
        urlMap.put("url", url);

        return urlMap;
    }

    @Transactional
    public JwtTokenDto login(final String accessToken, final ELoginProvider loginProvider, final ERole role) throws CommonException {
        String socialId = null;

        switch (loginProvider) {
            case KAKAO -> {
                socialId = oAuth2Util.getKakaoUserInformation(accessToken);
            }
            case GOOGLE -> {
                socialId = oAuth2Util.getGoogleUserInformation(accessToken);
            }
            case APPLE -> {
                socialId = oAuth2Util.getAppleUserInformation(accessToken);
            }
            default -> {
                assert (false) : "Invalid Type Error";
            }
        }

        if (socialId == null) {
            throw new CommonException(ErrorCode.NOT_FOUND_USER);
        }

        final String finalSocialId = socialId;

        Optional<User> userOpt = userRepository.findBySocialIdAndLoginProvider(socialId, loginProvider);

        User user = null;

        if (userOpt.isEmpty()) {
            user = userRepository.save(
                    new User(finalSocialId, loginProvider, role));

            List<Prescription> prescriptionList = new ArrayList<>();
            prescriptionList.add(prescriptionRepository.save(
                    Prescription.builder()
                            .user(user)
                            .pharmacyName("default")
                            .prescribedDate(LocalDate.now())
                            .build()));

            user.setPrescriptions(prescriptionList);
        } else {
            user = userOpt.get();
        }

        final JwtTokenDto jwtTokenDto = jwtProvider.createTotalToken(user.getId(), user.getRole(), role == ERole.ROLE_WEB ? EPlatform.WEB : EPlatform.MOBILE);
        user.setRefreshToken(jwtTokenDto.getRefreshToken());
        user.setIsLogin(true);

        if (user.getName() == null) {
            user.setName("user#" + String.format("%06d", user.getId()));
        }

        return jwtTokenDto;
    }

    @Transactional
    public void logout(final Long userId) {
        final User user = userRepository.findByIdAndIsLoginAndRefreshTokenIsNotNull(userId, true)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        user.logout();
    }

    @Transactional
    public JwtTokenDto reissue(final String refreshToken, final EPlatform platform) {
        return jwtProvider.reissue(refreshToken, platform);
    }

    public void sendRedirectWithTokenCookieAdded(
            final JwtTokenDto jwtTokenDto,
            final HttpServletResponse response,
            final ELoginProvider loginProvider
    ) throws IOException {
        final String FRONTEND_HOST = "https://localhost:5173"; // Front Server Host -> 배포 시 변경

        final Cookie refreshTokenSecureCookie = new Cookie("refreshToken", jwtTokenDto.getRefreshToken());
        refreshTokenSecureCookie.setPath("/");
        refreshTokenSecureCookie.setHttpOnly(true);
        refreshTokenSecureCookie.setSecure(true);
        refreshTokenSecureCookie.setMaxAge(jwtProvider.getWebRefreshTokenExpirationSecond());

        final Cookie accessTokenCookie = new Cookie("accessToken", jwtTokenDto.getAccessToken());
        accessTokenCookie.setPath("/");

        response.addCookie(refreshTokenSecureCookie);
        response.addCookie(accessTokenCookie);

        response.sendRedirect(FRONTEND_HOST + "/login/social/" + loginProvider.toString().toLowerCase());
    }

    public EPlatform getPlatform(Long userId) {
        final User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        log.info("{}", user.getRole());

        return user.getRole().equals(ERole.ROLE_WEB) ? EPlatform.WEB : EPlatform.MOBILE;
    }
}