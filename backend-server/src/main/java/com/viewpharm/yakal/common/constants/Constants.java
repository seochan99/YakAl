package com.viewpharm.yakal.common.constants;

public class Constants {

    public static final String USER_ID_CLAIM_NAME = "uid";
    public static final String USER_ROLE_CLAIM_NAME = "rol";

    public static final String[] NO_NEED_AUTH_URLS = {
            "/api/v1/auth/kakao", "/api/v1/auth/google", "/api/v1/auth/apple",
            "/api/v1/auth/kakao/callback", "/api/v1/auth/google/callback", "/api/v1/auth/apple/callback",
            "/api/v1/auth/reissue", "/api/v1/auth/reissue/secure", "/api/v1/auth/validate",
            "/api-docs.html", "/api-docs/**", "/swagger-ui/**",
    };

    public static final String[] NO_NEED_AUTH_URLS_REGEX = {
            "^/api/v1/auth/kakao$", "^/api/v1/auth/google$", "^/api/v1/auth/apple$",
            "^/api/v1/auth/kakao/callback$", "^/api/v1/auth/google/callback$", "^/api/v1/auth/apple/callback$",
            "^/api/v1/auth/reissue$", "^/api/v1/auth/reissue/secure$", "^/api/v1/auth/validate$",
            "^/api-docs.html$", "/api-docs/.+$" ,"^/swagger-ui/.*$",
    };
}
