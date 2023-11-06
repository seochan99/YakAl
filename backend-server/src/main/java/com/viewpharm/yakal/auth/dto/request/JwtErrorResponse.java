package com.viewpharm.yakal.auth.dto.request;

import com.viewpharm.yakal.base.exception.dto.ExceptionDto;
import com.viewpharm.yakal.base.exception.ErrorCode;
import jakarta.servlet.http.HttpServletResponse;
import net.minidev.json.JSONValue;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public abstract class JwtErrorResponse {

    protected final void setErrorResponse(HttpServletResponse response, ErrorCode errorCode) throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);

        Map<String, Object> map = new HashMap<>();
        map.put("success", Boolean.FALSE);
        map.put("data", null);
        map.put("error", new ExceptionDto(errorCode));

        response.getWriter().print(JSONValue.toJSONString(map));
    }
}
