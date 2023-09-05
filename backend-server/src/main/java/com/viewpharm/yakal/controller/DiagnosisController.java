package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.annotation.UserId;
import com.viewpharm.yakal.dto.request.DiagnosisRequestDto;
import com.viewpharm.yakal.dto.response.DiagnosisListDto;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.service.DiagnosisService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/diagnosis")
@Tag(name = "Diagnosis", description = "과거 병명")
public class DiagnosisController {
    private final DiagnosisService diagnosisService;

    @PostMapping("")
    @Operation(summary = "과거 병명 작성", description = "과거 병명 작성")
    public ResponseDto<Boolean> createDiagnosis(@UserId Long id, @RequestBody @Valid DiagnosisRequestDto requestDto) {
        return ResponseDto.ok(diagnosisService.createDiagnosis(id, requestDto));
    }

    @PutMapping("/{diagnosisId}")
    @Operation(summary = "과거 병명 수정", description = "과거 특정 병명 수정")
    public ResponseDto<Boolean> updateDiagnosis(@UserId Long id, @PathVariable Long diagnosisId, @RequestBody @Valid DiagnosisRequestDto requestDto) {
        return ResponseDto.ok(diagnosisService.updateDiagnosis(id, diagnosisId, requestDto));
    }

    @DeleteMapping("/{diagnosisId}")
    @Operation(summary = "과거 병명 삭제", description = "특정 과거 병명 삭제")
    public ResponseDto<Boolean> deleteDiagnosis(@UserId Long id, @PathVariable Long diagnosisId) {
        return ResponseDto.ok(diagnosisService.deleteDiagnosis(id, diagnosisId));
    }

    @GetMapping("/my")
    @Operation(summary = "병명 리스트", description = "자신이 작성한 과거 병명 리스트 들고오기")
    public ResponseDto<List<DiagnosisListDto>> getAllDiagnosisList(@UserId Long id) {
        return ResponseDto.ok(diagnosisService.getDiagnosisList(id));
    }


}
