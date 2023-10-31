package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.dto.response.MedicalRegisterDto;
import com.viewpharm.yakal.base.ResponseDto;
import com.viewpharm.yakal.service.RegistrationService;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

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
