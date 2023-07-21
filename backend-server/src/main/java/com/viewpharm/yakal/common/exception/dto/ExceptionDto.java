package com.viewpharm.yakal.common.exception.dto;

import com.viewpharm.yakal.common.exception.type.ErrorCode;
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
