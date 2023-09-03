package com.viewpharm.yakal.service;

import com.nimbusds.jose.shaded.gson.JsonObject;
import com.nimbusds.jose.shaded.gson.JsonParser;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.type.ESex;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    @Value("${iamport.api-key}")
    private String impKey;
    @Value("${iamport.api-secret}")
    private String impSecret;

    public User getUserInfo(final Long userId) {
        return userRepository.findById(userId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
    }

    public void identify(final Long userId, final String impUid) {
        final WebClient tokenWebClient = WebClient.builder()
                .defaultHeader("Content-Type", String.valueOf(MediaType.APPLICATION_JSON))
                .build();

        final MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>(2);
        parameters.add("imp_key", impKey);
        parameters.add("imp_secret", impSecret);

        final String tokenResponseJsonBody = tokenWebClient.post()
                .uri("https://api.iamport.kr/users/getToken")
                .body(BodyInserters.fromFormData(parameters))
                .retrieve()
                .bodyToMono(String.class)
                .flux()
                .toStream()
                .findFirst()
                .orElseThrow(() -> new CommonException(ErrorCode.IDENTIFICATION_ERROR));

        final String accessToken = JsonParser.parseString(tokenResponseJsonBody)
                .getAsJsonObject()
                .get("response")
                .getAsJsonObject()
                .get("access_token")
                .getAsString();

        final WebClient certificationWebClient = WebClient.builder()
                .defaultHeader("Authorization", "Bearer " + accessToken)
                .build();

        final String certResponseJsonBody = certificationWebClient.get()
                .uri("https://api.iamport.kr/certifications/" + impUid)
                .retrieve()
                .bodyToMono(String.class)
                .flux()
                .toStream()
                .findFirst()
                .orElseThrow(() -> new CommonException(ErrorCode.IDENTIFICATION_ERROR));

        final JsonObject certResponseJsonObject = JsonParser.parseString(certResponseJsonBody)
                .getAsJsonObject()
                .get("response")
                .getAsJsonObject();

        final String name = certResponseJsonObject.get("name").getAsString();
        final String birth = certResponseJsonObject.get("birthday").getAsString();
        final String phone = certResponseJsonObject.get("phone").getAsString();

        final User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        user.setName(name);
        user.setBirthday(LocalDate.parse(birth, DateTimeFormatter.ISO_DATE));
        user.setTel(phone);
    }

    public void updateUserInfo(final Long userId, final String name, final Boolean isDetail, final LocalDate birthday, final ESex sex) {
        final Integer isUpdated = userRepository.updateNameAndBirthdayAndIsDetailAndSexById(userId, name, birthday, isDetail, sex);

        if (isUpdated == 0) {
            throw new CommonException(ErrorCode.NOT_FOUND_USER);
        }
    }

    public boolean checkIsRegistered(final Long userId) throws CommonException {
        final User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        return (user.getBirthday() != null
                && user.getName() != null
                && user.getSex() != null
                && user.getIsDetail() != null);
    }

    public void updateName(final Long userId, final String name) {
        final Integer isUpdated = userRepository.updateNameById(userId, name);

        if (isUpdated == 0) {
            throw new CommonException(ErrorCode.NOT_FOUND_USER);
        }
    }

    public void updateIsDetail(final Long userId, final Boolean isDetail) {
        final Integer isUpdated = userRepository.updateIsDetailById(userId, isDetail);

        if (isUpdated == 0) {
            throw new CommonException(ErrorCode.NOT_FOUND_USER);
        }
    }

    public void updateIsAllowedNotification(final Long userId, final Boolean isAllowedNotification) {
        final Integer isUpdated = userRepository.updateNotiIsAllowedById(userId, isAllowedNotification);

        if (isUpdated == 0) {
            throw new CommonException(ErrorCode.NOT_FOUND_USER);
        }
    }
}
