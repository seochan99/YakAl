package com.viewpharm.yakal.notablefeatures.controller;

import com.viewpharm.yakal.annotation.Date;
import com.viewpharm.yakal.annotation.UserId;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.notablefeatures.dto.request.NotableFeatureRequestDto;
import com.viewpharm.yakal.notablefeatures.service.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/notable-feature")
@Tag(name = "NotableFeature", description = "특이사항")
public class NotableFeatureController {
    private final UnderlyingConditionService underlyingConditionService;
    private final MedicalHistoryService medicalHistoryService;
    private final DietarySupplementService dietarySupplementService;
    private final AllergyService allergyService;
    private final FallService fallService;

    /**
     * 기저 질환
     */
    @PostMapping("/underlying-conditions")
    @Operation(summary = "기저 질환 작성", description = "기저 질환 작성")
    public ResponseDto<?> createUnderlyingCondition(@UserId Long id, @RequestBody @Valid NotableFeatureRequestDto requestDto) {
        return ResponseDto.ok(underlyingConditionService.createUnderlyingCondition(id, requestDto));
    }

    @GetMapping("/underlying-conditions")
    @Operation(summary = "기저 질환 리스트", description = "자신이 작성한 기저 질환 목록 읽기")
    public ResponseDto<?> readUnderlyingConditions(@UserId Long id) {
        return ResponseDto.ok(underlyingConditionService.readUnderlyingConditions(id));
    }

    @DeleteMapping("/underlying-conditions/{underlyingConditionId}")
    @Operation(summary = "기저 질환 삭제", description = "특정 기저 질환 삭제")
    public ResponseDto<?> deleteUnderlyingCondition(@UserId Long id, @PathVariable Long underlyingConditionId) {
        return ResponseDto.ok(underlyingConditionService.deleteUnderlyingCondition(id, underlyingConditionId));
    }

    /**
     * 1년간 처방 받은 (진단)병
     */
    @PostMapping("/medical-histories")
    @Operation(summary = "과거 병명 작성", description = "과거 병명 작성")
    public ResponseDto<?> createMedicalHistories(@UserId Long id, @RequestBody @Valid NotableFeatureRequestDto requestDto) {
        return ResponseDto.ok(medicalHistoryService.createMedicalHistory(id, requestDto));
    }

    @GetMapping("/medical-histories")
    @Operation(summary = "과거 병명 리스트", description = "자신이 작성한 과거 병명 리스트 들고오기")
    public ResponseDto<?> readMedicalHistories(@UserId Long id) {
        return ResponseDto.ok(medicalHistoryService.readMedicalHistories(id));
    }

    @DeleteMapping("/medical-histories/{medicalHistoryId}")
    @Operation(summary = "과거 병명 삭제", description = "특정 과거 병명 삭제")
    public ResponseDto<Boolean> deleteMedicalHistory(@UserId Long id, @PathVariable Long medicalHistoryId) {
        return ResponseDto.ok(medicalHistoryService.deleteMedicalHistory(id, medicalHistoryId));
    }

    /**
     * 건강 기능 식품
     */
    @PostMapping("/dietary-supplements")
    @Operation(summary = "건강 기능 식품 Create", description = "건강 기능 식품 작성")
    public ResponseDto<?> createDietarySupplement(@UserId Long id, @RequestBody @Valid NotableFeatureRequestDto requestDto) {
        return ResponseDto.ok(dietarySupplementService.createDietarySupplement(id, requestDto));
    }

    @GetMapping("/dietary-supplements")
    @Operation(summary = "건강 기능 식품 Read", description = "자신이 작성한 건강 기능 식품 리스트 들고오기")
    public ResponseDto<?> readDietarySupplements(@UserId Long id) {
        return ResponseDto.ok(dietarySupplementService.readDietarySupplements(id));
    }

    @DeleteMapping("/dietary-supplements/{dietarySupplementsId}")
    @Operation(summary = "건강 기능 식품 Delete", description = "건강 기능 식품 삭제")
    public ResponseDto<?> deleteDietarySupplement(@UserId Long id, @PathVariable Long dietarySupplementsId) {
        return ResponseDto.ok(dietarySupplementService.deleteDietarySupplement(id, dietarySupplementsId));
    }

    /**
     * 알러지
     */
    @PostMapping("/allergies")
    @Operation(summary = "알러지 Create", description = "알러지 작성")
    public ResponseDto<?> createAllergy(@UserId Long id, @RequestBody @Valid NotableFeatureRequestDto requestDto) {
        return ResponseDto.ok(null);
    }

    @GetMapping("/allergies")
    @Operation(summary = "알러지 Read", description = "자신이 작성한 알러지 리스트 들고오기")
    public ResponseDto<?> readAllergies(@UserId Long id) {
        return ResponseDto.ok(null);    }

    @DeleteMapping("/allergies/{dietarySupplementsId}")
    @Operation(summary = "알러지 Delete", description = "알러지 삭제")
    public ResponseDto<?> deleteAllergy(@UserId Long id, @PathVariable Long dietarySupplementsId) {
        return ResponseDto.ok(null);    }

    /**
     * 낙상 사고
     */
    @PostMapping("/falls")
    @Operation(summary = "낙상 사고 Create", description = "낙상 사고 작성")
    public ResponseDto<?> createFall(@UserId Long id, @RequestBody @Date @Valid NotableFeatureRequestDto requestDto) {
        return ResponseDto.ok(null);    }

    @GetMapping("/falls")
    @Operation(summary = "낙상 사고 Read", description = "자신이 작성한 낙상 사고 리스트 들고오기")
    public ResponseDto<?> readFalls(@UserId Long id) {
        return ResponseDto.ok(null);    }

    @DeleteMapping("/falls/{fallId}")
    @Operation(summary = "낙상 사고 Delete", description = "낙상 사고 삭제")
    public ResponseDto<?> deleteFall(@UserId Long id, @PathVariable Long fallId) {
        return ResponseDto.ok(null);    }
}
