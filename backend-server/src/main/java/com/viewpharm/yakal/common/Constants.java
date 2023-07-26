package com.viewpharm.yakal.common;

public class Constants {

    public static final String USER_ID_CLAIM_NAME = "uid";
    public static final String USER_ROLE_CLAIM_NAME = "rol";

    public static final String[] NO_NEED_AUTH_URLS = {
            "/api/v1/auth/kakao", "/api/v1/auth/google", "/api/v1/auth/apple", "/api/v1/auth/reissue",
            "/api-docs.html", "/api-docs/**", "/swagger-ui/**",
            "/api/v1/auth/user" // 개발 단계에서 임시로 사용
    };

    public static final String[] NO_NEED_AUTH_URLS_REGEX = {
            "^/api/v1/auth/kakao$", "^/api/v1/auth/google$", "^/api/v1/auth/apple$", "^/api/v1/auth/reissue",
            "^/api-docs.html$", "/api-docs/.+$" ,"^/swagger-ui/.*$",
            "^/api/v1/auth/user$" // 개발 단계에서 임시로 사용
    };
}
