package com.viewpharm.yakal.user.controller;

import com.viewpharm.yakal.base.dto.ResponseDto;
import com.viewpharm.yakal.base.type.EMedical;
import com.viewpharm.yakal.base.annotation.UserId;
import com.viewpharm.yakal.guardian.service.GuardianService;
import com.viewpharm.yakal.medicalappointment.dto.PatientBaseInfoDto;
import com.viewpharm.yakal.medicalappointment.service.MedicalAppointmentService;
import com.viewpharm.yakal.medicalestablishment.dto.request.ExpertCertificationDto;
import com.viewpharm.yakal.medicalestablishment.dto.request.MedicalEstablishmentDto;
import com.viewpharm.yakal.medicalestablishment.service.ExpertCertificationService;
import com.viewpharm.yakal.medicalestablishment.service.MedicalEstablishmentService;
import com.viewpharm.yakal.prescription.dto.response.DoseAllDto;
import com.viewpharm.yakal.prescription.dto.response.DoseAllWithRiskDto;
import com.viewpharm.yakal.prescription.dto.response.PrescribedDto;
import com.viewpharm.yakal.prescription.service.DoseService;
import com.viewpharm.yakal.base.type.EPeriod;
import com.viewpharm.yakal.survey.service.SurveyService;
import com.viewpharm.yakal.prescription.dto.response.DoseRecentDto;
import com.viewpharm.yakal.user.dto.response.PatientAllDto;
import com.viewpharm.yakal.user.dto.response.UserExpertDto;
import com.viewpharm.yakal.user.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/experts")
@Tag(name = "Expert", description = "전문가 웹 관련 API 제공")
@Slf4j
public class ExpertController {
    private final UserService userService;
    private final DoseService doseService;
    private final SurveyService surveyService;
    private final GuardianService guardianService;
    private final MedicalAppointmentService medicalAppointmentService;

    private final MedicalEstablishmentService medicalEstablishmentService;
    private final ExpertCertificationService expertCertificationService;


    @GetMapping("")
    @Operation(summary = "전문가 정보 가져오기", description = "로그인한 전문가의 정보를 가져온다")
    public ResponseDto<UserExpertDto> getExpertInfo(@UserId Long userId) {
        return ResponseDto.ok(userService.getUserExpertInfo(userId));
    }

