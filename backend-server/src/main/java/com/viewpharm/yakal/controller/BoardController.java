package com.viewpharm.yakal.controller;

import com.viewpharm.yakal.dto.request.BoardRequestDto;
import com.viewpharm.yakal.dto.response.BoardDetailDto;
import com.viewpharm.yakal.dto.response.BoardListDto;
import com.viewpharm.yakal.dto.response.ResponseDto;
import com.viewpharm.yakal.service.BoardService;
import com.viewpharm.yakal.type.ERegion;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/board")
@Tag(name = "Board", description = "게시글 작성, 삭제, 조회, 수정")
public class BoardController {
    BoardService boardService;

    //Create
    @PostMapping("")
    @Operation(summary = "게시글 작성", description = "게시글 작성")
    public ResponseDto<Boolean> createBoard(Authentication authentication, BoardRequestDto requestDto) {
        return ResponseDto.ok(boardService.createBoard(Long.valueOf(authentication.getName()), requestDto));
    }

    //Read
    @GetMapping("/{boardId}")
    @Operation(summary = "게시글 읽기", description = "특정 게시글 읽기")
    public ResponseDto<BoardDetailDto> readBoard(Authentication authentication, @PathVariable Long boardId) {
        return ResponseDto.ok(boardService.readBoard(Long.valueOf(authentication.getName()), boardId));
    }

    //Update
    @PutMapping("/{boardId}")
    @Operation(summary = "게시글 수정", description = "특정 게시글 제목, 내용, 지역 수정")
    public ResponseDto<BoardDetailDto> updateBoard(Authentication authentication, @PathVariable Long boardId, BoardRequestDto requestDto) {
        return ResponseDto.ok(boardService.updateBoard(Long.valueOf(authentication.getName()), boardId, requestDto));
    }

    //Delete
    @DeleteMapping("{boardId}")
    @Operation(summary = "게시글 삭제", description = "특정 게시글 삭제")
    public ResponseDto<Boolean> deleteBoard(Authentication authentication, @PathVariable Long boardId) {
        return ResponseDto.ok(boardService.deleteBoard(Long.valueOf(authentication.getName()), boardId));
    }

    //List
    @GetMapping("/list/all")
    public ResponseDto<List<BoardListDto>> getAllBoardList(Authentication authentication, @RequestParam("page") Long page, @RequestParam("num") Long num) {
        return ResponseDto.ok(boardService.getAllBoardList(Long.valueOf(authentication.getName()), page, num));
    }

    @GetMapping("/list/title")
    public ResponseDto<List<BoardListDto>> getBoardListByTitle(Authentication authentication, @RequestParam("title") String title, @RequestParam("page") Long page, @RequestParam("num") Long num) {
        return ResponseDto.ok(boardService.getBoardListByTitle(Long.valueOf(authentication.getName()), title, page, num));
    }

    @GetMapping("/list/region")
    public ResponseDto<List<BoardListDto>> getBoardListByRegion(Authentication authentication, @RequestParam("region") String region, @RequestParam("page") Long page, @RequestParam("num") Long num) {
        return ResponseDto.ok(boardService.getBoardListByRegion(Long.valueOf(authentication.getName()), region, page, num));
    }

    @GetMapping("/list/user")
    public ResponseDto<List<BoardListDto>> getBoardListByUser(Authentication authentication, @RequestParam("userId") Long userId, @RequestParam("page") Long page, @RequestParam("num") Long num) {
        return ResponseDto.ok(boardService.getBoardListByUser(Long.valueOf(authentication.getName()), userId, page, num));
    }

    @PostMapping("/{boardId}/like")
    public ResponseDto<Map<String, Object>> likeBoard(Authentication authentication, @PathVariable Long boardId) {
        return ResponseDto.ok(boardService.likeBoard(Long.valueOf(authentication.getName()), boardId));
    }

    @DeleteMapping("/{boardId}/like")
    public ResponseDto<Map<String, Object>> dislikeBoard(Authentication authentication, @PathVariable Long boardId) {
        return ResponseDto.ok(boardService.dislikeBoard(Long.valueOf(authentication.getName()), boardId));
    }

}
