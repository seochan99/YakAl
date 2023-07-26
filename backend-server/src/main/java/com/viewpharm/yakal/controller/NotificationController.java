package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.dto.NotificationDto;
import com.viewpharm.yakal.dto.ResponseDto;
import com.viewpharm.yakal.dto.request.NotificationTestRequestDto;
import com.viewpharm.yakal.service.NotificationService;
import com.viewpharm.yakal.utils.NotificationUtil;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/notification")
@Tag(name = "Notification", description = "알림 조회, 읽음 처리, 삭제")
public class NotificationController {
    private final NotificationService notificationService;
    private final NotificationUtil notificationUtil;

    //Notification Read
    @GetMapping("")
    @Operation(summary = "알림 조회", description = "유저에게 작성된 알림 조회")
    public ResponseDto<List<NotificationDto>> readNotification(Authentication authentication, @RequestParam("page") Long page, @RequestParam("num") Long num) {
        return ResponseDto.ok(notificationService.readNotification(Long.valueOf(authentication.getName()), page, num));
    }

    //Notification Update
    @PutMapping("/{notificationId}")
    @Operation(summary = "알림 읽음 처리", description = "유저가 선택한 알림 읽음 처리")
    public ResponseDto<Boolean> updateNotification(Authentication authentication, @PathVariable Long notificationId) {
        return ResponseDto.ok(notificationService.updateNotification(Long.valueOf(authentication.getName()), notificationId));
    }

    //Notification Delete
    @DeleteMapping("/{notificationId}")
    @Operation(summary = "알림 삭제", description = "유저가 선택한 알림 삭제")
    public ResponseDto<Boolean> deleteNotification(Authentication authentication, @PathVariable Long notificationId) {
        return ResponseDto.ok(notificationService.deleteNotification(Long.valueOf(authentication.getName()), notificationId));
    }

    @PostMapping("/notificationtest")
    public ResponseDto<Boolean> createNotificationTest(@RequestBody NotificationTestRequestDto notificationTestRequestDto) throws Exception {
        return ResponseDto.ok(notificationService.sendPushNotificationTest(notificationTestRequestDto.getLocalDate(), notificationTestRequestDto.getEDosingTime()));

    }


}
