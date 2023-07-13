package com.viewpharm.yakal.common;

import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.exception.UserException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(value = {UserException.class})
    public ResponseEntity<? extends Object> handleUserException(UserException e) {
        log.error("HandleApiException throw RestApiException : {}", e.getErrorCode());
        return ResponseDto.toResponseEntity(e);
    }

    @ExceptionHandler(value = {Exception.class})
    public ResponseEntity<? extends Object> handleException(Exception e) {
        log.error("HandleException throw Exception : {}", e.getMessage());
        return ResponseDto.of(new CommonException(ErrorCode.SERVER_ERROR));
    }
}