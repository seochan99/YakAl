package com.viewpharm.yakal.guardian.controller;

import com.viewpharm.yakal.common.annotation.Date;
import com.viewpharm.yakal.common.annotation.UserId;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.guardian.dto.response.UserListDtoForGuardian;
import com.viewpharm.yakal.guardian.service.GuardianService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/guardian")
@Tag(name = "Guardian", description = "환자와 보호자 기능")
public class GuardianController {
    private final GuardianService guardianService;

    @GetMapping("/search")
    @Operation(summary = "등록할 보호자 검색", description = "등록할 보호자 검색")
    public ResponseDto<List<UserListDtoForGuardian>> getUserForGuardian(@RequestParam("name") String name,
                                                                        @RequestParam("date") @Valid @Date @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date) {
        return ResponseDto.ok(guardianService.searchUserForGuardian(name, date));
    }

    @PostMapping("/{guardianId}")
    @Operation(summary = "보호자 추가", description = "보호자 추가")
    public ResponseDto<Boolean> createGuardian(@UserId Long patientId, @PathVariable Long guardianId) {
        return ResponseDto.ok(guardianService.createGuardian(guardianId, patientId));
    }

    @DeleteMapping("/{guardianId}")
    @Operation(summary = "보호자 삭제", description = "보호자 삭제")
    public ResponseDto<Boolean> deleteFollow(@UserId Long patientId, @PathVariable Long guardianId) {
        return ResponseDto.ok(guardianService.deleteGuardian(guardianId, patientId));
    }
}
