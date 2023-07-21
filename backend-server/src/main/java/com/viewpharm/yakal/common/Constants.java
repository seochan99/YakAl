package com.viewpharm.yakal.common;

public class Constants {

    public static final String[] NO_NEED_AUTH_URLS = {
            "/api/auth/kakao", "/api/auth/google", "/api/auth/apple",
            "/api/auth/refresh", "/api-docs.html", "/api-docs/**", "/swagger-ui/**"
    };

    public static final String[] NO_NEED_AUTH_URLS_REGEX = {
            "^/api/auth/kakao$", "^/api/auth/google$", "^/api/auth/apple$",
            "^/api/auth/refresh$", "^/api-docs.html$", "/api-docs/.+$" ,"^/swagger-ui/.*$"
    };
}
