package com.viewpharm.yakal.desire.controller;

import com.viewpharm.yakal.base.annotation.UserId;
import com.viewpharm.yakal.base.dto.ResponseDto;
import com.viewpharm.yakal.desire.dto.request.DesireRequestDto;
import com.viewpharm.yakal.desire.service.DesireService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/desires")
@Tag(name = "Desire", description = "약알에게 바라는점")
@Slf4j
public class DesireController {
    private final DesireService desireService;

    @PostMapping("")
    @Operation(summary = "전문가 정보 가져오기", description = "로그인한 전문가의 정보를 가져온다")
    public ResponseDto<Boolean> createDesire(@UserId Long id, @RequestBody @Valid DesireRequestDto requestDto) {
        return ResponseDto.ok(desireService.createDesire(id, requestDto));
    }
}
