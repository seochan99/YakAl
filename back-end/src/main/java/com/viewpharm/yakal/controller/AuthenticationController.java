package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.common.ResponseDto;
import com.viewpharm.yakal.domain.LoginProvider;
import com.viewpharm.yakal.security.jwt.JwtProvider;
import com.viewpharm.yakal.security.jwt.JwtToken;
import com.viewpharm.yakal.service.AuthenticationService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/api/v1/oauth")
@RequiredArgsConstructor
public class AuthenticationController {
    private final AuthenticationService authenticationService;
    private final JwtProvider jwtProvider;

    @GetMapping("/kakao")
    public ResponseDto<Map<String, String>> getKAKAO_REDIRECT_URL() {
        Map<String, String> map = new HashMap<>();
        map.put("url", authenticationService.getRedirectUrl(LoginProvider.KAKAO));
        return new ResponseDto(map);
    }

    @PostMapping("/kakao")
    public ResponseDto<?> loginUsingKAKAO(HttpServletRequest request) {
        return new ResponseDto<JwtToken>(authenticationService.login(JwtProvider.refineToken(request), LoginProvider.KAKAO));
    }
}
