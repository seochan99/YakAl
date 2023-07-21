package com.viewpharm.yakal.common.jwt.dto;

public class JwtResponseDto {
    private final JwtTokenDto jwtTokenDto;

    public JwtResponseDto(final JwtTokenDto jwtTokenDto) {
        this.jwtTokenDto = jwtTokenDto;
    }

    public JwtTokenDto getJwtToken() {
        return jwtTokenDto;
    }
}