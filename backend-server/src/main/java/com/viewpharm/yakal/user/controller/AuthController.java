package com.viewpharm.yakal.user.controller;

import com.viewpharm.yakal.common.annotation.DisableSwaggerSecurity;
import com.viewpharm.yakal.common.annotation.UserId;
import com.viewpharm.yakal.common.JwtTokenDto;
import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.exception.ErrorCode;
import com.viewpharm.yakal.common.security.JwtProvider;
import com.viewpharm.yakal.user.service.AuthService;
import com.viewpharm.yakal.base.ResponseDto;
import com.viewpharm.yakal.base.type.ELoginProvider;
import com.viewpharm.yakal.base.type.EPlatform;
import com.viewpharm.yakal.base.type.ERole;
import com.viewpharm.yakal.base.type.EValidity;
import com.viewpharm.yakal.base.utils.OAuth2Util;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
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
    @Operation(summary = "Kakao 로그인", description = "Kakao 액세스 토큰으로 사용자를 생성하고 JWT 토큰을 발급합니다.")
    public ResponseDto<JwtTokenDto> loginUsingKAKAO(final HttpServletRequest request) {
        final String accessToken = jwtProvider.refineToken(request);
        final JwtTokenDto jwtTokenDto = authService.login(accessToken, ELoginProvider.KAKAO, ERole.ROLE_MOBILE);
        return ResponseDto.created(jwtTokenDto);
    }

    @PostMapping("/google")
    @Operation(summary = "Google 로그인", description = "Google 액세스 토큰으로 사용자를 생성하고 JWT 토큰을 발급합니다.")
    public ResponseDto<JwtTokenDto> loginUsingGOOGLE(final HttpServletRequest request) {
        final String accessToken = jwtProvider.refineToken(request);
        final JwtTokenDto jwtTokenDto = authService.login(accessToken, ELoginProvider.GOOGLE, ERole.ROLE_MOBILE);
        return ResponseDto.created(jwtTokenDto);
    }

    @PostMapping("/apple")
    @Operation(summary = "Apple 로그인", description = "Apple 액세스 토큰으로 사용자를 생성하고 JWT 토큰을 발급합니다.")
    public ResponseDto<?> loginUsingApple(final HttpServletRequest request) {
        final String accessToken = jwtProvider.refineToken(request);
        final JwtTokenDto jwtTokenDto = authService.login(accessToken, ELoginProvider.APPLE, ERole.ROLE_MOBILE);
        return ResponseDto.created(jwtTokenDto);
    }

    /**
     * Web Login API
     */
    @GetMapping("/kakao/callback")
    @Operation(summary = "Kakao 웹 로그인", description = "Kakao 인증 코드로 사용자를 생성하고 JWT 토큰을 발급합니다. (HttpOnly Cookie를 사용하는 웹 전용)")
    public void loginUsingKakaoForWeb(@RequestParam("code") final String code, final HttpServletResponse response) throws Exception {
        final String accessToken = oAuth2Util.getKakaoAccessToken(code);
        final JwtTokenDto jwtTokenDto = authService.login(accessToken, ELoginProvider.KAKAO, ERole.ROLE_WEB);

        authService.sendRedirectWithTokenCookieAdded(jwtTokenDto, response, ELoginProvider.KAKAO);
    }

    @GetMapping("/google/callback")
    @Operation(summary = "Google 웹 로그인", description = "Google 인증 코드로 사용자를 생성하고 JWT 토큰을 발급합니다. (HttpOnly Cookie를 사용하는 웹 전용)")
    public void loginUsingGoogleForWeb(@RequestParam("code") final String code, final HttpServletResponse response) throws Exception {
        final String accessToken = oAuth2Util.getGoogleAccessToken(code);
        final JwtTokenDto jwtTokenDto = authService.login(accessToken, ELoginProvider.GOOGLE, ERole.ROLE_WEB);

        authService.sendRedirectWithTokenCookieAdded(jwtTokenDto, response, ELoginProvider.GOOGLE);
    }

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
    public ResponseDto<Object> logout(@UserId Long id, final HttpServletRequest request, final HttpServletResponse response) {
        EPlatform platform = authService.getPlatform(id);

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
     * Get Access Token Validity
     */
    @GetMapping("/validate")
    @Operation(summary = "액세스 토큰 유효성 검사", description = "전송된 액세스 토큰이 유효한지 판별합니다.")
    public ResponseDto<Object> validateAccessToken(final HttpServletRequest request) {
        final String accessToken = jwtProvider.refineToken(request);

        final Map<String, String> map = new HashMap<>(1);

        try {
            jwtProvider.validateToken(accessToken);
        } catch (ExpiredJwtException e) {
            map.put("validity", EValidity.EXPIRED.toString());
            return ResponseDto.ok(map);
        } catch (JwtException e) {
            map.put("validity", EValidity.INVALID.toString());
            return ResponseDto.ok(map);
        } catch (Exception e) {
            throw new CommonException(ErrorCode.SERVER_ERROR);
        }

        map.put("validity", EValidity.VALID.toString());
        return ResponseDto.ok(map);
    }

    /**
     * Reissue Access Token
     */
    @PostMapping("/reissue")
    @Operation(summary = "액세스 토큰 재발급", description = "리프레시 토큰을 통해 만료된 액세스 토큰을 재발급합니다.")
    public ResponseDto<JwtTokenDto> reissue(final HttpServletRequest request) {
        final String refreshToken = jwtProvider.refineToken(request);
        final JwtTokenDto jwtTokenDto = authService.reissue(refreshToken, EPlatform.MOBILE);
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

        final JwtTokenDto jwtTokenDto = authService.reissue(refreshTokenCookie.getValue(), EPlatform.WEB);

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