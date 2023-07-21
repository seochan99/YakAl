package com.viewpharm.yakal.controller;

import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/notification")
@Tag(name = "Notification", description = "알림 조회, 삭제, 알림으로 복용 체크")
public class NotificationController {
}
