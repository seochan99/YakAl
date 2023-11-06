package com.viewpharm.yakal.medicalestablishment.controller;

import com.viewpharm.yakal.base.annotation.UserId;
import com.viewpharm.yakal.base.dto.ResponseDto;
import com.viewpharm.yakal.base.type.EMedical;
import com.viewpharm.yakal.medicalestablishment.dto.request.ExpertCertificationDto;
import com.viewpharm.yakal.medicalestablishment.dto.request.MedicalEstablishmentDto;
import com.viewpharm.yakal.medicalestablishment.service.ExpertCertificationService;
import com.viewpharm.yakal.medicalestablishment.service.MedicalEstablishmentService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/registrations")
public class RegistrationController {
    private final MedicalEstablishmentService medicalEstablishmentService;
    private final ExpertCertificationService expertCertificationService;

    @PostMapping(value = "/medical-establishments", consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    @Operation(summary = "의료기관 등록", description = "의료기관 등록")
    public ResponseDto<?> createMedicalEstablishment(@RequestPart(value = "message") MedicalEstablishmentDto requestDto,
                                                     @RequestPart(value = "file") MultipartFile imgFile) {
        return ResponseDto.ok(medicalEstablishmentService.createMedicalEstablishment(requestDto, imgFile));
    }

    @GetMapping(value = "/medical-establishments/search")
    @Operation(summary = "의료기관 검색", description = "의료기관 검색")
    public ResponseDto<?> readMedicalEstablishments(@RequestParam(name = "medical") EMedical eMedical,
                                                    @RequestParam(value = "word", required = false) String word,
                                                    @RequestParam("page") Integer page) {
        return ResponseDto.ok(medicalEstablishmentService.readMedicalEstablishments(eMedical, word, page, 5));
    }

    @PostMapping(value = "/expert-certifications", consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    @Operation(summary = "전문가 등록", description = "전문가 등록")
    public ResponseDto<?> createExpertCertification(@UserId Long userId,
                                                    @RequestPart(value = "message") ExpertCertificationDto requestDto,
                                                    @RequestPart(value = "certificate") MultipartFile imgFile,
                                                    @RequestPart(value = "affiliation") MultipartFile affiliationImgFile) {
        return ResponseDto.ok(expertCertificationService.createExpertCertification(userId, requestDto, imgFile, affiliationImgFile));
    }
}
