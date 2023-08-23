package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.annotation.UserId;
import com.viewpharm.yakal.dto.NotificationDto;
import com.viewpharm.yakal.dto.request.NotificationTestRequestDto;
import com.viewpharm.yakal.service.NotificationScheduleService;
import com.viewpharm.yakal.service.NotificationService;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.utils.NotificationUtil;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/notification")

@Tag(name = "Notification", description = "알림 조회, 읽음 처리, 삭제")

@Tag(name = "Notification", description = "알림 조회, 삭제, 알림으로 복용 체크")

public class NotificationController {
    private final NotificationService notificationService;
    private final NotificationUtil notificationUtil;
    private final NotificationScheduleService notificationScheduleService;

    //Notification Read
    @GetMapping("")
    @Operation(summary = "알림 조회", description = "유저에게 작성된 알림 조회")
    public ResponseDto<List<NotificationDto>> readNotification(@UserId Long id, @RequestParam("page") Long page, @RequestParam("num") Long num) {
        return ResponseDto.ok(notificationService.readNotification(id, page, num));
    }

    //Notification Update
    @PutMapping("/{notificationId}")
    @Operation(summary = "알림 읽음 처리", description = "유저가 선택한 알림 읽음 처리")
    public ResponseDto<Boolean> updateNotification(@UserId Long id, @PathVariable Long notificationId) {
        return ResponseDto.ok(notificationService.updateNotification(id, notificationId));
    }

    //Notification Delete
    @DeleteMapping("/{notificationId}")
    @Operation(summary = "알림 삭제", description = "유저가 선택한 알림 삭제")
    public ResponseDto<Boolean> deleteNotification(@UserId Long id, @PathVariable Long notificationId) {
        return ResponseDto.ok(notificationService.deleteNotification(id, notificationId));
    }

    @GetMapping("/notificationTest")
    public ResponseDto<Boolean> createNotificationTest() throws Exception {
        return ResponseDto.ok(notificationScheduleService.sendPushNotificationTest());
    }


}
