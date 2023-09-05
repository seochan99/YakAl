package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.annotation.UserId;
import com.viewpharm.yakal.dto.response.PrescribedDto;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.dto.response.UserExpertDto;
import com.viewpharm.yakal.service.DoseService;
import com.viewpharm.yakal.service.UserService;
import com.viewpharm.yakal.type.EPeriod;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/expert")
@Tag(name = "Expert", description = "전문가 웹 관련 API 제공")
public class ExpertController {

    private final UserService userService;
    private final DoseService doseService;
    @GetMapping("")
    @Operation(summary = "전문가 정보 가져오기", description = "로그인한 전문가의 정보를 가져온다")
    public ResponseDto<UserExpertDto> getExpertInfo(@UserId Long userId) {
        return ResponseDto.ok(userService.getUserExpertInfo(userId));
    }

    // 권한에 관한 부분 추가 해야 함 (만료기한)
    @GetMapping("/patient/{userId}/dose")
    @Operation(summary = "약정보 가져오기", description = "환자의 Id로 처방받은 약을 가져온다")
    public ResponseDto<List<PrescribedDto>> getPrescrbiedDoses(@PathVariable Long userId
            , @RequestParam("page") Long page, @RequestParam("num") Long num, @RequestParam EPeriod ePeriod){
        return ResponseDto.ok(doseService.getPrescribedDoses(userId,page,num,ePeriod));
    }
}
