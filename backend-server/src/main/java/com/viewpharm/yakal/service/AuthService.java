package com.viewpharm.yakal.service;

import com.viewpharm.yakal.type.ELoginProvider;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.type.EUserRole;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.dto.JwtTokenDto;
import com.viewpharm.yakal.utils.OAuth2Util;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Slf4j
@Service
@Transactional
public class AuthService {
    private final UserRepository userRepository;
    private final JwtService jwtService;
    private final OAuth2Util oAuth2Util;

    @Autowired
    public AuthService(final UserRepository userRepository,
                       final JwtService jwtService,
                       final OAuth2Util oAuth2Util) {
        this.userRepository = userRepository;
        this.jwtService = jwtService;
        this.oAuth2Util = oAuth2Util;
    }

    /**
     * 플랫폼 별 리다이렉트 URL을 반환합니다.
     * 클라이언트가 본 URL로 접속하면 플랫폼 별 로그인 및 정보 제공 동의 화면을 보게 됩니다.
     *
     * @param loginProvider 소셜 로그인 제공 플랫폼.
     * @return 플랫폼 별 로그인 및 정보 제공 동의 화면 리다이렉트 URL.
     */
    public String getRedirectUrl(final ELoginProvider loginProvider) {
        switch (loginProvider) {
            case KAKAO -> {
                return oAuth2Util.getKakaoRedirectUrl();
            }
            case GOOGLE -> {
                // return oAuth2Util.getGoogleRedirectUrl();
            }
            case APPLE -> {
                // return oAuth2Util.getAppleRedirectUrl();
            }
            default -> {
                assert (true): "Invalid Type Error";
            }
        }
        return null;
    }

    /**
     * 플랫폼별 인증 서버로 인가 코드를 전송하여 액세스 토큰을 발급받습니다.
     * 그 다음 액세스 토큰을 통해 사용자 정보를 받아오고 그 정보를 데이터베이스에 저장합니다.
     * 마지막으로 사용자 정보를 바탕으로 JWT 토큰을 발급해 반환합니다.
     *
     * @param authorizationAccessToken    인증 서버로부터 받은 인가 코드.
     * @param loginProvider    소셜 로그인 제공 플랫폼.
     * @return 액세스 토큰과 리프레시 토큰을 래핑한 반환 DTO.
     */
    public JwtTokenDto login(final String authorizationAccessToken, final ELoginProvider loginProvider) {
        String socialId = null;

        switch (loginProvider) {
            case KAKAO -> {
                socialId = oAuth2Util.getKakaoUserInformation(authorizationAccessToken);
            }
            case GOOGLE -> {
            }
            case APPLE -> {
            }
            default -> {
                assert (false): "Invalid Type Error";
            }
        }

        if (socialId == null) {
            throw new CommonException(ErrorCode.NOT_FOUND_USER);
        }

        final Optional<User> user = userRepository.findBySocialIdAndLoginProvider(socialId, loginProvider);

        User loginUser;
        if (user.isEmpty()) {
            loginUser = userRepository.save(User.builder()
                    .socialId(socialId)
                    .loginProvider(loginProvider)
                    .userRole(EUserRole.USER)
                    .build());
        } else {
            loginUser = user.get();
        }

        final JwtTokenDto jwtTokenDto = jwtService.createTotalToken(loginUser.getId(), loginUser.getUserRole());
        loginUser.setRefreshToken(jwtTokenDto.getRefreshToken());
        loginUser.setIsLogin(true);

        return jwtTokenDto;
    }

    public Map<String, String> getAccessTokenByRefreshToken(final HttpServletRequest request) {
        final Map<String, String> map = new HashMap<>(1);
        map.put("accessToken", jwtService.validRefreshToken(request));
        return map;
    }
}
