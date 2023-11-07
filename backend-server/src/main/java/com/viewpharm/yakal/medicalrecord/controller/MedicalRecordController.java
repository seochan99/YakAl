package com.viewpharm.yakal.medicalrecord.controller;

import com.viewpharm.yakal.base.annotation.UserId;
import com.viewpharm.yakal.base.dto.ResponseDto;
import com.viewpharm.yakal.medicalrecord.dto.reqeust.MedicalRecordDto;
import com.viewpharm.yakal.medicalrecord.service.EmergencyRecordService;
import com.viewpharm.yakal.medicalrecord.service.HospitalizationRecordService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/medical-records")
public class MedicalRecordController {
    private final HospitalizationRecordService hospitalizationRecordService;
    private final EmergencyRecordService emergencyRecordService;

    /**
     * 입원 기록
     */
    @PostMapping("/hospitalization-records")
    @Operation(summary = "입원 기록 작성", description = "입원 기록 작성")
    public ResponseDto<?> createHospitalizationRecord(@UserId Long id, @RequestBody @Valid MedicalRecordDto requestDto) {
        return ResponseDto.ok(hospitalizationRecordService.createHospitalizationRecord(id, requestDto));
    }

    @GetMapping("/hospitalization-records")
    @Operation(summary = "입원 기록 리스트", description = "자신이 작성한 입원 기록 목록 읽기")
    public ResponseDto<?> readHospitalizationRecords(@UserId Long id) {
        return ResponseDto.ok(hospitalizationRecordService.readHospitalizationRecords(id));
    }

    @DeleteMapping("/hospitalization-records/{hospitalizationRecordId}")
    @Operation(summary = "입원 기록 삭제", description = "특정 입원 기록 삭제")
    public ResponseDto<?> deleteHospitalizationRecord(@UserId Long id, @PathVariable Long hospitalizationRecordId) {
        return ResponseDto.ok(hospitalizationRecordService.deleteHospitalizationRecord(id, hospitalizationRecordId));
    }

    /**
     * 응급실 기록
     */
    @PostMapping("/emergency-records")
    @Operation(summary = "응급실 기록 작성", description = "응급실 기록 작성")
    public ResponseDto<?> createEmergencyRecord(@UserId Long id, @RequestBody @Valid MedicalRecordDto requestDto) {
        return ResponseDto.ok(emergencyRecordService.createEmergencyRecord(id, requestDto));
    }

    @GetMapping("/emergency-records")
    @Operation(summary = "응급실 기록 리스트", description = "자신이 작성한 응급실 기록 목록 읽기")
    public ResponseDto<?> readEmergencyRecords(@UserId Long id) {
        return ResponseDto.ok(emergencyRecordService.readEmergencyRecords(id));
    }

    @DeleteMapping("/emergency-records/{emergencyRecordId}")
    @Operation(summary = "응급실 기록 삭제", description = "특정 응급실 기록 삭제")
    public ResponseDto<?> deleteEmergencyRecord(@UserId Long id, @PathVariable Long emergencyRecordId) {
        return ResponseDto.ok(emergencyRecordService.deleteEmergencyRecord(id, emergencyRecordId));
    }
}
