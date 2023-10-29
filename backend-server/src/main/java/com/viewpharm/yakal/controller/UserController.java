package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.annotation.UserId;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.dto.request.*;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.dto.response.UserInfoDto;
import com.viewpharm.yakal.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/api/v1/user")
@RequiredArgsConstructor
@Tag(name = "User", description = "사용자 정보 열람, 수정 및 사용자 탈퇴")
public class UserController {

    private final UserService userService;
    @GetMapping("")
    @Operation(summary = "사용자 정보 가져오기")
    public ResponseDto<UserInfoDto> getUserInfo(@UserId Long id) {
        final User user = userService.getUserInfo(id);
        final UserInfoDto userInfoDto = UserInfoDto.builder()
                .Nickname(user.getName())
                .isDetail(user.getIsDetail())
                .notiIsAllowed(user.getNotiIsAllowed())
                .breakfastTime(user.getBreakfastTime().toString())
                .lunchTime(user.getLunchTime().toString())
                .dinnerTime(user.getDinnerTime().toString())
                .AnswerCount(userService.countAnswer(user))
                .build();

        return ResponseDto.ok(userInfoDto);
    }

    @PatchMapping("")
    @Operation(summary = "최초 로그인 시 사용자 정보 일부 수정하기")
    public ResponseDto<?> updateUserInfo(@UserId Long id, @RequestBody @Valid UpdateUserInfoDto updateUserInfoDto) {
        userService.updateUserInfo(
                id, updateUserInfoDto.getNickname(), updateUserInfoDto.getIsDetail()
        );
        return ResponseDto.ok(null);
    }

    @PatchMapping("/identify")
    @Operation(summary = "사용자 본인인증")
    public ResponseDto<Map<String, String>> identify(@UserId Long id, @RequestBody @Valid IdentifyDto identifyDto) {
        userService.identify(id, identifyDto.getImpUid());
        return ResponseDto.ok(null);
    }

    @GetMapping("/check/identification")
    @Operation(summary = "사용자 본인인증 여부 확인")
    public ResponseDto<Map<String, Boolean>> checkIdentification(@UserId Long id) {
        final Map<String, Boolean> map = new HashMap<>(1);
        map.put("isIdentified", userService.checkIdentification(id));

        log.info("isIdentified: {}", userService.checkIdentification(id));

        return ResponseDto.ok(map);
    }

    @GetMapping("/register")
    @Operation(summary = "최초 로그인 시 설정되어야 하는 정보가 전부 설정되어있는지 확인")
    public ResponseDto<?> checkIsRegistered(@UserId Long id) {
        final Map<String, Boolean> map = new HashMap<>(1);
        map.put("isRegistered", userService.checkIsRegistered(id));
        return ResponseDto.ok(map);
    }

    @PatchMapping("/name")
    @Operation(summary = "사용자 이름 수정하기")
    public ResponseDto<?> updateName(@UserId Long id, @RequestBody @Valid UpdateNameDto updateNameDto) {
        userService.updateName(id, updateNameDto.getNickname());
        return ResponseDto.ok(null);
    }

    @PatchMapping("/detail")
    @Operation(summary = "상세모드(고령자모드) 활성화 여부 수정하기")
    public ResponseDto<?> updateIsDetail(@UserId Long id, @RequestBody @Valid UpdateIsDetailDto updateIsDetailDto) {
        userService.updateIsDetail(id, updateIsDetailDto.getIsDetail());
        return ResponseDto.ok(null);
    }

    @PatchMapping("/notification")
    @Operation(summary = "알림모드 활성화 여부 수정하기")
    public ResponseDto<?> updateIsAllowedNotification(@UserId Long id, @RequestBody @Valid UpdateIsAllowedNotificationDto updateIsAllowedNotificationDto) {
        userService.updateIsAllowedNotification(id, updateIsAllowedNotificationDto.getIsAllowedNotification());
        return ResponseDto.ok(null);
    }

    @PutMapping("/device")
    @Operation(summary = "디바이스 토큰 등록")
    public ResponseDto<Boolean> updateUserDevice(@UserId Long userId, @RequestBody UserDeviceRequestDto requestDto) {
        return ResponseDto.ok(userService.updateUserDevice(userId, requestDto));
    }
}
