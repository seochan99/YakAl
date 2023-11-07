package com.viewpharm.yakal.user.service;

import com.nimbusds.jose.shaded.gson.JsonObject;
import com.nimbusds.jose.shaded.gson.JsonParser;
import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.user.dto.request.ExpertCertificationApproveDto;
import com.viewpharm.yakal.user.dto.request.UpdateNotificationTimeDto;
import com.viewpharm.yakal.user.dto.request.UserDeviceRequestDto;
import com.viewpharm.yakal.user.dto.response.ExpertListDto;
import com.viewpharm.yakal.user.dto.response.UserExpertDto;
import com.viewpharm.yakal.base.exception.CommonException;
import com.viewpharm.yakal.base.exception.ErrorCode;
import com.viewpharm.yakal.user.dto.response.GuardianListDto;
import com.viewpharm.yakal.survey.repository.AnswerRepository;
import com.viewpharm.yakal.user.dto.response.UserRegisterDto;
import com.viewpharm.yakal.user.repository.UserRepository;
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
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final AnswerRepository answerRepository;

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
        user.setIsIdentified(true);
    }

    public Boolean checkIdentification(final Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        return user.getIsIdentified();
    }

    public UserExpertDto getUserExpertInfo(final Long userId) {
        User expert = userRepository.findById(userId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        String establishmentName = userRepository.getEstablishmentNameByIdAndRole(userId).orElseGet(() -> null);

        return UserExpertDto.builder()
                .name(expert.getName())
                .tel(expert.getTel())
                .job(expert.getRole().getDisplayName())
                .birthday(expert.getBirthday())
                .department(expert.getDepartment())
                .belong(establishmentName)
                .isOptionalAgreementAccepted(expert.getIsOptionalAgreementAccepted())
                .isIdentified(expert.getIsIdentified())
                .build();
    }

    public Boolean checkUserOptionalAgreement(final Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        return user.getIsOptionalAgreementAccepted();
    }

    public void updateUserOptionalAgreement(final Long userId, final Boolean isOptionalAgreement) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        user.updateIsOptionalAgreementAccepted(isOptionalAgreement);
    }

    public void updateUserInfo(final Long userId, final String name, final Boolean isDetail) {
        final Integer isUpdated = userRepository.updateNameAndIsDetailById(userId, name, isDetail);

        if (isUpdated == 0) {
            throw new CommonException(ErrorCode.NOT_FOUND_USER);
        }
    }

    public UserRegisterDto checkIsRegistered(final Long userId) throws CommonException {
        final User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        return UserRegisterDto.builder()
                .name(user.getName())
                .isDetail(user.getIsDetail())
                .isOptionalAgreementAccepted(user.getIsOptionalAgreementAccepted())
                .isIdentified(user.getIsIdentified())
                .build();
    }

    public void updateName(final Long userId, final String nickname) {
        final Integer isUpdated = userRepository.updateNickNameById(userId, nickname);

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

    public Long countAnswer(final User user) {
        return answerRepository.countAnswerByUser(user);
    }


    public Boolean updateUserDevice(Long userId, UserDeviceRequestDto requestDto) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        user.updateDevice(requestDto.getDeviceToken());
        return Boolean.TRUE;
    }

    public List<GuardianListDto> searchUserForGuardian(String name, LocalDate birthday) {
        List<User> users = userRepository.searchUserByNameAndBirthday(name, birthday);

        return users.stream()
                .map(u -> new GuardianListDto(u.getId(), u.getName(), u.getBirthday().toString()))
                .collect(Collectors.toList());
    }

    public List<ExpertListDto> searchUserForExpert(String expertName) {
        List<User> experts = userRepository.searchExpertByName(expertName);

        return experts.stream()
                .map(u -> new ExpertListDto(u.getId(), u.getName(), u.getMedicalEstablishment().getName()))
                .collect(Collectors.toList());
    }

    public Boolean setUserNotificationTime(Long userId, UpdateNotificationTimeDto requestDto) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        LocalTime time = requestDto.getTime();

        if (requestDto.getTimezone().equals("breakfast") && time.isAfter(LocalTime.of(06, 59, 59)) && time.isBefore(LocalTime.of(11, 00, 00))) {
            user.updateBreakfastNotificationTime(requestDto.getTime());
        } else if (requestDto.getTimezone().equals("lunch") && time.isAfter(LocalTime.of(10, 59, 59)) && time.isBefore(LocalTime.of(17, 00, 00))) {
            user.updateLunchNotificationTime(requestDto.getTime());
        } else if (requestDto.getTimezone().equals("dinner") && time.isAfter(LocalTime.of(16, 59, 59)) && time.isBefore(LocalTime.of(23, 59, 59))) {
            user.updateDinnerNotificationTime(requestDto.getTime());
        } else {
            throw new CommonException(ErrorCode.INVALID_ARGUMENT);
        }

        return Boolean.TRUE;
    }
}
