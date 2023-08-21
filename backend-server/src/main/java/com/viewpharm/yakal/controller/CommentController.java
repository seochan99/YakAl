package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.dto.request.CommentForUpdateRequestDto;
import com.viewpharm.yakal.dto.request.CommentRequestDto;
import com.viewpharm.yakal.dto.response.CommentListDto;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.service.CommentService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/course")
public class CommentController {

    CommentService commentService;

    @PostMapping("/{boardId}/comment")
    public ResponseDto<Boolean> createComment(Authentication authentication, @PathVariable Long boardId, @RequestBody CommentRequestDto commentRequestDto){
        return ResponseDto.ok(commentService.createComment(Long.valueOf(authentication.getName()), boardId, commentRequestDto));
    }

    // Comment Read
    @GetMapping("/{boardId}/comment")
    public ResponseDto<List<CommentListDto>> readComment(@PathVariable Long boardId , @RequestParam("page") Long page, @RequestParam("num") Long num) {
        return ResponseDto.ok(commentService.getCommentList(boardId, page, num));
    }

    // Comment Update
    @PutMapping("/{boardId}/comment/{commentId}")
    public ResponseDto<Boolean> updateComment(Authentication authentication, @PathVariable Long boardId,
                                              @PathVariable Long commentId, @RequestBody CommentForUpdateRequestDto commentForUpdateRequestDto) {
        return ResponseDto.ok(commentService.updateComment(Long.valueOf(authentication.getName()), boardId, commentId, commentForUpdateRequestDto));
    }

    // Comment Delete
    @DeleteMapping("/{boardId}/comment/{commentId}")
    public ResponseDto<Boolean> deleteComment(Authentication authentication, @PathVariable Long boardId, @PathVariable Long commentId) {
        return ResponseDto.ok(commentService.deleteComment(Long.valueOf(authentication.getName()), boardId, commentId));
    }
}
