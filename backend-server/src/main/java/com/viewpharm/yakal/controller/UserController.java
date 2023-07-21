package com.viewpharm.yakal.controller;

import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/user")
@Tag(name = "User", description = "사용자 정보 열람, 수정 및 사용자 탈퇴")
public class UserController {
}
