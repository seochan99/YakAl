package com.viewpharm.yakal.common;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum ErrorCode {
    // Access Denied Error
    ACCESS_DENIED_ERROR("4010", HttpStatus.UNAUTHORIZED, "Access Denied Token Error"),

    // Token Error Set
    TOKEN_INVALID_ERROR("4011", HttpStatus.UNAUTHORIZED, "Invalid Token Error"),
    TOKEN_MALFORMED_ERROR("4012", HttpStatus.UNAUTHORIZED, "Malformed Token Error"),
    TOKEN_EXPIRED_ERROR("4013", HttpStatus.UNAUTHORIZED, "Expired Token Error"),
    TOKEN_TYPE_ERROR("4014", HttpStatus.UNAUTHORIZED, "Type Token Error"),
    TOKEN_UNSUPPORTED_ERROR("4015", HttpStatus.UNAUTHORIZED, "Unsupported Token Error"),
    TOKEN_UNKNOWN_ERROR("4016", HttpStatus.UNAUTHORIZED, "Unknown Error");

    private final String code;
    private final HttpStatus httpStatus;
    private final String message;
}
