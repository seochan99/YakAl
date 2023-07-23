package com.viewpharm.yakal.dto;

public class JwtResponseDto {
    private final JwtTokenDto jwtTokenDto;

    public JwtResponseDto(final JwtTokenDto jwtTokenDto) {
        this.jwtTokenDto = jwtTokenDto;
    }

    public JwtTokenDto getJwtToken() {
        return jwtTokenDto;
    }
}