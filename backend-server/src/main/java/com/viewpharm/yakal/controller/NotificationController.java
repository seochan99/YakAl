package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.dto.NotificationDto;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.service.NotificationService;
import com.viewpharm.yakal.utils.NotificationUtil;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/notification")
@Tag(name = "Notification", description = "알림 조회, 삭제, 알림으로 복용 체크")
public class NotificationController {
    private final NotificationService notificationService;
    private final NotificationUtil notificationUtil;

    //Notification Read
    @GetMapping("")
    public ResponseDto<List<NotificationDto>> readNotification(Authentication authentication, @RequestParam("page") Long page, @RequestParam("num") Long num) {
        return ResponseDto.ok(notificationService.readNotification(Long.valueOf(authentication.getName()), page, num));
    }

    //Notification Update
    @PutMapping("/{notificationId}")
    public ResponseDto<Boolean> updateNotification(Authentication authentication, @PathVariable Long notificationId) {
        return ResponseDto.ok(notificationService.updateNotification(Long.valueOf(authentication.getName()), notificationId));
    }

    //Notification Delete
    @DeleteMapping("/{notificationId}")
    public ResponseDto<Boolean> deleteNotification(Authentication authentication, @PathVariable Long notificationId) {
        return ResponseDto.ok(notificationService.deleteNotification(Long.valueOf(authentication.getName()), notificationId));
    }
}
