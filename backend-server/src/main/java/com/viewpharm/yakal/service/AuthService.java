package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.Image;
import com.viewpharm.yakal.domain.LoginLog;
import com.viewpharm.yakal.domain.Prescription;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.repository.ImageRepository;
import com.viewpharm.yakal.repository.LoginLogRepository;
import com.viewpharm.yakal.repository.PrescriptionRepository;
import com.viewpharm.yakal.security.JwtProvider;
import com.viewpharm.yakal.type.EImageUseType;
import com.viewpharm.yakal.type.ELoginProvider;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.type.EPlatform;
import com.viewpharm.yakal.type.ERole;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.dto.response.JwtTokenDto;
import com.viewpharm.yakal.utils.OAuth2Util;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cglib.core.Local;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final LoginLogRepository loginLogRepository;
    private final JwtProvider jwtProvider;
    private final OAuth2Util oAuth2Util;
    private final ImageRepository imageRepository;
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

        final User user = userRepository.findBySocialIdAndLoginProvider(socialId, loginProvider)
                .orElseGet(() -> userRepository.save(new User(finalSocialId, loginProvider, role, null)));

        if (user.getImage() == null) {
            user.setImage(imageRepository.save(
                    Image.builder()
                            .useObject(user)
                            .imageUseType(EImageUseType.USER)
                            .uuidName("0_default_image.png")
                            .type("image/png")
                            .path(FOLDER_PATH + "0_default_image.png").build()));

            List<Prescription> prescriptionList = new ArrayList<>();
            prescriptionList.add(prescriptionRepository.save(
                    Prescription.builder()
                            .user(user)
                            .pharmacyName("default")
                            .prescribedDate(LocalDate.now())
                            .build()));

            user.setPrescriptions(prescriptionList);
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
        final String FRONTEND_HOST = "http://localhost:5173"; // Front Server Host -> 배포 시 변경

        final Cookie refreshTokenSecureCookie = new Cookie("refreshToken", jwtTokenDto.getRefreshToken());
        refreshTokenSecureCookie.setPath("/");
        refreshTokenSecureCookie.setHttpOnly(true);
        refreshTokenSecureCookie.setSecure(true);
        refreshTokenSecureCookie.setMaxAge(jwtProvider.getWebRefreshTokenExpirationSecond());

        final Cookie accessTokenCookie = new Cookie("accessToken", jwtTokenDto.getAccessToken());
        accessTokenCookie.setPath("/");

        response.addCookie(refreshTokenSecureCookie);
        response.addCookie(accessTokenCookie);

        response.sendRedirect(FRONTEND_HOST + "/expert/login/social/" + loginProvider.toString().toLowerCase());
    }

    public void saveLoginTime(LocalDate date) {
        loginLogRepository.save(LoginLog.builder()
                .loginTime(date).build());
    }
}
