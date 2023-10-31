package com.viewpharm.yakal.guardian.controller;

import com.viewpharm.yakal.common.annotation.UserId;
import com.viewpharm.yakal.base.ResponseDto;
import com.viewpharm.yakal.guardian.service.GuardianService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/guardians")
@Tag(name = "Guardian", description = "환자와 보호자 기능")
public class GuardianController {
    private final GuardianService guardianService;

    @PostMapping("/{guardianUserID}")
    @Operation(summary = "보호자 추가", description = "보호자 추가")
    public ResponseDto<Boolean> createGuardian(@UserId Long userId, @PathVariable Long guardianUserID) {
        return ResponseDto.ok(guardianService.createGuardian(userId, guardianUserID));
    }

    @GetMapping("")
    @Operation(summary = "보호자 조회", description = "보호자 추가(User용)")
    public ResponseDto<?> readGuardian(@UserId Long userId) {
        return ResponseDto.ok(guardianService.readResentGuardian(userId));
    }

    @DeleteMapping("/{guardianUserID}")
    @Operation(summary = "보호자 삭제", description = "보호자 삭제")
    public ResponseDto<Boolean> deleteGuardian(@UserId Long userId, @PathVariable Long guardianUserID) {
        return ResponseDto.ok(guardianService.deleteGuardian(userId, guardianUserID));
    }
}
