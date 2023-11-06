package com.viewpharm.yakal.survey.controller;

import com.viewpharm.yakal.base.dto.ResponseDto;
import com.viewpharm.yakal.base.annotation.UserId;
import com.viewpharm.yakal.survey.dto.request.AnswerRequestDto;
import com.viewpharm.yakal.survey.service.SurveyService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/surveys")
@Tag(name = "Survey", description = "설문조사")
public class SurveyController {
    private final SurveyService surveyService;

    @PostMapping("/{surveyId}/answer")
    @Operation(summary = "설문 작성", description = "설문 작성")
    public ResponseDto<?> createAnswer(@UserId Long id, @PathVariable Long surveyId, @RequestBody @Valid AnswerRequestDto requestDto) {
        return ResponseDto.ok(surveyService.createAnswer(id, surveyId, requestDto));
    }

    @GetMapping("/answer")
    @Operation(summary = "설문 목록 가져오기", description = "설문 목록 가져오기")
    public ResponseDto<?> readAnswer(@UserId Long userId) {
        return ResponseDto.ok(surveyService.readAnswers(userId));
    }

    @DeleteMapping("/{surveyId}/answer")
    @Operation(summary = "설문 삭제", description = "특정 설문 삭제")
    public ResponseDto<?> deleteAnswer(@UserId Long id, @PathVariable Long surveyId) {
        return ResponseDto.ok(surveyService.deleteAnswer(id, surveyId));
    }








}
