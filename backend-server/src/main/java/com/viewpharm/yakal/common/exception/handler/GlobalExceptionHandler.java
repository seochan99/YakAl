package com.viewpharm.yakal.common.exception.handler;

import com.viewpharm.yakal.common.dto.ResponseDto;
import com.viewpharm.yakal.common.exception.CommonException;
import com.viewpharm.yakal.common.exception.type.ErrorCode;
import jakarta.validation.ConstraintViolationException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(value = {ConstraintViolationException.class})
    public ResponseDto<?> handleConstraintViolationException(ConstraintViolationException e) {
        log.error("handleConstraintViolationException() in GlobalExceptionHandler throw ConstraintViolationException : {}", e.getMessage());
        return ResponseDto.toResponseEntity(e);
    }

    @ExceptionHandler(value = {MethodArgumentNotValidException.class})
    public ResponseDto<?> handleArgumentNotValidException(MethodArgumentNotValidException e) {
        log.error("handleArgumentNotValidException() in GlobalExceptionHandler throw MethodArgumentNotValidException : {}", e.getMessage());
        return ResponseDto.toResponseEntity(e);
    }

    @ExceptionHandler(value = {CommonException.class})
    public ResponseDto<?> handleApiException(CommonException e) {
        log.error("handleApiException() in GlobalExceptionHandler throw CommonException : {}", e.getErrorCode());
        return ResponseDto.toResponseEntity(e);
    }

    @ExceptionHandler(value = {Exception.class})
    public ResponseDto<?> handleException(Exception e) {
        log.error("handleException() in GlobalExceptionHandler throw Exception : {}", e.getMessage());
        return ResponseDto.toResponseEntity(new CommonException(ErrorCode.SERVER_ERROR));
    }
}
