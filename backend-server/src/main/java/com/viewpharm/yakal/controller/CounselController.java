package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.annotation.UserId;
import com.viewpharm.yakal.dto.request.BoardRequestDto;
import com.viewpharm.yakal.dto.request.CommentForUpdateRequestDto;
import com.viewpharm.yakal.dto.request.NoteRequestDto;
import com.viewpharm.yakal.dto.response.*;
import com.viewpharm.yakal.service.CounselService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/counsel")
@Tag(name = "Counsel", description = "상담")
public class CounselController {
    private final CounselService counselService;

    @PostMapping("/{patientId}")
    @Operation(summary = "상담 추가", description = "상담 추가")
    public ResponseDto<Boolean> createBoard(@UserId Long id, @PathVariable Long patientId) {
        return ResponseDto.ok(counselService.createCounsel(id, patientId));
    }

    @DeleteMapping("/{counselId}")
    @Operation(summary = "상담 삭제", description = "상담 삭제")
    public ResponseDto<Boolean> deleteBoard(@UserId Long id, @PathVariable Long counselId) {
        return ResponseDto.ok(counselService.deleteCounsel(id, counselId));
    }
}
