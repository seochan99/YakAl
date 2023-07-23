package com.viewpharm.yakal.dto;


import lombok.Builder;
import lombok.Getter;
import io.micrometer.common.lang.Nullable;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.viewpharm.yakal.exception.CommonException;
import jakarta.validation.ConstraintViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.MethodArgumentNotValidException;

@Getter
@Builder
public class ResponseDto<T> {

    @JsonIgnore
    private HttpStatus httpStatus;
    private final Boolean success;
    private final T data;
    private ExceptionDto error;

    public ResponseDto(final HttpStatus httpStatus, final Boolean success,
                       @Nullable final T data, final ExceptionDto error) {
        this.httpStatus = httpStatus;
        this.success = success;
        this.data = data;
        this.error = error;
    }

    public static <T> ResponseDto<T> ok(@Nullable final T data) {
        return new ResponseDto<>(HttpStatus.OK, true, data, null);
    }

    public static <T> ResponseDto<T> created(@Nullable final T data) {
        return new ResponseDto<>(HttpStatus.CREATED, true, data, null);
    }

    public static ResponseDto<Object> toResponseEntity(final ConstraintViolationException e) {
        return new ResponseDto<>(HttpStatus.BAD_REQUEST, false, null, new ArgumentNotValidExceptionDto(e));
    }

    public static ResponseDto<Object> toResponseEntity(final MethodArgumentNotValidException e) {
        return new ResponseDto<>(HttpStatus.BAD_REQUEST, false, null, new ArgumentNotValidExceptionDto(e));
    }

    public static ResponseDto<Object> toResponseEntity(final CommonException e) {
        return new ResponseDto<>(e.getErrorCode().getHttpStatus(), false, null, new ExceptionDto(e.getErrorCode()));
    }
}