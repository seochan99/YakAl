package com.viewpharm.yakal.common.jwt.handler;

import com.viewpharm.yakal.common.exception.type.ErrorCode;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Slf4j
@Component
public class JwtAuthEntryPoint extends JwtErrorResponse implements AuthenticationEntryPoint {

    @Override
    public void commence(final HttpServletRequest request,
                         final HttpServletResponse response,
                         final AuthenticationException authException) throws IOException {
        ErrorCode errorCode = (ErrorCode) request.getAttribute("exception");

        if (errorCode == null) {
            setErrorResponse(response, ErrorCode.NOT_END_POINT);
            return;
        }

        switch (errorCode) {
            case NOT_FOUND_USER -> setErrorResponse(response, ErrorCode.NOT_FOUND_USER);
            case ACCESS_DENIED_ERROR -> setErrorResponse(response, ErrorCode.ACCESS_DENIED_ERROR);
            case TOKEN_MALFORMED_ERROR -> setErrorResponse(response, ErrorCode.TOKEN_MALFORMED_ERROR);
            case TOKEN_EXPIRED_ERROR -> setErrorResponse(response, ErrorCode.TOKEN_EXPIRED_ERROR);
            case TOKEN_TYPE_ERROR -> setErrorResponse(response, ErrorCode.TOKEN_TYPE_ERROR);
            case TOKEN_UNSUPPORTED_ERROR -> setErrorResponse(response, ErrorCode.TOKEN_UNSUPPORTED_ERROR);
            case TOKEN_GENERATION_ERROR -> setErrorResponse(response, ErrorCode.TOKEN_GENERATION_ERROR);
            case TOKEN_UNKNOWN_ERROR -> setErrorResponse(response, ErrorCode.TOKEN_UNKNOWN_ERROR);
            default -> {
                assert (false);
            }
        }
    }
}
