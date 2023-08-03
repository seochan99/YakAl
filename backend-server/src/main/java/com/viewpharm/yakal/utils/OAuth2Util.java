package com.viewpharm.yakal.utils;

import com.nimbusds.jose.shaded.gson.JsonParser;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;

@Slf4j
@Component
public class OAuth2Util {

    // KAKAO
    @Value("${client.provider.kakao.authorization-uri: aaa.bbb.ccc}")
    private String KAKAO_AUTHORIZATION_URL;
    @Value("${client.provider.kakao.token-uri: aaa.bbb.ccc}")
    private String KAKAO_TOKEN_URL;
    @Value("${client.provider.kakao.user-info-uri: aaa.bbb.ccc}")
    private String KAKAO_USERINFO_URL;
    @Value("${client.registration.kakao.client-id: aaa.bbb.ccc}")
    private String KAKAO_CLIENT_ID;
    @Value("${client.registration.kakao.client-secret: aaa.bbb.ccc}")
    private String KAKAO_CLIENT_SECRET;
    @Value("${client.registration.kakao.redirect-uri: aaa.bbb.ccc}")
    private String KAKAO_REDIRECT_URL;

    // GOOGLE 용 Data
    @Value("${client.provider.google.authorization-uri: aaa.bbb.ccc}")
    private String GOOGLE_AUTHORIZATION_URL;
    @Value("${client.provider.google.token-uri: aaa.bbb.ccc}")
    private String GOOGLE_TOKEN_URL;
    @Value("${client.provider.google.user-info-uri: aaa.bbb.ccc}")
    private String GOOGLE_USERINFO_URL;
    @Value("${client.registration.google.client-id: aaa.bbb.ccc}")
    private String GOOGLE_CLIENT_ID;
    @Value("${client.registration.google.client-secret: aaa.bbb.ccc}")
    private String GOOGLE_CLIENT_SECRET;
    @Value("${client.registration.google.redirect-uri: aaa.bbb.ccc}")
    private String GOOGLE_REDIRECT_URL;


    public String getKakaoRedirectUrl() {
        return KAKAO_AUTHORIZATION_URL
                + "?client_id=" + KAKAO_CLIENT_ID
                + "&redirect_uri=" + KAKAO_REDIRECT_URL
                + "&response_type=code";
    }

    public String getGoogleRedirectUrl() {
        return GOOGLE_AUTHORIZATION_URL
                + "?client_id=" + GOOGLE_CLIENT_ID
                + "&redirect_uri=" + GOOGLE_REDIRECT_URL
                + "&response_type=code&scope=https://www.googleapis.com/auth/userinfo.profile";
    }

    public String getKakaoUserInformation(final String accessToken) {
        final WebClient webClient = WebClient.builder()
                .defaultHeaders(httpHeaders -> {
                            httpHeaders.setBearerAuth(accessToken);
                            httpHeaders.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
                        })
                .build();

        final String responseJsonBody = webClient.post()
                .uri(KAKAO_USERINFO_URL)
                .retrieve()
                .onStatus(httpStatusCode -> httpStatusCode.is4xxClientError() || httpStatusCode.is5xxServerError(),
                        clientResponse -> {
                            throw new CommonException(ErrorCode.AUTH_SERVER_USER_INFO_ERROR);
                        })
                .bodyToMono(String.class)
                .flux()
                .toStream()
                .findFirst()
                .orElseThrow(() -> new CommonException(ErrorCode.AUTH_SERVER_USER_INFO_ERROR));

        return JsonParser.parseString(responseJsonBody)
                .getAsJsonObject()
                .get("id")
                .getAsString();
    }

    public String getGoogleUserInformation(final String accessToken) {
        final WebClient webClient = WebClient.builder()
                .defaultHeaders(httpHeaders -> {
                    httpHeaders.setBearerAuth(accessToken);
                    httpHeaders.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
                })
                .build();

        final String responseJsonBody = webClient.get()
                .uri(GOOGLE_USERINFO_URL)
                .retrieve()
                .onStatus(httpStatusCode -> httpStatusCode.is4xxClientError() || httpStatusCode.is5xxServerError(),
                        clientResponse -> {
                            throw new CommonException(ErrorCode.AUTH_SERVER_USER_INFO_ERROR);
                        })
                .bodyToMono(String.class)
                .flux()
                .toStream()
                .findFirst()
                .orElseThrow(() -> new CommonException(ErrorCode.AUTH_SERVER_USER_INFO_ERROR));

        return JsonParser.parseString(responseJsonBody)
                .getAsJsonObject()
                .get("id")
                .getAsString();
    }
}