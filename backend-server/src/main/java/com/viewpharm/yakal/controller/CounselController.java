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

    @PostMapping("")
    @Operation(summary = "상담 추가", description = "상담 추가")
    public ResponseDto<Boolean> createBoard(@UserId Long id, @RequestParam Long patientId) {
        return ResponseDto.ok(counselService.createCounsel(id, patientId));
    }

    @DeleteMapping("/{counselId}")
    @Operation(summary = "상담 삭제", description = "상담 삭제")
    public ResponseDto<Boolean> deleteBoard(@UserId Long id, @PathVariable Long counselId) {
        return ResponseDto.ok(counselService.deleteCounsel(id, counselId));
    }

    //List
    @GetMapping("/patient")
    @Operation(summary = "환자 리스트", description = "환자 리스트 가져오기")
    public ResponseDto<PatientAllDto> getPatientList(@UserId Long id, @RequestParam("page") Long page, @RequestParam("num") Long num) {
        return ResponseDto.ok(counselService.getPatientList(id, page, num));
    }

    @PostMapping("/{counselId}/note")
    @Operation(summary = "특이사항 추가", description = "특이사항 추가")
    public ResponseDto<Boolean> createNote(@UserId Long id, @PathVariable Long counselId, @RequestParam Long patientId, @RequestBody NoteRequestDto requestDto) {
        return ResponseDto.ok(counselService.createNote(id, patientId, counselId, requestDto));
    }

    @PutMapping("/{counselId}/note/{noteId}")
    @Operation(summary = "특이사항 수정", description = "특이사항 수정하기")
    public ResponseDto<NoteDetailDto> updateNote(@UserId Long id, @PathVariable Long counselId,
                                                 @PathVariable Long noteId, @RequestBody NoteRequestDto requestDto) {
        return ResponseDto.ok(counselService.updateNote(id, counselId, requestDto));
    }

    @DeleteMapping("/{counselId}/comment/{noteId}")
    @Operation(summary = "특이사항 삭제", description = "특이사항 삭제하기")
    public ResponseDto<Boolean> deleteNote(@UserId Long id, @PathVariable Long counselId, @PathVariable Long noteId) {
        return ResponseDto.ok(counselService.deleteNote(id, counselId, noteId));
    }

    @GetMapping("/{counselId}/note")
    @Operation(summary = "특이사항 가져오기", description = "특정 상담 특이사항 가져오기")
    public ResponseDto<NoteAllDto> readNote(@UserId Long id, @PathVariable Long counselId, @RequestParam("page") Long page, @RequestParam("num") Long num) {
        return ResponseDto.ok(counselService.getAllNoteList(id, counselId, page, num));
    }


}
