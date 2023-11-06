package com.viewpharm.yakal.auth.domain;

import com.viewpharm.yakal.base.type.ELoginProvider;
import lombok.extern.slf4j.Slf4j;

import java.util.Map;

@Slf4j
public class OAuth2UserInfoFactory {
    public static OAuth2UserInfo getOAuth2UserInfo(ELoginProvider provider, Map<String, Object> attributes) {
        log.info("OAuth2UserInfoFactory.getOAuth2UserInfo() provider: {}, attributes: {}", provider, attributes);
        return switch (provider) {
            case GOOGLE -> new GoogleOAuth2UserInfo(attributes);
            case KAKAO -> new KakaoOAuth2UserInfo(attributes);
            default -> throw new IllegalArgumentException("Invalid Provider Type.");
        };
    }
}
