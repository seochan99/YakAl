package com.viewpharm.yakal.user.controller;

import com.viewpharm.yakal.base.dto.ResponseDto;
import com.viewpharm.yakal.medicalestablishment.dto.request.ExpertCertificationForResisterDto;
import com.viewpharm.yakal.medicalestablishment.dto.request.MedicalEstablishmentForResisterDto;
import com.viewpharm.yakal.medicalestablishment.dto.response.ExpertCertificationAllDto;
import com.viewpharm.yakal.medicalestablishment.dto.response.MedicalEstablishmentAllDto;
import com.viewpharm.yakal.medicalestablishment.dto.response.MedicalEstablishmentDetailDto;
import com.viewpharm.yakal.medicalestablishment.service.ExpertCertificationService;
import com.viewpharm.yakal.medicalestablishment.service.MedicalEstablishmentService;
import com.viewpharm.yakal.prescription.service.DoseService;
import com.viewpharm.yakal.survey.service.SurveyService;
import com.viewpharm.yakal.user.dto.request.UpdateAdminRequestDto;
import com.viewpharm.yakal.user.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Nullable;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/admin")
@Tag(name = "Admin", description = "관리자 전용 페이지 관련 API 제공")
public class AdminController {
    private final UserService userService;
    private final ExpertCertificationService expertCertificationService;
    private final MedicalEstablishmentService medicalEstablishmentService;
    private final DoseService doseService;
    private final SurveyService surveyService;


    @GetMapping("/medical/update")
    @Operation(summary = "의료기관 업데이트", description = "의료기관 엑셀파일을 입력으로 의료기관의 정보를 업데이트 합니다. (공공데이터 포털 3개월마다 업데이트)")
    public ResponseDto<Boolean> updateMedical() throws IOException {
        return ResponseDto.ok(null);
    }

    @GetMapping("/medical/search")
    @Operation(summary = "의료기관 가져오기", description = "의료기관 이름으로 가져온다")
    public ResponseDto<?> getMedicalByName(@RequestParam String name) {
        return ResponseDto.ok(null);
    }

    @GetMapping("/medical/register/hospital")
    @Operation(summary = "병원 가져오기", description = "등록된 병원을 가져온다")
    public ResponseDto<?> getRegisterHospital(
            @RequestParam("page") Long page, @RequestParam("num") Long num, @RequestParam("name") @Nullable String name
    ) {
        return ResponseDto.ok(null);
    }

    @GetMapping("/medical/register/pharmacy")
    @Operation(summary = "약국 가져오기", description = "등록된 약국을 가져온다")
    public ResponseDto<?> getRegisterPharmacy(
            @RequestParam("page") Long page, @RequestParam("num") Long num, @RequestParam("name") @Nullable String name
    ) {
        return ResponseDto.ok(null);
    }

    @GetMapping("/medical/register/request")
    @Operation(summary = "의료기관 등록 신청", description = "관리자가 의료기관 등록 신청한 목록 가져온다")
    public ResponseDto<MedicalEstablishmentAllDto> getMedicalRegisterRequest(
            @RequestParam(value = "name") String name, @RequestParam("sort") String sort, @RequestParam("order") String order, @RequestParam("num") Long num
    ) {
        return ResponseDto.ok(medicalEstablishmentService.getMedicalEstablishments(name, sort, order, num));
    }

    @GetMapping("/expert/register/request")
    @Operation(summary = "전문가 등록 신청", description = "관리자가 전문가 등록 신청한 목록 가져온다")
    public ResponseDto<ExpertCertificationAllDto> getExpertCertification(@RequestParam("name") String name, @RequestParam("sort") String sort, @RequestParam("order") String order, @RequestParam("num") Long num) {
        return ResponseDto.ok(expertCertificationService.getExpertCertification(name, sort, order, num));
    }

    @PatchMapping("/medical/register/{id}")
    @Operation(summary = "의료기관 등록", description = "의료기관을 약알에 등록 혹은 반려")
    public ResponseDto<Boolean> registerMedical(@PathVariable Long id, @RequestBody @Valid UpdateAdminRequestDto updateAdminRequestDto) {
        return ResponseDto.ok(null);
    }

    @PatchMapping("/expert/register/{id}")
    @Operation(summary = "전문가 등록", description = "전문가로 약알에 등록 혹은 반려")
    public ResponseDto<Boolean> certifyExpert(@PathVariable Long id, @RequestBody @Valid UpdateAdminRequestDto updateAdminRequestDto) {
        userService.updateIsCertified(id, updateAdminRequestDto);
        return ResponseDto.ok(null);
    }

    @GetMapping("/medical/{medicalId}/register/request")
    @Operation(summary = "기관 신청 상세 정보", description = "기관 신청 상세 정보 조회")
    public ResponseDto<MedicalEstablishmentDetailDto> getMedicalEstablishmentDetail(@PathVariable("medicalId") Long medicalId) {
        return ResponseDto.ok(medicalEstablishmentService.getMedicalEstablishmentDetail(medicalId));
    }

    @PatchMapping("/medical/register")
    @Operation(summary = "기관 신청 승인/거부", description = "기관 신청 승인/거부")
    public ResponseDto<Boolean> approveMedicalEstablishment(@RequestBody MedicalEstablishmentForResisterDto requestDto) {
        return ResponseDto.ok(medicalEstablishmentService.approveMedicalEstablishment(requestDto));
    }

    @PatchMapping("/expert/register")
    @Operation(summary = "전문가 신청 승인/거부", description = "전문가 신청 승인/거부")
    public ResponseDto<?> approveMedicalEstablishment(@RequestBody ExpertCertificationForResisterDto requestDto) {
        expertCertificationService.approveExpertCertification(requestDto);
        return ResponseDto.ok(null);
    }

    @GetMapping("doses/between")
    @Operation(summary = "가장 많이 먹은 약 통계")
    public ResponseDto<List<?>> getMostDoses(@RequestParam LocalDate startDate,@RequestParam LocalDate endDate){
        return ResponseDto.ok(doseService.findDosesTop10(startDate,endDate));
    }

    @GetMapping("statistic/arms")
    @Operation(summary = "arms")
    public ResponseDto<List<Long>> getArmsRanges(){
        return ResponseDto.ok(surveyService.getSurveyRangesCnt());
    }
}
