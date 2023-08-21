package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.Board;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.dto.request.BoardRequestDto;
import com.viewpharm.yakal.dto.response.BoardDetailDto;
import com.viewpharm.yakal.dto.response.BoardListDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.BoardRepository;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.type.ERegion;
import com.viewpharm.yakal.utils.BoardUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class BoardService {
    BoardRepository boardRepository;
    UserRepository userRepository;
    BoardUtil boardUtil;

    public Boolean createBoard(Long userId, BoardRequestDto requestDto) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        boardRepository.findByTitleAndIsDeleted(requestDto.getTitle(), false)
                .ifPresent(b -> {
                    throw new CommonException(ErrorCode.DUPLICATION_TITLE);
                });

        boardRepository.save(Board.builder()
                .title(requestDto.getTitle())
                .content(requestDto.getContent())
                .user(user)
                .region(requestDto.getRegion())
                .build());
        return Boolean.TRUE;
    }

    public BoardDetailDto readBoard(Long userId, Long boardId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        Board board = boardRepository.findByIdAndIsDeleted(boardId, false)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_BOARD));

        board.addCnt();

        return BoardDetailDto.builder()
                .id(board.getId())
                .title(board.getTitle())
                .content(board.getContent())
                .userName(board.getUser().getName())
                .isEdit(board.getIsEdit())
                .readCnt(board.getReadCnt())
                .userId(user.getId())
                .likeCnt((long) board.getLikes().size())
                .build();
        //좋아요 여부 추가해야함
    }

    public BoardDetailDto updateBoard(Long userId, Long boardId, BoardRequestDto requestDto) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        //게시글 유무 확인
        Board board = boardRepository.findByIdAndIsDeleted(boardId, false)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_BOARD));

        //제목 중복 확인
        boardRepository.findByIdNotAndTitleAndIsDeleted(boardId, requestDto.getTitle(), false)
                .ifPresent(b -> {
                    throw new CommonException(ErrorCode.DUPLICATION_TITLE);
                });


        //게시글 작성 유저와 요청 유저 비교
        if (board.getUser().getId() != user.getId())
            throw new CommonException(ErrorCode.NOT_EQUAL);

        //입력 유효한지 확인
        if ((requestDto.getTitle() == null) || (requestDto.getTitle().length() == 0) || (requestDto.getRegion() == null)) {
            throw new CommonException(ErrorCode.NOT_EXIST_PARAMETER);
        }

        //수정
        board.modifyBoard(requestDto.getTitle(), requestDto.getContent(), requestDto.getRegion());

        return BoardDetailDto.builder()
                .id(board.getId())
                .title(board.getTitle())
                .content(board.getContent())
                .userName(board.getUser().getName())
                .isEdit(board.getIsEdit())
                .readCnt(board.getReadCnt())
                .userId(board.getUser().getId())
                .likeCnt((long) board.getLikes().size())
                .build();
    }

    public Boolean deleteBoard(Long userId, Long boardId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Board board = boardRepository.findByIdAndIsDeleted(boardId, false)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_BOARD));

        //게시글 작성 유저와 요청 유저 비교
        if (board.getUser().getId() != user.getId())
            throw new CommonException(ErrorCode.NOT_EQUAL);

        board.deleteBoard();

        return Boolean.TRUE;
    }

    //최신순만 만듬, 좋아요 수, 조회수도 만들어야함
    //슬라이드 방식인지 페이지 선택하는 방식인지?
    public List<BoardListDto> getAllBoardList(Long userId, Long pageIndex, Long pageSize) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Pageable paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(Sort.Direction.DESC, "lastModifiedDate"));
        List<Board> page = boardRepository.findAllByIsDeleted(false, paging);

        List<BoardListDto> list = page.stream()
                .map(b -> new BoardListDto(b.getId(), b.getTitle(), b.getContent(), b.getRegion(), b.getLastModifiedDate(), b.getReadCnt(), boardUtil.existLike(user, b)))
                .collect(Collectors.toList());

        return list;
    }

    public List<BoardListDto> getBoardListByTitle(Long userId, String title, Long pageIndex, Long pageSize) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Pageable paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(Sort.Direction.DESC, "lastModifiedDate"));
        List<Board> page = boardRepository.findListByTitleContainingAndIsDeleted(title, false, paging);

        List<BoardListDto> list = page.stream()
                .map(b -> new BoardListDto(b.getId(), b.getTitle(), b.getContent(), b.getRegion(), b.getLastModifiedDate(), b.getReadCnt(), boardUtil.existLike(user, b)))
                .collect(Collectors.toList());

        return list;
    }

    public List<BoardListDto> getBoardListByRegion(Long userId, String region, Long pageIndex, Long pageSize) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        ERegion boardRegion = ERegion.from(region);

        Pageable paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(Sort.Direction.DESC, "lastModifiedDate"));
        List<Board> page = boardRepository.findListByRegionAndIsDeleted(boardRegion, false, paging);

        List<BoardListDto> list = page.stream()
                .map(b -> new BoardListDto(b.getId(), b.getTitle(), b.getContent(), b.getRegion(), b.getLastModifiedDate(), b.getReadCnt(), boardUtil.existLike(user, b)))
                .collect(Collectors.toList());

        return list;
    }

    public List<BoardListDto> getBoardListByUser(Long userId, Long boardUserId, Long pageIndex, Long pageSize) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        User boardUser = userRepository.findById(boardUserId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Pageable paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(Sort.Direction.DESC, "lastModifiedDate"));
        List<Board> page = boardRepository.findListByUserAndIsDeleted(boardUser, false, paging);

        List<BoardListDto> list = page.stream()
                .map(b -> new BoardListDto(b.getId(), b.getTitle(), b.getContent(), b.getRegion(), b.getLastModifiedDate(), b.getReadCnt(), boardUtil.existLike(user, b)))
                .collect(Collectors.toList());

        return list;
    }


}
