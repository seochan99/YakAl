package com.viewpharm.yakal.auth.controller;

import com.viewpharm.yakal.base.annotation.DisableSwaggerSecurity;
import com.viewpharm.yakal.base.annotation.UserId;
import com.viewpharm.yakal.auth.dto.request.JwtTokenDto;
import com.viewpharm.yakal.base.exception.CommonException;
import com.viewpharm.yakal.base.exception.ErrorCode;
import com.viewpharm.yakal.auth.service.JwtProvider;
import com.viewpharm.yakal.auth.service.AuthService;
import com.viewpharm.yakal.base.dto.ResponseDto;
import com.viewpharm.yakal.base.type.ELoginProvider;
import com.viewpharm.yakal.base.type.EPlatform;
import com.viewpharm.yakal.base.type.ERole;
import com.viewpharm.yakal.base.utils.OAuth2Util;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/auth")
@Tag(name = "Auth", description = "로그인, 로그아웃 및 토큰 재발급")
public class AuthController {

    private final AuthService authService;
    private final JwtProvider jwtProvider;
    private final OAuth2Util oAuth2Util;

    /**
     * Mobile Login API
     */
    @PostMapping("/kakao")
    @Operation(summary = "Kakao 로그인(App)", description = "Kakao 액세스 토큰으로 사용자를 생성하고 JWT 토큰을 발급합니다.")
    public ResponseDto<JwtTokenDto> loginUsingKAKAO(final HttpServletRequest request) {
        final String accessToken = jwtProvider.refineToken(request);
        final JwtTokenDto jwtTokenDto = authService.loginForMobile(accessToken, ELoginProvider.KAKAO);
        return ResponseDto.created(jwtTokenDto);
    }

    @PostMapping("/google")
    @Operation(summary = "Google 로그인(App)", description = "Google 액세스 토큰으로 사용자를 생성하고 JWT 토큰을 발급합니다.")
    public ResponseDto<JwtTokenDto> loginUsingGOOGLE(final HttpServletRequest request) {
        final String accessToken = jwtProvider.refineToken(request);
        final JwtTokenDto jwtTokenDto = authService.loginForMobile(accessToken, ELoginProvider.GOOGLE);
        return ResponseDto.created(jwtTokenDto);
    }

    @PostMapping("/apple")
    @Operation(summary = "Apple 로그인(App)", description = "Apple 액세스 토큰으로 사용자를 생성하고 JWT 토큰을 발급합니다.")
    public ResponseDto<?> loginUsingApple(final HttpServletRequest request) {
        final String accessToken = jwtProvider.refineToken(request);
        final JwtTokenDto jwtTokenDto = authService.loginForMobile(accessToken, ELoginProvider.APPLE);
        return ResponseDto.created(jwtTokenDto);
    }

//    /**
//     * Web Login API
//     */
//    @GetMapping("/kakao/callback")
//    @Operation(summary = "Kakao 웹 로그인", description = "Kakao 인증 코드로 사용자를 생성하고 JWT 토큰을 발급합니다. (HttpOnly Cookie를 사용하는 웹 전용)")
//    public void loginUsingKakaoForWeb(@RequestParam("code") final String code, final HttpServletResponse response) throws Exception {
//        final String accessToken = oAuth2Util.getKakaoAccessToken(code);
//        final JwtTokenDto jwtTokenDto = authService.login(accessToken, ELoginProvider.KAKAO, ERole.ROLE_WEB);
//
//        authService.sendRedirectWithTokenCookieAdded(jwtTokenDto, response, ELoginProvider.KAKAO);
//    }
//
//    @GetMapping("/google/callback")
//    @Operation(summary = "Google 웹 로그인", description = "Google 인증 코드로 사용자를 생성하고 JWT 토큰을 발급합니다. (HttpOnly Cookie를 사용하는 웹 전용)")
//    public void loginUsingGoogleForWeb(@RequestParam("code") final String code, final HttpServletResponse response) throws Exception {
//        final String accessToken = oAuth2Util.getGoogleAccessToken(code);
//        final JwtTokenDto jwtTokenDto = authService.login(accessToken, ELoginProvider.GOOGLE, ERole.ROLE_WEB);
//
//        authService.sendRedirectWithTokenCookieAdded(jwtTokenDto, response, ELoginProvider.GOOGLE);

