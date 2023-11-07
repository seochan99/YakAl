package com.viewpharm.yakal.medicalappointment.controller;

import com.viewpharm.yakal.base.annotation.UserId;
import com.viewpharm.yakal.base.dto.ResponseDto;
import com.viewpharm.yakal.medicalappointment.service.MedicalAppointmentService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/medical-appointments")
@Tag(name = "진료(복용 정보 공유)", description = "진료(복용 정보 공유) Create, Read, Delete")
public class MedicalAppointmentController {
    private final MedicalAppointmentService medicalAppointmentService;

    @PostMapping("/{expertUserId}")
    @Operation(summary = "진료(복용 정보 공유) 작성", description = "진료(복용 정보 공유) 작성")
    public ResponseDto<?> createMedicalAppointment(@UserId Long id, @PathVariable Long expertUserId) {
        return ResponseDto.ok(medicalAppointmentService.createMedicalAppointment(id, expertUserId));
    }

    @GetMapping("")
    @Operation(summary = "진료(복용 정보 공유) 리스트", description = "자신이 작성한 진료(복용 정보 공유) 목록 읽기")
    public ResponseDto<?> readMedicalAppointments(@UserId Long userId) {
        return ResponseDto.ok(medicalAppointmentService.readMedicalAppointments(userId));
    }

    @DeleteMapping("/{expertUserId}")
    @Operation(summary = "진료(복용 정보 공유) 삭제", description = "특정 진료(복용 정보 공유) 삭제")
    public ResponseDto<?> deleteMedicalAppointment(@UserId Long userId, @PathVariable Long expertUserId) {
        return ResponseDto.ok(medicalAppointmentService.deleteMedicalAppointment(userId, expertUserId));
    }
}
