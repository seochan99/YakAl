package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.annotation.UserId;
import com.viewpharm.yakal.dto.request.NoteRequestDto;
import com.viewpharm.yakal.dto.response.*;
import com.viewpharm.yakal.service.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/expert")
@Tag(name = "Expert", description = "전문가 웹 관련 API 제공")
public class ExpertController {

    private final UserService userService;
    private final DoseService doseService;
    private final SurbeyService surbeyService;
    private final HealthFoodService healthFoodService;
    private final CounselService counselService;
    private final DiagnosisService diagnosisService;

    @GetMapping("")
    @Operation(summary = "전문가 정보 가져오기", description = "로그인한 전문가의 정보를 가져온다")
    public ResponseDto<UserExpertDto> getExpertInfo(@UserId Long userId) {
        return ResponseDto.ok(userService.getUserExpertInfo(userId));
    }

    // 권한에 관한 부분 추가 해야 함 (만료기한)
    @GetMapping("/patient/{userId}/dose")
    @Operation(summary = "약정보 가져오기", description = "환자의 Id로 처방받은 약을 가져온다")
    public ResponseDto<List<PrescribedDto>> getPrescrbiedDoses(@PathVariable Long userId) {
        return ResponseDto.ok(doseService.getPrescribedDoses(userId));
    }

    @GetMapping("/patient/{patientId}/surbey")
    @Operation(summary = "설문 리스트", description = "전문가가 특정 환자 설문 리스트 들고오기")
    public ResponseDto<AnswerAllDto> getAllAnswerListForExpert(@UserId Long id, @PathVariable Long patientId) {
        return ResponseDto.ok(surbeyService.getAllAnswerListForExpert(id, patientId));
    }

    @GetMapping("/patient/{patientId}/healthfood")
    @Operation(summary = "건강 기능 식품 리스트", description = "전문가가 특정 환자 건강 기능 식품 리스트 들고오기")
    public ResponseDto<List<HealthFoodListDto>> getAllHealthFoodListForExpert(@UserId Long id, @PathVariable Long patientId) {
        return ResponseDto.ok(healthFoodService.getHealthFoodListForExpert(id, patientId));
    }

    @GetMapping("/patient")
    @Operation(summary = "환자 리스트", description = "환자 리스트 가져오기")
    public ResponseDto<PatientAllDto> getPatientList(@UserId Long id, @RequestParam("sort") String sort, @RequestParam("order") String order, @RequestParam("page") Long page, @RequestParam(name = "num", defaultValue = "10") Long num) {
        return ResponseDto.ok(counselService.getPatientList(id, sort, order, page, num));
    }

    @GetMapping("/patient/name")
    @Operation(summary = "환자 리스트", description = "환자 이름으로 리스트 가져오기")
    public ResponseDto<PatientAllDto> getPatientList(@UserId Long id, @RequestParam("name") String name, @RequestParam("sort") String sort, @RequestParam("order") String order, @RequestParam("page") Long page, @RequestParam(name = "num", defaultValue = "10") Long num) {
        return ResponseDto.ok(counselService.getPatientListByName(id, name, sort, order, page, num));
    }

    @PostMapping("/patient/{patientId}/note")
    @Operation(summary = "특이사항 추가", description = "특이사항 추가")
    public ResponseDto<Boolean> createNote(@UserId Long id, @PathVariable Long patientId, @Valid @RequestBody NoteRequestDto requestDto) {
        return ResponseDto.ok(counselService.createNote(id, patientId, requestDto));
    }

    @PutMapping("/note/{noteId}")
    @Operation(summary = "특이사항 수정", description = "특이사항 수정하기")
    public ResponseDto<NoteDetailDto> updateNote(@UserId Long id, @PathVariable Long noteId, @RequestBody NoteRequestDto requestDto) {
        return ResponseDto.ok(counselService.updateNote(id, noteId, requestDto));
    }

    @DeleteMapping("/note/{noteId}")
    @Operation(summary = "특이사항 삭제", description = "특이사항 삭제하기")
    public ResponseDto<Boolean> deleteNote(@UserId Long id, @PathVariable Long noteId) {
        return ResponseDto.ok(counselService.deleteNote(id, noteId));
    }

    @GetMapping("/patient/{patientId}/note")
    @Operation(summary = "특이사항 가져오기", description = "특정 상담 특이사항 가져오기")
    public ResponseDto<NoteAllDto> readNote(@UserId Long id, @PathVariable Long patientId, @RequestParam("page") Long page, @RequestParam(value = "num", defaultValue = "5") Long num) {
        return ResponseDto.ok(counselService.getAllNoteList(id, patientId, page, num));
    }

    @GetMapping("/patient/{patientId}/diagnosis")
    @Operation(summary = "병명 리스트", description = "전문가가 특정 환자 과거 병명 리스트 들고오기")
    public ResponseDto<List<DiagnosisListDto>> getAllDiagnosisListForExpert(@UserId Long id, @PathVariable Long patientId) {
        return ResponseDto.ok(diagnosisService.getDiagnosisListForExpert(id, patientId));
    }
}
