package com.viewpharm.yakal.base.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nimbusds.jose.shaded.gson.JsonParser;
import com.viewpharm.yakal.base.exception.CommonException;
import com.viewpharm.yakal.base.exception.ErrorCode;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwsHeader;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.bouncycastle.asn1.pkcs.PrivateKeyInfo;
import org.bouncycastle.openssl.jcajce.JcaPEMKeyConverter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.reactive.function.client.WebClient;
import org.apache.commons.io.FileUtils;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.bouncycastle.openssl.PEMParser;

import java.io.File;
import java.io.FileReader;
import java.io.InputStream;
import java.math.BigInteger;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.RSAPublicKeySpec;
import java.util.Base64;
import java.util.Date;
import java.util.List;

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
    @Value("${client.registration.kakao.redirect-uri: aaa.bbb.ccc}")
    private String KAKAO_REDIRECT_URL;

    // APPLE
    @Value("${client.provider.apple.base-url: aaa.bbb.ccc}")
    private String APPLE_BASE_URL;
    @Value("${client.provider.apple.authorization-uri: aaa.bbb.ccc}")
    private String APPLE_AUTHORIZATION_URL;
    @Value("${client.provider.apple.token-uri: aaa.bbb.ccc}")
    private String APPLE_TOKEN_URL;
    @Value("${client.provider.apple.jwk-uri: aaa.bbb.ccc}")
    private String APPLE_JWT_URL;
    @Value("${client.registration.apple.teamId: aaa.bbb.ccc}")
    private String APPLE_TEAM_ID;
    @Value("${client.registration.apple.clientId: aaa.bbb.ccc}")
    private String APPLE_CLIENT_ID;
    @Value("${client.registration.apple.clientKey: aaa.bbb.ccc}")
    private String APPLE_CLIENT_KEY;
    @Value("${client.registration.apple.redirect-uri: aaa.bbb.ccc}")
    private String APPLE_REDIRECT_URL;
    @Value(value = "${client.registration.apple.auth-key-file: aaa.bbb.ccc}")
    private String APPLE_KEY_NAME;

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

    private static final RestTemplate restTemplate = new RestTemplate();

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

    public String getAppleRedirectUrl() {
        return APPLE_AUTHORIZATION_URL
                + "?client_id=" + APPLE_CLIENT_ID
                + "&redirect_uri=" + APPLE_REDIRECT_URL
                + "&response_type=code%20id_token&scope=name%20email&response_mode=form_post";
    }

    public String getKakaoUserInformation(final String accessToken) throws CommonException {
        final WebClient webClient = WebClient.builder()
                .defaultHeaders(httpHeaders -> {
                            httpHeaders.setBearerAuth(accessToken);
                            httpHeaders.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
                        })
                .build();

        final String responseJsonBody = webClient.post()
                .uri(KAKAO_USERINFO_URL)
                .retrieve()

//                .onStatus(httpStatusCode -> httpStatusCode.is4xxClientError() || httpStatusCode.is5xxServerError(),
//                        clientResponse -> Mono.just(new CommonException()))
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

//    public String getAppleUserInformation(final String authorizationCode) throws CommonException {
//        final WebClient appleIdWebClient = WebClient.builder()
//                .defaultHeaders(httpHeaders -> {
//                    httpHeaders.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
//                })
//                .build();
//
//        try {
//            final InputStream inputStream = new ClassPathResource(APPLE_KEY_NAME).getInputStream();
//            final File file = File.createTempFile("AuthKey", ".p8");
//
//            try {
//                FileUtils.copyInputStreamToFile(inputStream, file);
//            } finally {
//                IOUtils.closeQuietly(inputStream);
//            }
//
//            final PEMParser pemParser = new PEMParser(new FileReader(file));
//            final JcaPEMKeyConverter converter = new JcaPEMKeyConverter();
//            final PrivateKeyInfo object = (PrivateKeyInfo) pemParser.readObject();
//            final PrivateKey pKey = converter.getPrivateKey(object);
//            pemParser.close();
//
//            final String secretKey = Jwts.builder()
//                    .setHeaderParam(JwsHeader.KEY_ID, APPLE_CLIENT_KEY)
//                    .setIssuer(APPLE_TEAM_ID)
//                    .setAudience(APPLE_BASE_URL)
//                    .setSubject(APPLE_CLIENT_ID)
//                    .setExpiration(new Date(System.currentTimeMillis() + (10000 * 60 * 5)))
//                    .setIssuedAt(new Date(System.currentTimeMillis()))
//                    .signWith(SignatureAlgorithm.ES256, pKey)
//                    .compact();
//
//            final MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
//            parameters.add("grant_type", "authorization_code");
//            parameters.add("client_id", APPLE_CLIENT_ID);
//            parameters.add("client_secret", secretKey);
//            parameters.add("code", authorizationCode);
//            parameters.add("redirect_uri", APPLE_REDIRECT_URL);
//
//            final String responseJsonBody = appleIdWebClient.post()
//                    .uri(APPLE_TOKEN_URL)
//                    .body(BodyInserters.fromFormData(parameters))
//                    .retrieve()
//                    .onStatus(httpStatusCode -> httpStatusCode.is4xxClientError() || httpStatusCode.is5xxServerError(),
//                            clientResponse -> {
//                                throw new CommonException(ErrorCode.AUTH_SERVER_USER_INFO_ERROR);
//                            })
//                    .bodyToMono(String.class)
//                    .flux()
//                    .toStream()
//                    .findFirst()
//                    .orElseThrow(() -> new CommonException(ErrorCode.AUTH_SERVER_USER_INFO_ERROR));
//
//            final AppleIdTokenResponse appleIdTokenResponse = new ObjectMapper().readValue(responseJsonBody, AppleIdTokenResponse.class);
//
//            final WebClient publicKeyWebClient = WebClient.create();
//
//            final Key publicKeyResponseBody = publicKeyWebClient.get()
//                    .uri(APPLE_JWT_URL)
//                    .retrieve()
//                    .onStatus(httpStatusCode -> httpStatusCode.is4xxClientError() || httpStatusCode.is5xxServerError(),
//                            clientResponse -> {
//                                throw new CommonException(ErrorCode.AUTH_SERVER_USER_INFO_ERROR);
//                            })
//                    .bodyToMono(Key.class)
//                    .flux()
//                    .toStream()
//                    .findFirst()
//                    .orElseThrow(() -> new CommonException(ErrorCode.AUTH_SERVER_USER_INFO_ERROR));
//
//            String userId = null;
//
//            for (JWTSetKeys keys : publicKeyResponseBody.getKeys()) {
//                final BigInteger modulus = new BigInteger(1, Base64.getUrlDecoder().decode(keys.getN()));
//                final BigInteger exponent = new BigInteger(1, Base64.getUrlDecoder().decode(keys.getE()));
//                final PublicKey publicKey = KeyFactory.getInstance(keys.getKty()).generatePublic(new RSAPublicKeySpec(modulus, exponent));
//
//                try {
//                    final Claims claims = Jwts.parser()
//                            .setSigningKey(publicKey)
//                            .parseClaimsJws(appleIdTokenResponse.getId_token()).getBody();
//                    userId = claims.get("sub", String.class);
//                } catch (Exception e) {
//                }
//            }
//
//            return userId;
//        } catch (Exception e) {
//            throw new CommonException(ErrorCode.AUTH_SERVER_USER_INFO_ERROR);
//        }
//    }

    public String getAppleUserInformation(String authorizationCode)  {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/x-www-form-urlencoded");
        try {
            MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
            parameters.add("grant_type", "authorization_code");
            parameters.add("client_id", APPLE_CLIENT_ID);
            parameters.add("client_secret", generateSecretKey());
            parameters.add("code", authorizationCode);
            parameters.add("redirect_uri", APPLE_REDIRECT_URL);
            HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<MultiValueMap<String, String>>(parameters, headers);

            ResponseEntity<String> responseEntity = restTemplate.postForEntity(APPLE_TOKEN_URL, entity, String.class);

            if (responseEntity.getStatusCode().is2xxSuccessful()) {
                AppleIdTokenResponse appleIdTokenResponse = new ObjectMapper().readValue(responseEntity.getBody(), AppleIdTokenResponse.class);
                return getUserInfo(appleIdTokenResponse);
            }
        } catch (Exception e) {
            log.error("{}", e.getMessage());
        }
        return null;
    }

    private String generateSecretKey() throws Exception {
        PrivateKey pKey = generatePrivateKey();
        return Jwts.builder()
                .setHeaderParam(JwsHeader.KEY_ID, APPLE_CLIENT_KEY)
                .setIssuer(APPLE_TEAM_ID)
                .setAudience(APPLE_BASE_URL)
                .setSubject(APPLE_CLIENT_ID)
                .setExpiration(new Date(System.currentTimeMillis() + (10000 * 60 * 5)))
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .signWith(SignatureAlgorithm.ES256, pKey)
                .compact();
    }

    private PrivateKey generatePrivateKey() throws Exception {
        InputStream inputStream = new ClassPathResource(APPLE_KEY_NAME).getInputStream();

        File file = File.createTempFile("AuthKey", ".p8");
        try {
            FileUtils.copyInputStreamToFile(inputStream, file);
        } finally {
            IOUtils.closeQuietly(inputStream);
        }

        final PEMParser pemParser = new PEMParser(new FileReader(file));
        final JcaPEMKeyConverter converter = new JcaPEMKeyConverter();
        final PrivateKeyInfo object = (PrivateKeyInfo) pemParser.readObject();
        final PrivateKey pKey = converter.getPrivateKey(object);
        pemParser.close();
        return pKey;
    }

    private String getUserInfo(AppleIdTokenResponse appleIdTokenResponse) throws InvalidKeySpecException, NoSuchAlgorithmException {
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Key> responseEntity = restTemplate.getForEntity(APPLE_JWT_URL, Key.class);
        if (responseEntity.getStatusCode().is2xxSuccessful()) {
            String user = createPublicKeyApple(appleIdTokenResponse, responseEntity.getBody().getKeys());
            return user;
        }

        return "User id Not Found";
    }

    private String createPublicKeyApple(AppleIdTokenResponse appleIdTokenResponse, List<JWTSetKeys> keysList) throws NoSuchAlgorithmException, InvalidKeySpecException {
        JWTSetKeys applePublicKey = null;
        for (JWTSetKeys keys : keysList) {
            applePublicKey = keys;
            BigInteger modulus = new BigInteger(1, Base64.getUrlDecoder().decode(applePublicKey.getN()));
            BigInteger exponent = new BigInteger(1, Base64.getUrlDecoder().decode(applePublicKey.getE()));
            PublicKey publicKey = KeyFactory.getInstance(applePublicKey.getKty()).generatePublic(new RSAPublicKeySpec(modulus, exponent));
            try {
                Claims claims = getClaims(publicKey, appleIdTokenResponse);
                return claims.get("sub", String.class);
            } catch (Exception exception) {
            }
        }

        return "Error Occured...";
    }

    private Claims getClaims(PublicKey publicKey, AppleIdTokenResponse appleIdTokenResponse) {
        return Jwts.parser()
                .setSigningKey(publicKey)
                .parseClaimsJws(appleIdTokenResponse.getId_token()).getBody();
    }

    @Getter
    @Setter
    @AllArgsConstructor
    @RequiredArgsConstructor
    private static class AppleIdTokenResponse {
        private String access_token;
        private String token_type;
        private String expires_in;
        private String refresh_token;
        private String id_token;
    }

    @Getter
    @Setter
    @AllArgsConstructor
    @RequiredArgsConstructor
    private static class JWTSetKeys {
        private String kty;
        private String kid;
        private String use;
        private String alg;
        private String n;
        private String e;
    }

    @Getter
    @Setter
    @AllArgsConstructor
    @RequiredArgsConstructor
    private static class Key {
        private List<JWTSetKeys> keys;
    }

    public String getKakaoAccessToken(final String authorizationCode) {
        final RestTemplate restTemplate = new RestTemplate();

        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        final MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
        parameters.add("grant_type", "authorization_code");
        parameters.add("client_id", KAKAO_CLIENT_ID);
        parameters.add("redirect_uri", KAKAO_REDIRECT_URL);
        parameters.add("code", authorizationCode);

        HttpEntity<MultiValueMap<String,String>> kakaoTokenRequest = new HttpEntity<>(parameters, httpHeaders);

        ResponseEntity<String> response = restTemplate.exchange(
                KAKAO_TOKEN_URL,
                HttpMethod.POST,
                kakaoTokenRequest,
                String.class
        );

        return JsonParser.parseString(response.getBody()).getAsJsonObject().get("access_token").getAsString();
    }

    public String getGoogleAccessToken(final String authorizationCode) {
        final RestTemplate restTemplate = new RestTemplate();

        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        final MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
        parameters.add("grant_type", "authorization_code");
        parameters.add("client_id", GOOGLE_CLIENT_ID);
        parameters.add("client_secret", GOOGLE_CLIENT_SECRET);
        parameters.add("redirect_uri", GOOGLE_REDIRECT_URL);
        parameters.add("code", authorizationCode);

        HttpEntity<MultiValueMap<String,String>> googleTokenRequest = new HttpEntity<>(parameters, httpHeaders);

        ResponseEntity<String> response = restTemplate.exchange(
                GOOGLE_TOKEN_URL,
                HttpMethod.POST,
                googleTokenRequest,
                String.class
        );

        return JsonParser.parseString(response.getBody()).getAsJsonObject().get("access_token").getAsString();
    }
}