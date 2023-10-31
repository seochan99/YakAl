package com.viewpharm.yakal.medicalappointment.controller;

import com.viewpharm.yakal.common.annotation.UserId;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.medicalappointment.service.MedicalAppointmentService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/medical-appointments")
@Tag(name = "병원 진료", description = "병원 진료 Create, Read, Delete")
public class MedicalAppointmentController {
    private final MedicalAppointmentService medicalAppointmentService;

    @PostMapping("/{expertId}")
    @Operation(summary = "입원 기록 작성", description = "입원 기록 작성")
    public ResponseDto<?> createMedicalAppointment(@UserId Long id, @PathVariable Long expertId) {
        return ResponseDto.ok(null);
    }

    @GetMapping("")
    @Operation(summary = "입원 기록 리스트", description = "자신이 작성한 입원 기록 목록 읽기")
    public ResponseDto<?> readMedicalAppointments(@UserId Long id) {
        return ResponseDto.ok(null);    }

    @DeleteMapping("/{expertId}")
    @Operation(summary = "입원 기록 삭제", description = "특정 입원 기록 삭제")
    public ResponseDto<?> deleteMedicalAppointment(@UserId Long id, @PathVariable Long expertId) {
        return ResponseDto.ok(null);    }
}
