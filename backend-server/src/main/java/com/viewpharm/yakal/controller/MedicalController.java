package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.dto.request.MedicalRequestDto;
import com.viewpharm.yakal.dto.response.MedicalDto;
import com.viewpharm.yakal.dto.response.MedicalRegisterDto;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.service.MedicalService;
import com.viewpharm.yakal.service.RegistrationService;
import com.viewpharm.yakal.utils.GeometryUtil;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.locationtech.jts.geom.Point;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/medical")
@Tag(name = "Medical", description = "의료기관 API 제공")
@Slf4j
public class MedicalController {
    private final MedicalService medicalService;
    private final GeometryUtil geometryUtil;

    private final RegistrationService registrationService;

    @GetMapping("/point")
    @Operation(summary = "의료기관 추출", description = "내 좌표를 기준으로 가장 가까운 10개의 의료기관을 뽑는다.")
    public ResponseDto<List<MedicalDto>> findNearestMedicalsByPoint(@RequestBody MedicalRequestDto medicalRequestDto) {
        Point point = geometryUtil.getLatLng2Point(medicalRequestDto.getLocation().getLatitude(),medicalRequestDto.getLocation().getLongitude());
        return ResponseDto.ok(medicalService.findNearestMedicalsByPoint(point));
    }

    @GetMapping("/point/{medicalValue}")
    @Operation(summary = "의료기관 추출", description = "내 좌표를 기준으로 가장 가까운 10개의 병원 혹은 약국을 뽑는다.")
    public ResponseDto<List<MedicalDto>> findNearbyMedicalsByDistance(@RequestBody MedicalRequestDto medicalRequestDto, @PathVariable String medicalValue) {
        Point point = geometryUtil.getLatLng2Point(medicalRequestDto.getLocation().getLatitude(),medicalRequestDto.getLocation().getLongitude());
        return ResponseDto.ok(medicalService.findNearestMedicalsByPointAndEMedical(point,medicalValue));
    }

    @GetMapping("/distance")
    @Operation(summary = "의료기관 추출", description = "일정 거리 안에 있는 의료기관을 뽑는다.")
    public ResponseDto<List<MedicalDto>> findNearbyMedicalsByDistanceAndEMedical(@RequestBody MedicalRequestDto medicalRequestDto) {
        Point point = geometryUtil.getLatLng2Point(medicalRequestDto.getLocation().getLatitude(),medicalRequestDto.getLocation().getLongitude());
        return ResponseDto.ok(medicalService.findNearbyMedicalsByDistance(point,medicalRequestDto.getDistance()));
    }

    @GetMapping("/distance/{medicalValue}")
    @Operation(summary = "의료기관 추출", description = "일정 거리 안에 있는 병원 혹은 약국을 뽑는다.")
    public ResponseDto<List<MedicalDto>> findNearestMedicalsByPointAndEMedical(@RequestBody MedicalRequestDto medicalRequestDto, @PathVariable String medicalValue) {
        Point point = geometryUtil.getLatLng2Point(medicalRequestDto.getLocation().getLatitude(),medicalRequestDto.getLocation().getLongitude());
        return ResponseDto.ok(medicalService.findNearbyMedicalsByDistanceAndEMedical(point,medicalRequestDto.getDistance(),medicalValue));
    }

    @PostMapping("/register")
    public ResponseDto<Long> createRegister(@RequestBody @Valid MedicalRegisterDto medicalRegisterDto){
        return ResponseDto.ok(registrationService.createRegistration(medicalRegisterDto));
    }

}
