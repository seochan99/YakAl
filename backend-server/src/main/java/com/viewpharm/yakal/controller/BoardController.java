package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.annotation.UserId;
import com.viewpharm.yakal.dto.request.BoardRequestDto;
import com.viewpharm.yakal.dto.response.BoardDetailDto;
import com.viewpharm.yakal.dto.response.BoardListDto;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.service.BoardService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/board")
@Tag(name = "Board", description = "게시글 작성, 삭제, 조회, 수정")
public class BoardController {
    private final BoardService boardService;

    //Create
    @PostMapping("")
    @Operation(summary = "게시글 작성", description = "게시글 작성")
    public ResponseDto<Boolean> createBoard(@UserId Long id, @RequestBody @Valid BoardRequestDto requestDto) {
        return ResponseDto.ok(boardService.createBoard(id, requestDto));
    }

    //Read
    @GetMapping("/{boardId}")
    @Operation(summary = "게시글 읽기", description = "특정 게시글 읽기")
    public ResponseDto<BoardDetailDto> readBoard(@UserId Long id, @PathVariable Long boardId) {
        return ResponseDto.ok(boardService.readBoard(id, boardId));
    }

    //Update
    @PutMapping("/{boardId}")
    @Operation(summary = "게시글 수정", description = "특정 게시글 제목, 내용, 지역 수정")
    public ResponseDto<BoardDetailDto> updateBoard(@UserId Long id, @PathVariable Long boardId, @RequestBody BoardRequestDto requestDto) {
        return ResponseDto.ok(boardService.updateBoard(id, boardId, requestDto));
    }

    //Delete
    @DeleteMapping("{boardId}")
    @Operation(summary = "게시글 삭제", description = "특정 게시글 삭제")
    public ResponseDto<Boolean> deleteBoard(@UserId Long id, @PathVariable Long boardId) {
        return ResponseDto.ok(boardService.deleteBoard(id, boardId));
    }

    //List
    @GetMapping("/list/all")
    @Operation(summary = "게시글 리스트", description = "모든 게시글 들고오기")
    public ResponseDto<List<BoardListDto>> getAllBoardList(@UserId Long id, @RequestParam("sort") String sort, @RequestParam("page") Long page, @RequestParam("num") Long num) {
        log.info(sort);
        log.info(page.toString());
        log.info(num.toString());
        return ResponseDto.ok(boardService.getAllBoardList(id, sort, page, num));
    }

    @GetMapping("/list/title")
    @Operation(summary = "게시글 리스트", description = "제목을 포함하는 게시글 들고오기")
    public ResponseDto<List<BoardListDto>> getBoardListByTitle(@UserId Long id, @RequestParam("title") String title, @RequestParam("sort") String sort, @RequestParam("page") Long page, @RequestParam("num") Long num) {
        return ResponseDto.ok(boardService.getBoardListByTitle(id, title, sort, page, num));
    }

    @GetMapping("/list/region")
    @Operation(summary = "게시글 리스트", description = "지역기반 게시글 들고오기")
    public ResponseDto<List<BoardListDto>> getBoardListByRegion(@UserId Long id, @RequestParam("region") String region, @RequestParam("sort") String sort, @RequestParam("page") Long page, @RequestParam("num") Long num) {
        return ResponseDto.ok(boardService.getBoardListByRegion(id, region, sort, page, num));
    }

    @GetMapping("/list/user")
    @Operation(summary = "게시글 리스트", description = "유저가 작성한 게시글 들고오기")
    public ResponseDto<List<BoardListDto>> getBoardListByUser(@UserId Long id, @RequestParam("userId") Long userId, @RequestParam("sort") String sort, @RequestParam("page") Long page, @RequestParam("num") Long num) {
        return ResponseDto.ok(boardService.getBoardListByUser(id, userId, sort, page, num));
    }

    //Like
    @PostMapping("/{boardId}/like")
    @Operation(summary = "게시글 좋아요", description = "게시글 좋아요")
    public ResponseDto<Map<String, Object>> likeBoard(@UserId Long id, @PathVariable Long boardId) {
        return ResponseDto.ok(boardService.likeBoard(id, boardId));
    }

    @DeleteMapping("/{boardId}/like")
    @Operation(summary = "게시글 좋아요 취소", description = "특정 좋아요 취소")
    public ResponseDto<Map<String, Object>> dislikeBoard(@UserId Long id, @PathVariable Long boardId) {
        return ResponseDto.ok(boardService.dislikeBoard(id, boardId));
    }

}
