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
    private final RegistrationService registrationService;

    @PostMapping("/register")
    public ResponseDto<Long> createRegister(@RequestBody @Valid MedicalRegisterDto medicalRegisterDto){
        return ResponseDto.ok(registrationService.createRegistration(medicalRegisterDto));
    }

}
