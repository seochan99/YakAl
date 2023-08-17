package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.annotation.DisableSwaggerSecurity;
import com.viewpharm.yakal.annotation.UserId;
import com.viewpharm.yakal.dto.response.JwtTokenDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.security.JwtProvider;
import com.viewpharm.yakal.service.AuthService;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.type.ELoginProvider;
import com.viewpharm.yakal.type.ERole;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/auth")
@Tag(name = "Auth", description = "로그인, 로그아웃 및 토큰 재발급")
public class AuthController {

    private final AuthService authService;
    private final JwtProvider jwtProvider;

    /**
     * <h1>Mobile Login API</h1>
     * Android, iOS 모바일 어플리케이션에서 사용하는 로그인 API입니다.
     * 프론트엔드에서 각자 인증 서버로부터 인가 코드를 받고 이를 본 API에 넘겨주면 본 서비스를 이용하는데 필요한 JWT를 반환합니다.
     * JOSN Body에 액세스 토큰과 리프레시 토큰이 포함되어 있습니다.
     */
    @PostMapping("/kakao")
    @Operation(summary = "Kakao 로그인", description = "Kakao 인증 토큰으로 사용자를 생성하고 JWT 토큰을 발급합니다.")
    public ResponseDto<JwtTokenDto> loginUsingKAKAO(final HttpServletRequest request) {
        final String accessToken = jwtProvider.refineToken(request);
        final JwtTokenDto jwtTokenDto = authService.login(accessToken, ELoginProvider.KAKAO, ERole.ROLE_MOBILE);
        return ResponseDto.created(jwtTokenDto);
    }

    @PostMapping("/google")
    @Operation(summary = "Google 로그인", description = "Google 인증 토큰으로 사용자를 생성하고 JWT 토큰을 발급합니다.")
    public ResponseDto<JwtTokenDto> loginUsingGOOGLE(final HttpServletRequest request) {
        final String accessToken = jwtProvider.refineToken(request);
        final JwtTokenDto jwtTokenDto = authService.login(accessToken, ELoginProvider.GOOGLE, ERole.ROLE_MOBILE);
        return ResponseDto.created(jwtTokenDto);
    }

    @PostMapping("/apple")
    @Operation(summary = "Apple 로그인", description = "Apple 인증 토큰으로 사용자를 생성하고 JWT 토큰을 발급합니다.")
    public ResponseDto<?> loginUsingApple(final HttpServletRequest request) {
        final String accessToken = jwtProvider.refineToken(request);
        final JwtTokenDto jwtTokenDto = authService.login(accessToken, ELoginProvider.APPLE, ERole.ROLE_MOBILE);
        return ResponseDto.created(jwtTokenDto);
    }

    /**
     * <h1>Web Login API</h1>
     * 이하는 상단의 Mobile 로그인 API와 같은 기능을 가지지만 리프레시 토큰을 json body가 아닌 쿠키에 넣어서 보내줍니다.
     * XSS와 CSRF 공격에 취약한 웹 서비스에서 보안을 강화하기 위한 API입니다.
     */
    @GetMapping("/kakao")
    @Operation(summary = "Kakao 웹 로그인", description = "Kakao 인증 토큰으로 사용자를 생성하고 JWT 토큰을 발급합니다. (HttpOnly Cookie를 사용하는 웹 전용)")
    public ResponseEntity<ResponseDto<?>> loginUsingKakaoForWeb(@RequestParam("code") final String code) {
        final JwtTokenDto jwtTokenDto = authService.login(code, ELoginProvider.KAKAO, ERole.ROLE_WEB);

        final ResponseCookie cookie = ResponseCookie.from("refreshToken", jwtTokenDto.getRefreshToken())
                .httpOnly(true)
                .secure(true)
                .sameSite("None")
                .build();

        final Map<String, String> data = new HashMap<>(1);
        data.put("accessToken", jwtTokenDto.getAccessToken());

        final ResponseDto<?> responseBody = ResponseDto.builder().data(data).success(true).build();

        return ResponseEntity.status(HttpStatus.OK).header(HttpHeaders.SET_COOKIE, cookie.toString()).body(responseBody);
    }

    /**
     * <h1>Web Social Login Redirect URL</h1>
     * 이하는 웹 소셜 로그인 인증 페이지로의 Redirect URL을 반환합니다.
     */
    @GetMapping("/kakao")
    @DisableSwaggerSecurity
    @Operation(summary = "Kakao 인증 리다이렉트 URL 가져오기", description = "Kakao 인증 리다이렉트 URL를 가져옵니다.")
    public ResponseDto<Map<String, String>> getKakaoRedirectUrl() {
        return ResponseDto.ok(authService.getRedirectUrl(ELoginProvider.KAKAO));
    }

    @GetMapping("/google")
    @DisableSwaggerSecurity
    @Operation(summary = "Google 인증 리다이렉트 URL 가져오기", description = "Google 인증 리다이렉트 URL를 가져옵니다.")
    public ResponseDto<Map<String, String>> getGoogleRedirectUrl() {
        return ResponseDto.ok(authService.getRedirectUrl(ELoginProvider.GOOGLE));
    }

    @GetMapping("/apple")
    @Operation(summary = "Apple 인증 리다이렉트 URL 가져오기", description = "Apple 인증 리다이렉트 URL를 가져옵니다.")
    public ResponseDto<Map<String, String>> getAppleRedirectUrl() {
        return ResponseDto.ok(authService.getRedirectUrl(ELoginProvider.APPLE));
    }

    @PatchMapping("/logout")
    @Operation(summary = "로그아웃", description = "전송된 액세스 토큰에 해당하는 모바일 사용자를 로그아웃시킵니다.")
    public ResponseDto<Object> logout(@UserId Long id) {
        authService.logout(id);
        return ResponseDto.ok(null);
    }

    @PostMapping("/reissue")
    @Operation(summary = "액세스 토큰 재발급", description = "리프레시 토큰을 통해 만료된 액세스 토큰을 재발급합니다.")
    public ResponseDto<JwtTokenDto> reissue(final HttpServletRequest request) {
        final JwtTokenDto jwtTokenDto = authService.reissueForWeb(request);
        return ResponseDto.created(jwtTokenDto);
    }

    @PostMapping("/reissue/secure")
    @Operation(summary = "웹 액세스 토큰 재발급", description = "리프레시 토큰을 통해 만료된 액세스 토큰을 재발급합니다. (HttpOnly 쿠키를 사용하는 웹 전용)")
    public ResponseEntity<ResponseDto<?>> reissueForWeb(@CookieValue("refreshToken") final String refreshToken) {
        final JwtTokenDto jwtTokenDto = authService.reissueForWeb(refreshToken);

        final ResponseCookie cookie = ResponseCookie.from("refreshToken", jwtTokenDto.getRefreshToken())
                .httpOnly(true)
                .secure(true)
                .sameSite("None")
                .build();

        final Map<String, String> data = new HashMap<>(1);
        data.put("accessToken", jwtTokenDto.getAccessToken());

        final ResponseDto<?> responseBody = ResponseDto.builder().data(data).success(true).build();

        return ResponseEntity.status(HttpStatus.CREATED).header(HttpHeaders.SET_COOKIE, cookie.toString()).body(responseBody);
    }
}