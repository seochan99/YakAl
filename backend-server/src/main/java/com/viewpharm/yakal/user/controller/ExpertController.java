package com.viewpharm.yakal.user.controller;

import com.viewpharm.yakal.base.ResponseDto;
import com.viewpharm.yakal.common.annotation.UserId;
import com.viewpharm.yakal.dto.response.*;
import com.viewpharm.yakal.guardian.service.GuardianService;
import com.viewpharm.yakal.medicalappointment.service.MedicalAppointmentService;
import com.viewpharm.yakal.service.*;
import com.viewpharm.yakal.base.type.EPeriod;
import com.viewpharm.yakal.survey.service.SurveyService;
import com.viewpharm.yakal.user.dto.response.UserExpertDto;
import com.viewpharm.yakal.user.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/experts")
@Tag(name = "Expert", description = "전문가 웹 관련 API 제공")
public class ExpertController {
    private final UserService userService;
    private final DoseService doseService;
    private final SurveyService surveyService;
    private final MedicalAppointmentService medicalAppointmentService;
    private final GuardianService guardianService;


    @GetMapping("")
    @Operation(summary = "전문가 정보 가져오기", description = "로그인한 전문가의 정보를 가져온다")
    public ResponseDto<UserExpertDto> getExpertInfo(@UserId Long userId) {
        return ResponseDto.ok(userService.getUserExpertInfo(userId));
    }

    // 권한에 관한 부분 추가 해야 함 (만료기한)
    @GetMapping("/patient/{userId}/dose")
    @Operation(summary = "약정보 가져오기", description = "환자의 Id로 처방받은 약을 가져온다")
    public ResponseDto<PrescribedDto> getPrescrbiedDoses(@PathVariable Long userId
            , @RequestParam("page") Integer page, @RequestParam("num") Integer num, @RequestParam("period") EPeriod ePeriod) {
        return ResponseDto.ok(doseService.getPrescribedDoses(userId, page, num, ePeriod));
    }

    @GetMapping("/patient/{patientId}/surbey")
    @Operation(summary = "설문 리스트", description = "전문가가 특정 환자 설문 리스트 들고오기")
    public ResponseDto<?> getAllAnswerListForExpert(@UserId Long id, @PathVariable Long patientId) {
        return ResponseDto.ok(surveyService.getAllAnswerListForExpert(id, patientId));
    }

    @GetMapping("/patient")
    @Operation(summary = "환자 리스트", description = "환자 리스트 가져오기")
    public ResponseDto<PatientAllDto> getPatientList(@UserId Long id, @RequestParam("sort") String sort, @RequestParam("order") String order, @RequestParam("page") Long page, @RequestParam(name = "num", defaultValue = "10") Long num) {
        return ResponseDto.ok(medicalAppointmentService.getPatientList(id, sort, order, page, num));
    }

    @GetMapping("/patient/name")
    @Operation(summary = "환자 리스트", description = "환자 이름으로 리스트 가져오기")
    public ResponseDto<PatientAllDto> getPatientList(@UserId Long id, @RequestParam("name") String name, @RequestParam("sort") String sort, @RequestParam("order") String order, @RequestParam("page") Long page, @RequestParam(name = "num", defaultValue = "10") Long num) {
        return ResponseDto.ok(medicalAppointmentService.getPatientListByName(id, name, sort, order, page, num));
    }

    @Deprecated
    @GetMapping("/guardian/{guardianId}")
    @Operation(summary = "보호중인 환자 찾기", description = "해당 유저가 보호하고 있는 유저 찾기")
    public ResponseDto<PatientDto> readPatient(@PathVariable Long guardianId) {
        return ResponseDto.ok(guardianService.readPatient(guardianId));
    }

    @Deprecated
    @GetMapping("/patient/{patientId}")
    @Operation(summary = "보호자 찾기", description = "해당 유저의 보호자 찾기")
    public ResponseDto<PatientDto> readGuardian(@PathVariable Long patientId) {
        return ResponseDto.ok(guardianService.readGuardian(patientId));
    }

    @PatchMapping("/medical-appointment/{patientId}")
    @Operation(summary = "관심환자 여부 변경", description = "관심환자 여부 변경")
    public ResponseDto<Boolean> updateIsFavorite(@UserId Long expertId, @PathVariable Long patientId) {
        return ResponseDto.ok(medicalAppointmentService.updateIsFavorite(expertId, patientId));
    }
}
