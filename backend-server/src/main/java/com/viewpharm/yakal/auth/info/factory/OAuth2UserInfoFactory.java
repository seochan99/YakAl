package com.viewpharm.yakal.auth.info.factory;

import com.viewpharm.yakal.auth.info.GoogleOAuth2UserInfo;
import com.viewpharm.yakal.auth.info.KakaoOAuth2UserInfo;
import com.viewpharm.yakal.auth.info.OAuth2UserInfo;
import com.viewpharm.yakal.base.type.ELoginProvider;
import lombok.extern.slf4j.Slf4j;

import java.util.Map;

public class OAuth2UserInfoFactory {
    public static OAuth2UserInfo getOAuth2UserInfo(ELoginProvider provider, Map<String, Object> attributes) {
        return switch (provider) {
            case GOOGLE -> new GoogleOAuth2UserInfo(attributes);
            case KAKAO -> new KakaoOAuth2UserInfo(attributes);
            default -> throw new IllegalArgumentException("Invalid Provider Type.");
        };
    }
}
