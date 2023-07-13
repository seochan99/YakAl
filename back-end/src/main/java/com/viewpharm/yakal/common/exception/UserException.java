package com.viewpharm.yakal.common.exception;

import com.viewpharm.yakal.common.ErrorCode;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Getter
@RequiredArgsConstructor
public class UserException extends RuntimeException {
    private final ErrorCode errorCode;
}
