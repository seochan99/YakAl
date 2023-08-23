package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.annotation.UserId;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.dto.request.UpdateIsAllowedNotificationDto;
import com.viewpharm.yakal.dto.request.UpdateIsDetailDto;
import com.viewpharm.yakal.dto.request.UpdateNameDto;
import com.viewpharm.yakal.dto.request.UpdateUserInfoDto;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.dto.response.UserInfoDto;
import com.viewpharm.yakal.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
                .name(user.getName())
                .build();

        return ResponseDto.ok(userInfoDto);
    }

    @PatchMapping("")
    @Operation(summary = "최초 로그인 시 사용자 정보 일부 수정하기")
    public ResponseDto<?> updateUserInfo(@UserId Long id, @RequestBody @Valid UpdateUserInfoDto updateUserInfoDto) {
        userService.updateUserInfo(
                id, updateUserInfoDto.getName(), updateUserInfoDto.getIsDetail(), updateUserInfoDto.getBirthday(), updateUserInfoDto.getSex()
        );
        return ResponseDto.ok(null);
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
}
