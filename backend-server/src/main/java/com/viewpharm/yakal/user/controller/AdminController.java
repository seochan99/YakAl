package com.viewpharm.yakal.user.controller;

import com.viewpharm.yakal.base.dto.ResponseDto;
import com.viewpharm.yakal.medicalestablishment.dto.request.MedicalEstablishmentApproveDto;
import com.viewpharm.yakal.medicalestablishment.service.ExpertCertificationService;
import com.viewpharm.yakal.medicalestablishment.service.MedicalEstablishmentService;
import com.viewpharm.yakal.user.dto.request.ExpertCertificationApproveDto;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/admins")
@Tag(name = "Admin", description = "관리자 전용 페이지 관련 API 제공")
public class AdminController {
    private final ExpertCertificationService expertCertificationService;
    private final MedicalEstablishmentService medicalEstablishmentService;

    @GetMapping("/medical-establishments")
    @Operation(summary = "의료기관 신청 목록 조회", description = "관리자가 의료기관 신청 목록을 조회한다")
    public ResponseDto<?> readMedicalEstablishments(@RequestParam(value = "name") String name,
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
    public ResponseDto<?> readExpertCertifications(@RequestParam("name") String name,
                                                   @RequestParam("sort") String sort,
                                                   @RequestParam("order") String order,
                                                   @RequestParam("num") Long num) {
        return ResponseDto.ok(expertCertificationService.readProposalExpertCertifications(name, sort, order, num));
    }

    @GetMapping("/expert-certifications/{expertCertificationId}")
    @Operation(summary = "전문가 신청 상세 조회", description = "관리자가 전문가 신청 상세 정보를 조회한다")
    public ResponseDto<?> readExpertCertificationDetail(@RequestParam("expertCertificationId") Long expertCertificationId) {
        return ResponseDto.ok(expertCertificationService.readExpertCertificationDetail(expertCertificationId));
    }

    @PatchMapping("/expert-certifications/{expertCertificationId}")
    @Operation(summary = "전문가 신청 승인/거부", description = "관리자가 전문가 신청을 승인 혹은 거부한다")
    public ResponseDto<?> approveExpertCertification(@PathVariable Long expertCertificationId,
                                                     @RequestBody @Valid ExpertCertificationApproveDto approveDto) {
        return ResponseDto.ok(expertCertificationService.updateExpertCertification(expertCertificationId, approveDto));
    }
}
