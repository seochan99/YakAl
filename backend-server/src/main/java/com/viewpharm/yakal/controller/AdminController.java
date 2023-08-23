package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.service.MedicalService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/admin")
@Tag(name = "Admin", description = "관리자 전용 페이지 관련 API 제공")
public class AdminController {

    private final MedicalService medicalService;

    @GetMapping("/medical")
    @Operation(summary = "의료기관 업데이트", description = "의료기관 엑셀파일을 입력으로 의료기관의 정보를 업데이트 합니다. (공공데이터 포털 3개월마다 업데이트)")
    public ResponseDto<Boolean> updateMedical() throws IOException {
        return ResponseDto.ok(medicalService.updateMedical());
    }

}
