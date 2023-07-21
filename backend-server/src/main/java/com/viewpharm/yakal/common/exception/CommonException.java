package com.viewpharm.yakal.common.exception;

import com.viewpharm.yakal.common.exception.type.ErrorCode;

public class CommonException extends RuntimeException {
    private final ErrorCode errorCode;

    public CommonException(final ErrorCode errorCode) {
        this.errorCode = errorCode;
    }

    public ErrorCode getErrorCode() {
        return errorCode;
    }
}
