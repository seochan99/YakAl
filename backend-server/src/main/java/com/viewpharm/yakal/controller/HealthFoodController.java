package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.annotation.UserId;
import com.viewpharm.yakal.dto.request.DiagnosisRequestDto;
import com.viewpharm.yakal.dto.request.HealthFoodRequestDto;
import com.viewpharm.yakal.dto.response.DiagnosisListDto;
import com.viewpharm.yakal.dto.response.HealthFoodListDto;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.service.HealthFoodService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/healthfood")
@Tag(name = "Healthfood", description = "건강 기능 식품")
public class HealthFoodController {
    private final HealthFoodService healthFoodService;

    @PostMapping("")
    @Operation(summary = "건강 기능 식품 작성", description = "건강 기능 식품 작성")
    public ResponseDto<Boolean> createHealthFood(@UserId Long id, @RequestBody HealthFoodRequestDto requestDto) {
        return ResponseDto.ok(healthFoodService.createHealthFood(id, requestDto));
    }

    @PutMapping("/{diagnosisId}")
    @Operation(summary = "건강 기능 식품 수정", description = "건강 기능 식품 수정")
    public ResponseDto<Boolean> updateHealthFood(@UserId Long id, @PathVariable Long diagnosisId, @RequestBody HealthFoodRequestDto requestDto) {
        return ResponseDto.ok(healthFoodService.updateHealthFood(id, diagnosisId, requestDto));
    }

    @DeleteMapping("/{diagnosisId}")
    @Operation(summary = "건강 기능 식품 삭제", description = "건강 기능 식품 삭제")
    public ResponseDto<Boolean> deleteHealthFood(@UserId Long id, @PathVariable Long diagnosisId) {
        return ResponseDto.ok(healthFoodService.deleteHealthFood(id, diagnosisId));
    }

    @GetMapping("/my")
    @Operation(summary = "건강 기능 식품 리스트", description = "자신이 작성한 건강 기능 식품 리스트 들고오기")
    public ResponseDto<List<HealthFoodListDto>> getAllHealthFoodList(@UserId Long id) {
        return ResponseDto.ok(healthFoodService.getHealthFoodList(id));
    }

    @GetMapping("/expert/{patientId}")
    @Operation(summary = "건강 기능 식품 리스트", description = "전문가가 특정 환자 건강 기능 식품 리스트 들고오기")
    public ResponseDto<List<HealthFoodListDto>> getAllHealthFoodListForExpert(@UserId Long id, @PathVariable Long patientId) {
        return ResponseDto.ok(healthFoodService.getHealthFoodListForExpert(id, patientId));
    }
}