package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.dto.JwtTokenDto;
import com.viewpharm.yakal.service.JwtService;
import com.viewpharm.yakal.service.AuthService;
import com.viewpharm.yakal.dto.ResponseDto;
import com.viewpharm.yakal.type.ELoginProvider;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/auth")
@Tag(name = "Auth", description = "소셜 로그인, 로그아웃")
public class AuthController {
    private final AuthService authService;

    @Autowired
    public AuthController(final AuthService authService) {
        this.authService = authService;
    }

    @GetMapping("/kakao")
    @Operation(summary = "Kakao 인증 리다이렉트 URL 가져오기", description = "Kakao 인증 리다이렉트 URL 가져오기")
    public ResponseDto<Map<String, String>> getKakaoRedirectUrl() {
        final Map<String, String> map = new HashMap<>(1);
        map.put("url", authService.getRedirectUrl(ELoginProvider.KAKAO));
        return ResponseDto.ok(map);
    }

    @PostMapping("/kakao")
    @Operation(summary = "Kakao 액세스 토큰으로 JWT 토큰 발행", description = "Kakao 인증 리다이렉트 URL 가져오기")
    public ResponseDto<JwtTokenDto> loginUsingKAKAO(final HttpServletRequest request) {
        final JwtTokenDto jwtTokenDto = authService.login(JwtService.refineToken(request), ELoginProvider.KAKAO);
        return ResponseDto.created(jwtTokenDto);
    }
}