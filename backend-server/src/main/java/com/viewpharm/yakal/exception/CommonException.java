package com.viewpharm.yakal.exception;

public class CommonException extends RuntimeException {
    private final ErrorCode errorCode;

    public CommonException(final ErrorCode errorCode) {
        this.errorCode = errorCode;
    }

    public ErrorCode getErrorCode() {
        return errorCode;
    }
}
