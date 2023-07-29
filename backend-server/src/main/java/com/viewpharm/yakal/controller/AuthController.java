package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.annotation.DisableSwaggerSecurity;
import com.viewpharm.yakal.annotation.UserId;
import com.viewpharm.yakal.dto.response.JwtTokenDto;
import com.viewpharm.yakal.security.JwtProvider;
import com.viewpharm.yakal.service.AuthService;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.type.ELoginProvider;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;

import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/auth")
@Tag(name = "Auth", description = "로그인, 로그아웃 및 토큰 재발급")
public class AuthController {

    private final AuthService authService;
    private final JwtProvider jwtProvider;

    @GetMapping("/kakao")
    @DisableSwaggerSecurity
    @Operation(summary = "Kakao 인증 리다이렉트 URL 가져오기", description = "Kakao 인증 리다이렉트 URL를 가져옵니다.")
    public ResponseDto<Map<String, String>> getKakaoRedirectUrl() {
        return ResponseDto.ok(authService.getRedirectUrl(ELoginProvider.KAKAO));
    }

    @PostMapping("/kakao")
    @Operation(summary = "Kakao 로그인", description = "Kakao 인증 토큰으로 사용자를 생성하고 JWT 토큰을 발급합니다.")
    public ResponseDto<JwtTokenDto> loginUsingKAKAO(final HttpServletRequest request) {
        final String accessToken = jwtProvider.refineToken(request);
        final JwtTokenDto jwtTokenDto = authService.login(accessToken, ELoginProvider.KAKAO);
        return ResponseDto.created(jwtTokenDto);
    }

    // Google, Apple 로그인 구현 예정

    @Deprecated
    @PostMapping("/user")
    @Operation(summary = "사용자 생성 (테스트용)", description = "더미 사용자를 생성합니다. 개발 기간에만 제공됩니다.")
    public ResponseDto<JwtTokenDto> createUser() {
        final JwtTokenDto jwtTokenDto = authService.createUser();
        return ResponseDto.created(jwtTokenDto);
    }

    @PatchMapping("/mobile/logout")
    @Operation(summary = "모바일 로그아웃", description = "전송된 액세스 토큰에 해당하는 모바일 사용자를 로그아웃시킵니다.")
    public ResponseDto<Object> logout(@UserId Long id) {
        authService.logout(id);
        return ResponseDto.ok(null);
    }

    @PostMapping("/reissue")
    @Operation(summary = "액세스 토큰 재발급", description = "리프레시 토큰을 통해 만료된 액세스 토큰을 재발급합니다.")
    public ResponseDto<JwtTokenDto> reissue(final HttpServletRequest request) {
        final JwtTokenDto jwtTokenDto = authService.reissue(request);
        return ResponseDto.created(jwtTokenDto);
    }
}