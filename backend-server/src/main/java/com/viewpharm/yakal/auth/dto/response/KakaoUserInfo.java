package com.viewpharm.yakal.auth.dto.response;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.Map;

@Getter
@RequiredArgsConstructor
public class KakaoUserInfo {
    private final Map<String, Object> attributes;


    public String getId(){
        return String.valueOf(attributes.get("id"));
    }
}
