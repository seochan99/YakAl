package com.viewpharm.yakal.notification;

import com.viewpharm.yakal.base.dto.ResponseDto;
import com.viewpharm.yakal.base.annotation.UserId;
import com.viewpharm.yakal.notification.dto.reqeust.NotificationUserRequestDto;
import com.viewpharm.yakal.notification.service.NotificationScheduleService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@Deprecated
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/notification")
@Tag(name = "Notification", description = "알림 조회, 읽음 처리, 삭제")
@Tag(name = "Notification", description = "알림 조회, 삭제, 알림으로 복용 체크")
public class NotificationController {
    private final NotificationScheduleService notificationScheduleService;
    @GetMapping("/notificationTest")
    public ResponseDto<Boolean> createNotificationTest() throws Exception {
        return ResponseDto.ok(notificationScheduleService.sendPushNotificationTest());
    }

    @PostMapping("/notificationTest2")
    public ResponseDto<Boolean> createNotificationTest2(@UserId Long id, @RequestBody NotificationUserRequestDto requestDto) throws Exception {
        return ResponseDto.ok(notificationScheduleService.sendPushNotificationTest2(id, requestDto));
    }
}
