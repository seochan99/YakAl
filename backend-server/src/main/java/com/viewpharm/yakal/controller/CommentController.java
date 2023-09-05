package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.annotation.UserId;
import com.viewpharm.yakal.dto.request.CommentForUpdateRequestDto;
import com.viewpharm.yakal.dto.request.CommentRequestDto;
import com.viewpharm.yakal.dto.response.CommentListDto;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.service.CommentService;
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
@RequestMapping("/api/v1/board")
@Tag(name = "Comment", description = "댓글 작성, 삭제, 조회, 수정")
public class CommentController {

    private final CommentService commentService;

    @PostMapping("/{boardId}/comment")
    @Operation(summary = "댓글 작성", description = "댓글 작성하기")
    public ResponseDto<Boolean> createComment(@UserId Long id, @PathVariable Long boardId, @RequestBody @Valid CommentRequestDto commentRequestDto) {
        return ResponseDto.ok(commentService.createComment(id, boardId, commentRequestDto));
    }

    // Comment Read
    @GetMapping("/{boardId}/comment")
    @Operation(summary = "댓글 가져오기", description = "특정 게시물 댓글 가져오기")
    public ResponseDto<List<CommentListDto>> readComment(@PathVariable Long boardId, @RequestParam("page") Long page, @RequestParam("num") Long num) {
        return ResponseDto.ok(commentService.getCommentList(boardId, page, num));
    }

    // Comment Update
    @PutMapping("/{boardId}/comment/{commentId}")
    @Operation(summary = "댓글 수정", description = "댓글 수정하기")
    public ResponseDto<Boolean> updateComment(@UserId Long id, @PathVariable Long boardId,
                                              @PathVariable Long commentId, @RequestBody @Valid CommentForUpdateRequestDto commentForUpdateRequestDto) {
        return ResponseDto.ok(commentService.updateComment(id, boardId, commentId, commentForUpdateRequestDto));
    }

    // Comment Delete
    @DeleteMapping("/{boardId}/comment/{commentId}")
    @Operation(summary = "댓글 삭제", description = "댓글 삭제하기")
    public ResponseDto<Boolean> deleteComment(@UserId Long id, @PathVariable Long boardId, @PathVariable Long commentId) {
        return ResponseDto.ok(commentService.deleteComment(id, boardId, commentId));
    }
}
