package com.viewpharm.yakal.dto.response;

import com.viewpharm.yakal.exception.ErrorCode;
import lombok.Getter;

@Getter
public class ExceptionDto {
    private final String code;
    private final String message;

    public ExceptionDto(ErrorCode errorCode) {
        this.code = errorCode.getCode();
        this.message = errorCode.getMessage();
    }
}
