package com.viewpharm.yakal.security.jwt;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class JwtToken {
    private String access_token;
    private String refresh_token;
}
