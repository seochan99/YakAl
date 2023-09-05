package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.annotation.UserId;
import com.viewpharm.yakal.dto.request.AnswerRequestDto;
import com.viewpharm.yakal.dto.response.*;
import com.viewpharm.yakal.service.SurbeyService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/survey")
@Tag(name = "Survey", description = "설문조사")
public class SurveyController {
    private final SurbeyService surbeyService;

    @PostMapping("/{surveyId}/answer")
    @Operation(summary = "설문 작성", description = "설문 작성")
    public ResponseDto<Boolean> createAnswer(@UserId Long id, @PathVariable Long surveyId, @RequestBody AnswerRequestDto requestDto) {
        return ResponseDto.ok(surbeyService.createAnswer(id, surveyId, requestDto));
    }

    @GetMapping("/{answerId}")
    @Operation(summary = "설문 가져오기", description = "설문 가져오기")
    public ResponseDto<AnswerDetailDto> readAnswer(@UserId Long id, @PathVariable Long answerId) {
        return ResponseDto.ok(surbeyService.readAnswer(id, answerId));
    }

    @DeleteMapping("/{answerId}")
    @Operation(summary = "설문 삭제", description = "특정 설문 삭제")
    public ResponseDto<Boolean> deleteAnswer(@UserId Long id, @PathVariable Long answerId) {
        return ResponseDto.ok(surbeyService.deleteAnswer(id, answerId));
    }

    @GetMapping("/answer/my")
    @Operation(summary = "설문 리스트", description = "자신이 작성한 설문 리스트 들고오기")
    public ResponseDto<AnswerAllDto> getAllAnswerList(@UserId Long id) {
        return ResponseDto.ok(surbeyService.getAllAnswerList(id));
    }






}