    /**
     * Web Social Login Redirect URL
     */
    @GetMapping("/kakao")
    @DisableSwaggerSecurity
    @Operation(summary = "Kakao 인증 리다이렉트 URL 가져오기", description = "Kakao 인증 리다이렉트 URL을 가져옵니다.")
    public ResponseDto<Map<String, String>> getKakaoRedirectUrl() {
        return ResponseDto.ok(authService.getRedirectUrl(ELoginProvider.KAKAO));
    }

    @GetMapping("/google")
    @DisableSwaggerSecurity
    @Operation(summary = "Google 인증 리다이렉트 URL 가져오기", description = "Google 인증 리다이렉트 URL을 가져옵니다.")
    public ResponseDto<Map<String, String>> getGoogleRedirectUrl() {
        return ResponseDto.ok(authService.getRedirectUrl(ELoginProvider.GOOGLE));
    }

    @GetMapping("/apple")
    @DisableSwaggerSecurity
    @Operation(summary = "Apple 인증 리다이렉트 URL 가져오기", description = "Apple 인증 리다이렉트 URL을 가져옵니다.")
    public ResponseDto<Map<String, String>> getAppleRedirectUrl() {
        return ResponseDto.ok(authService.getRedirectUrl(ELoginProvider.APPLE));
    }

    /**
     * Logout
     */
    @PatchMapping("/logout")
    @Operation(summary = "로그아웃", description = "전송된 액세스 토큰에 해당하는 모바일 사용자를 로그아웃시킵니다.")
    public ResponseDto<Object> logout(@UserId Long id,
                                      @RequestPart(value = "platform") EPlatform platform,
                                      final HttpServletRequest request,
                                      final HttpServletResponse response) {
        authService.logout(id);

        if (platform == EPlatform.WEB) {
            final Cookie[] cookies = request.getCookies();

            if (cookies == null) {
                throw new CommonException(ErrorCode.INVALID_TOKEN_ERROR);
            }

            final Cookie refreshTokenCookie = Arrays.stream(cookies).filter((cookie) -> cookie.getName().equals("refreshToken"))
                    .findFirst().orElseThrow(() -> new CommonException(ErrorCode.INVALID_TOKEN_ERROR));

            refreshTokenCookie.setMaxAge(0);

            response.addCookie(refreshTokenCookie);
        }

        return ResponseDto.ok(null);
    }

    /**
     * Reissue Access Token
     */
    @PostMapping("/reissue")
    @Operation(summary = "액세스 토큰 재발급", description = "리프레시 토큰을 통해 만료된 액세스 토큰을 재발급합니다.")
    public ResponseDto<JwtTokenDto> reissue(final HttpServletRequest request) {
        final String refreshToken = jwtProvider.refineToken(request);
        final JwtTokenDto jwtTokenDto = authService.reissue(refreshToken);
        return ResponseDto.created(jwtTokenDto);
    }

    /**
     * Reissue Access Token Using Secure Cookie
     */
    @PostMapping("/reissue/secure")
    @Operation(summary = "웹 액세스 토큰 재발급", description = "리프레시 토큰을 통해 만료된 액세스 토큰을 재발급합니다. (HttpOnly 쿠키를 사용하는 웹 전용)")
    public ResponseDto<Map<String, String>> reissueSecurely(final HttpServletRequest request, final HttpServletResponse response) {
        final Cookie[] cookies = request.getCookies();

        if (cookies == null) {
            throw new CommonException(ErrorCode.INVALID_TOKEN_ERROR);
        }

        final Cookie refreshTokenCookie = Arrays.stream(cookies).filter((cookie) -> cookie.getName().equals("refreshToken"))
                .findFirst().orElseThrow(() -> new CommonException(ErrorCode.INVALID_TOKEN_ERROR));

        final JwtTokenDto jwtTokenDto = authService.reissue(refreshTokenCookie.getValue());

        refreshTokenCookie.setValue(jwtTokenDto.getRefreshToken());
        refreshTokenCookie.setPath("/");
        refreshTokenCookie.setSecure(true);
        refreshTokenCookie.setHttpOnly(true);
        refreshTokenCookie.setMaxAge(jwtProvider.getWebRefreshTokenExpirationSecond());

        response.addCookie(refreshTokenCookie);

        final Map<String, String> data = new HashMap<>(1);
        data.put("accessToken", jwtTokenDto.getAccessToken());

        return ResponseDto.created(data);
    }
}