    @PostMapping(value = "/medical-establishments", consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    @Operation(summary = "의료기관 등록", description = "의료기관 등록")
    public ResponseDto<?> createMedicalEstablishment(@RequestPart(value = "message") MedicalEstablishmentDto requestDto,
                                                     @RequestPart(value = "file") MultipartFile imgFile) {
        return ResponseDto.ok(medicalEstablishmentService.createMedicalEstablishment(requestDto, imgFile));
    }

    @GetMapping(value = "/medical-establishments/search")
    @Operation(summary = "의료기관 검색", description = "의료기관 검색")
    public ResponseDto<?> createMedicalEstablishment(@RequestParam(name = "medical") EMedical eMedical,
                                                     @RequestParam(value = "word", required = false) String word,
                                                     @RequestParam("page") Integer page) {
        return ResponseDto.ok(medicalEstablishmentService.readMedicalEstablishments(eMedical, word, page, 5));
    }

    @PostMapping(value = "/expert-certifications/expert", consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    @Operation(summary = "전문가 등록", description = "전문가 등록")
    public ResponseDto<?> createExpertCertification(@UserId Long userId,
                                                    @RequestPart(value = "message") ExpertCertificationDto requestDto,
                                                    @RequestPart(value = "certificate") MultipartFile imgFile,
                                                    @RequestPart(value = "affiliation") MultipartFile affiliationImgFile) {
        return ResponseDto.ok(expertCertificationService.createExpertCertification(userId, requestDto, imgFile, affiliationImgFile));
    }

    // 권한에 관한 부분 추가 해야 함 (만료기한)
    @GetMapping("/patient/{userId}/dose")
    @Operation(summary = "약정보 가져오기", description = "환자의 Id로 처방받은 약을 가져온다")
    public ResponseDto<PrescribedDto> getPrescrbiedDoses(@PathVariable Long userId
            , @RequestParam("page") Integer page, @RequestParam("num") Integer num, @RequestParam("period") EPeriod ePeriod) {
        return ResponseDto.ok(doseService.getPrescribedDoses(userId, page, num, ePeriod));
    }

    /**
     * 8번, 보호자 정보 가져 오기
     *
     * @param userId
     * @return ResponseDto<?>
     */
    @GetMapping("/patient/{userId}/guardian")
    @Operation(summary = "보호자 정보 가져오기", description = "환자의 Id로 보호자 정보를 가져온다")
    public ResponseDto<?> getGuardianInfo(@PathVariable Long userId) {
        return ResponseDto.ok(guardianService.readResentGuardian(userId));
    }

    @GetMapping("/patient/{patientId}/survey/senior")
    @Operation(summary = "설문 리스트", description = "전문가가 특정 환자 노인병 설문 리스트 들고오기")
    public ResponseDto<?> getAllAnswerListForExpert(@UserId Long id, @PathVariable Long patientId) {
        return ResponseDto.ok(surveyService.getAllSeniorAnswerListForExpert(id, patientId));
    }

    @GetMapping("/patient/{patientId}/survey/general")
    @Operation(summary = "설문 리스트", description = "전문가가 특정 환자 노인병 외 설문 리스트 들고오기")
    public ResponseDto<?> getAllNotSeniorAnswerListForExpert(@UserId Long id, @PathVariable Long patientId) {
        return ResponseDto.ok(surveyService.getAllNotSeniorAnswerListForExpert(id, patientId));
    }

    @GetMapping("/patient")
    @Operation(summary = "환자 리스트", description = "환자 리스트 가져오기")
    public ResponseDto<PatientAllDto> getPatientList(
            @UserId Long id,
            @RequestParam(name = "name", defaultValue = "") String name,
            @RequestParam("sort") String sort,
            @RequestParam("order") String order,
            @RequestParam("page") Long page,
            @RequestParam(name = "num", defaultValue = "10") Long num,
            @RequestParam(name = "favorite", defaultValue = "true") Boolean onlyFavorite
    ) {
        return ResponseDto.ok(
                medicalAppointmentService.getPatientList(id, URLDecoder.decode(name, StandardCharsets.UTF_8), sort, order, page, num, onlyFavorite)
        );
    }

//    @Deprecated
//    @GetMapping("/guardian/{guardianId}")
//    @Operation(summary = "보호중인 환자 찾기", description = "해당 유저가 보호하고 있는 유저 찾기")
//    public ResponseDto<PatientDto> readPatient(@PathVariable Long guardianId) {
//        return ResponseDto.ok(guardianService.readPatient(guardianId));
//    }
//
//    @Deprecated
//    @GetMapping("/patient/{patientId}")
//    @Operation(summary = "보호자 찾기", description = "해당 유저의 보호자 찾기")
//    public ResponseDto<PatientDto> readGuardian(@PathVariable Long patientId) {
//        return ResponseDto.ok(guardianService.readGuardian(patientId));
//    }

    @PatchMapping("/medical-appointment/{patientId}")
    @Operation(summary = "관심환자 여부 변경", description = "관심환자 여부 변경")
    public ResponseDto<?> updateIsFavorite(@UserId Long expertId, @PathVariable Long patientId) {
        medicalAppointmentService.updateIsFavorite(expertId, patientId);
        return ResponseDto.ok(null);
    }

    @GetMapping("/patient/{patientId}")
    @Operation(summary = "환자 기본 정보 조회", description = "환자의 기본 인적 사항을 조회")
    public ResponseDto<PatientBaseInfoDto> readPatientBase(@UserId Long userId, @PathVariable Long patientId) {
        return ResponseDto.ok(medicalAppointmentService.readPatientBaseInfo(userId, patientId));
    }

    @GetMapping("/patient/{patientId}/doses")
    @Operation(summary = "환자 최근 처방약 조회", description = "환자 최근 처방약 5개 조회")
    public ResponseDto<List<DoseRecentDto>> readRecentDoses(@UserId Long userId, @PathVariable Long patientId) {
        return ResponseDto.ok(doseService.readRecentDoses(userId, patientId));
    }

    @GetMapping("/patient/{patientId}/doses/all")
    @Operation(summary = "환자 처방약 조회", description = "환자 모든 처방약 조회")
    public ResponseDto<DoseAllDto> readAllDoses(@UserId Long userId, @PathVariable Long patientId, @RequestParam("page") Long page) {
        return ResponseDto.ok(doseService.readAllDoses(userId, patientId, page));
    }

    @GetMapping("/patient/{patientId}/doses/beers")
    @Operation(summary = "환자 처방약 조회", description = "환자 Beer Criteria 처방약 조회")
    public ResponseDto<DoseAllDto> readBeerCriteriaDoses(@UserId Long userId, @PathVariable Long patientId, @RequestParam("page") Long page) {
        return ResponseDto.ok(doseService.readBeerCriteriaDoses(userId, patientId, page));
    }

    @GetMapping("/patient/{patientId}/doses/anticholinergic")
    @Operation(summary = "환자 처방약 조회", description = "환자 항콜린성 처방약 조회")
    public ResponseDto<DoseAllWithRiskDto> readAnticholinergicDoses(@UserId Long userId, @PathVariable Long patientId, @RequestParam("page") Long page) {
        return ResponseDto.ok(doseService.readAnticholinergicDoses(userId, patientId, page));
    }



}
