package com.viewpharm.yakal.user.controller;

import com.viewpharm.yakal.base.dto.ResponseDto;
import com.viewpharm.yakal.desire.dto.response.DesireAllDto;
import com.viewpharm.yakal.desire.service.DesireService;
import com.viewpharm.yakal.medicalestablishment.dto.request.MedicalEstablishmentApproveDto;
import com.viewpharm.yakal.medicalestablishment.service.ExpertCertificationService;
import com.viewpharm.yakal.medicalestablishment.service.MedicalEstablishmentService;
import com.viewpharm.yakal.survey.repository.AnswerRepository;
import com.viewpharm.yakal.user.dto.request.ExpertCertificationApproveDto;
import com.viewpharm.yakal.prescription.service.DoseService;
import com.viewpharm.yakal.survey.service.SurveyService;
import com.viewpharm.yakal.user.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/admins")
@Tag(name = "Admin", description = "관리자 전용 페이지 관련 API 제공")
public class AdminController {
    private final UserService userService;
    private final ExpertCertificationService expertCertificationService;
    private final MedicalEstablishmentService medicalEstablishmentService;
    private final DoseService doseService;
    private final SurveyService surveyService;
    private final DesireService desireService;

    @GetMapping("/medical-establishments")
    @Operation(summary = "의료기관 신청 목록 조회", description = "관리자가 의료기관 신청 목록을 조회한다")
    public ResponseDto<?> readMedicalEstablishments(@RequestParam(value = "name", required = false) String name,
                                                    @RequestParam(value = "sort") String sort,
                                                    @RequestParam(value = "order") String order,
                                                    @RequestParam(value = "num") Long num
    ) {
        return ResponseDto.ok(medicalEstablishmentService.readProposalMedicalEstablishments(name, sort, order, num));
    }

    @GetMapping("/medical-establishments/{medicalEstablishmentId}")
    @Operation(summary = "의료기관 신청 상세 조회", description = "관리자가 의료기관 신청 상세 정보를 조회한다")
    public ResponseDto<?> readMedicalEstablishmentDetail(@PathVariable("medicalEstablishmentId") Long medicalEstablishmentId) {
        return ResponseDto.ok(medicalEstablishmentService.readMedicalEstablishmentDetail(medicalEstablishmentId));
    }

    @PatchMapping("/medical-establishments/{medicalEstablishmentId}")
    @Operation(summary = "의료기관 신청 승인/거부", description = "관리자가 의료기관 신청을 승인 혹은 거부한다")
    public ResponseDto<?> approveMedicalEstablishment(@PathVariable Long medicalEstablishmentId,
                                                      @RequestBody MedicalEstablishmentApproveDto approveDto) {
        return ResponseDto.ok(medicalEstablishmentService.approveMedicalEstablishment(medicalEstablishmentId, approveDto));
    }

    @GetMapping("/expert-certifications")
    @Operation(summary = "전문가 신청 목록 조회", description = "관리자가 전문가 신청 목록을 조회한다")
    public ResponseDto<?> readExpertCertifications(@RequestParam(value = "name", required = false) String name,
                                                   @RequestParam("sort") String sort,
                                                   @RequestParam("order") String order,
                                                   @RequestParam("num") Long num) {
        return ResponseDto.ok(expertCertificationService.readProposalExpertCertifications(name, sort, order, num));
    }

    @GetMapping("/expert-certifications/{expertCertificationId}")
    @Operation(summary = "전문가 신청 상세 조회", description = "관리자가 전문가 신청 상세 정보를 조회한다")
    public ResponseDto<?> readExpertCertificationDetail(@PathVariable("expertCertificationId") Long expertCertificationId) {
        return ResponseDto.ok(expertCertificationService.readExpertCertificationDetail(expertCertificationId));
    }

    @PatchMapping("/expert-certifications/{expertCertificationId}")
    @Operation(summary = "전문가 신청 승인/거부", description = "관리자가 전문가 신청을 승인 혹은 거부한다")
    public ResponseDto<?> approveExpertCertification(@PathVariable Long expertCertificationId,
                                                     @RequestBody @Valid ExpertCertificationApproveDto approveDto) {
        return ResponseDto.ok(expertCertificationService.updateExpertCertification(expertCertificationId, approveDto));
    }

    @GetMapping("doses/between")
    @Operation(summary = "가장 많이 먹은 약 통계")
    public ResponseDto<List<?>> getMostDoses(@RequestParam LocalDate startDate, @RequestParam LocalDate endDate) {
        return ResponseDto.ok(doseService.findDosesTop10(startDate, endDate));
    }

    @GetMapping("statistic/arms")
    @Operation(summary = "arms")
    public ResponseDto<List<AnswerRepository.RangeInfo>> getArmsRanges() {
        return ResponseDto.ok(surveyService.getSurveyRangesCnt());
    }

    @GetMapping("/desires")
    @Operation(summary = "약알에게 바라는점 목록 가져오기")
    public ResponseDto<DesireAllDto> getDesireList(@RequestParam("order") String order, @RequestParam("num") Long num) {
        return ResponseDto.ok(desireService.getDesireList(order, num));
    }

}
