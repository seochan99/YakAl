package com.viewpharm.yakal.common.jwt.dto;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;

@Data
@Getter
@Builder
public class JwtTokenDto {
    private String accessToken;
    private String refreshToken;
}
