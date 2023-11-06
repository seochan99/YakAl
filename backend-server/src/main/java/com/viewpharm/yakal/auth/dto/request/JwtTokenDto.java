package com.viewpharm.yakal.auth.dto.request;

import lombok.Getter;

@Getter
public class JwtTokenDto {

    private final String accessToken;
    private final String refreshToken;

    public JwtTokenDto(final String accessToken, final String refreshToken) {
        this.accessToken = accessToken;
        this.refreshToken = refreshToken;
    }
}
