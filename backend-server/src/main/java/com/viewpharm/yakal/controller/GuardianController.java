package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.annotation.UserId;
import com.viewpharm.yakal.dto.request.BoardRequestDto;
import com.viewpharm.yakal.dto.response.PatientDto;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.service.GuardianService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/guardian")
@Tag(name = "Guardian", description = "환자와 보호자 기능")
public class GuardianController {
    private final GuardianService guardianService;

    @PostMapping("/{guardianId}")
    @Operation(summary = "보호자 추가", description = "보호자 추가")
    public ResponseDto<Boolean> createGuardian(@UserId Long id, @PathVariable Long guardianId) {
        return ResponseDto.ok(guardianService.createGuardian(guardianId, id));
    }

    @GetMapping("/{guardianId}")
    @Operation(summary = "보호중인 환자 찾기", description = "해당 유저가 보호하고 있는 유저 찾기")
    public ResponseDto<PatientDto> readPatient(@UserId Long id, @PathVariable Long guardianId) {
        return ResponseDto.ok(guardianService.readPatient(guardianId));
    }

    @GetMapping("/{patientId}")
    @Operation(summary = "보호자 찾기", description = "해당 유저의 보호자 찾기")
    public ResponseDto<PatientDto> readGuardian(@UserId Long id, @PathVariable Long patientId) {
        return ResponseDto.ok(guardianService.readGuardian(patientId));
    }

    @DeleteMapping("/{guardianId}")
    @Operation(summary = "보호자 삭제", description = "해당 유저의 보호자 삭제")
    public ResponseDto<Boolean> deleteFollow(@UserId Long patientId, @PathVariable Long guardianId) {
        return ResponseDto.ok(guardianService.deleteGuardian(guardianId, patientId));
    }
}
