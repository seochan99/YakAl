package com.viewpharm.yakal.common.exception;

import com.viewpharm.yakal.common.ErrorCode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class CommonException extends RuntimeException {
    private final ErrorCode errorCode;
}
