package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.annotation.UserId;
import com.viewpharm.yakal.domain.Medical;
import com.viewpharm.yakal.dto.response.MedicalDto;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.dto.response.UserExpertDto;
import com.viewpharm.yakal.service.MedicalService;
import com.viewpharm.yakal.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/admin")
@Tag(name = "Admin", description = "관리자 전용 페이지 관련 API 제공")
public class AdminController {

    private final MedicalService medicalService;
    private final UserService userService;

    @GetMapping("/medical/update")
    @Operation(summary = "의료기관 업데이트", description = "의료기관 엑셀파일을 입력으로 의료기관의 정보를 업데이트 합니다. (공공데이터 포털 3개월마다 업데이트)")
    public ResponseDto<Boolean> updateMedical() throws IOException {
        return ResponseDto.ok(medicalService.updateMedical());
    }

    @GetMapping("/expert")
    @Operation(summary = "전문가 정보 가져오기", description = "로그인한 전문가의 정보를 가져온다")
    public ResponseDto<UserExpertDto> getExpertInfo(@UserId Long userId) {
        return ResponseDto.ok(userService.getUserExpertInfo(userId));
    }

    @GetMapping("/medical/{name}")
    @Operation(summary = "의료기관 가져오기", description = "의료기관 이름으로 가져온다")
    public ResponseDto<List<Medical>> getMedical(@PathVariable String name) {
        return ResponseDto.ok(medicalService.getByName(name));
    }
    @GetMapping("/medical/register")
    @Operation(summary = "의료기관 가져오기", description = "등록된 의료기관을 가져온다")
    public ResponseDto<List<Medical>> getMedical() {
        return ResponseDto.ok(medicalService.getAllByRegister());
    }

    @PatchMapping("medical/register/{id}")
    @Operation(summary = "의료기관 등록", description = "의료기관을 약알에 등록 혹은 해제")
    public ResponseDto<Boolean> registerMedical(@PathVariable Long id){
        return ResponseDto.ok(medicalService.updateMedicalRegister(id));
    }

}
