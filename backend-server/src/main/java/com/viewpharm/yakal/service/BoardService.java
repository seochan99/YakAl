package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.Board;
import com.viewpharm.yakal.domain.Like;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.dto.request.BoardRequestDto;
import com.viewpharm.yakal.dto.response.BoardDetailDto;
import com.viewpharm.yakal.dto.response.BoardListDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.BoardRepository;
import com.viewpharm.yakal.repository.LikeRepository;
import com.viewpharm.yakal.repository.UserRepository;
import com.viewpharm.yakal.type.ERegion;
import com.viewpharm.yakal.utils.BoardUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class BoardService {
    private final BoardRepository boardRepository;
    private final UserRepository userRepository;
    private final LikeRepository likeRepository;
    private final BoardUtil boardUtil;

    public Boolean createBoard(Long userId, BoardRequestDto requestDto) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        //제목 중복 확인
        boardRepository.findByTitleAndIsDeleted(requestDto.getTitle(), false)
                .ifPresent(b -> {
                    throw new CommonException(ErrorCode.DUPLICATION_TITLE);
                });

        //지역 유효성 확인
        if (ERegion.from(requestDto.getRegion()) == null) {
            throw new CommonException(ErrorCode.INVALID_ARGUMENT);
        }

        //입력값 유효성 확인
        if ((requestDto.getTitle().length() == 0) || (requestDto.getContent().length() == 0)) {
            throw new CommonException(ErrorCode.NOT_EXIST_PARAMETER);
        }

        //저장
        boardRepository.save(Board.builder()
                .title(requestDto.getTitle())
                .content(requestDto.getContent())
                .user(user)
                .region(ERegion.from(requestDto.getRegion()))
                .build());
        return Boolean.TRUE;
    }

    public BoardDetailDto readBoard(Long userId, Long boardId) {
        //유저 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        //게시판 확인
        Board board = boardRepository.findByIdAndIsDeleted(boardId, false)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_BOARD));
        //조회수 증가
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
                .isLike(boardUtil.existLike(user, board))
                .region(board.getRegion().toString())
                .createDate(board.getCreateDate())
                .lastModifiedDate(board.getLastModifiedDate())
                .build();
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

        //지역 유효성 확인
        if (ERegion.from(requestDto.getRegion()) == null) {
            throw new CommonException(ErrorCode.INVALID_ARGUMENT);
        }

        //게시글 작성 유저와 요청 유저 비교
        if (board.getUser().getId() != userId)
            throw new CommonException(ErrorCode.NOT_EQUAL);

        //입력 유효한지 확인
        if ((requestDto.getTitle().length() == 0) || (requestDto.getContent().length() == 0)) {
            throw new CommonException(ErrorCode.NOT_EXIST_PARAMETER);
        }

        //수정
        board.modifyBoard(requestDto.getTitle(), requestDto.getContent(), ERegion.from(requestDto.getRegion()));

        return BoardDetailDto.builder()
                .id(board.getId())
                .title(board.getTitle())
                .content(board.getContent())
                .userName(board.getUser().getName())
                .isEdit(board.getIsEdit())
                .readCnt(board.getReadCnt())
                .isLike(boardUtil.existLike(user, board))
                .userId(board.getUser().getId())
                .likeCnt((long) board.getLikes().size())
                .region(board.getRegion().toString())
                .createDate(board.getCreateDate())
                .lastModifiedDate(board.getLastModifiedDate())
                .build();
    }

    public Boolean deleteBoard(Long userId, Long boardId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Board board = boardRepository.findByIdAndIsDeleted(boardId, false)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_BOARD));

        //게시글 작성 유저와 요청 유저 비교
        if (board.getUser().getId() != userId)
            throw new CommonException(ErrorCode.NOT_EQUAL);

        board.deleteBoard();

        return Boolean.TRUE;
    }

    //모든게시글 리스트 가져오기
    public List<BoardListDto> getAllBoardList(Long userId, String sorting, Long pageIndex, Long pageSize) {
        Pageable paging = null;

        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        if (sorting.equals("date"))
            paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(Sort.Direction.DESC, "lastModifiedDate"));
        else if (sorting.equals("view"))
            paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(Sort.Direction.DESC, "readCnt"));
        else if (sorting.equals("like"))
            paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(Sort.Direction.DESC, "likeCount"));
        else throw new CommonException(ErrorCode.INVALID_ARGUMENT);

        List<Board> page = boardRepository.findAllByIsDeleted(false, paging);

        //Dto 변환
        List<BoardListDto> list = page.stream()
                .map(b -> new BoardListDto(b.getId(), b.getTitle(), b.getContent(), b.getUser().getName(), b.getRegion(),
                        b.getLastModifiedDate(), b.getReadCnt(), boardUtil.existLike(user, b)))
                .collect(Collectors.toList());
        return list;
    }


    //제목으로 검색
    public List<BoardListDto> getBoardListByTitle(Long userId, String title, String sorting, Long pageIndex, Long pageSize) {
        Pageable paging = null;

        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        if (sorting.equals("date"))
            paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(Sort.Direction.DESC, "lastModifiedDate"));
        else if (sorting.equals("view"))
            paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(Sort.Direction.DESC, "readCnt"));
        else if (sorting.equals("like"))
            paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(Sort.Direction.DESC, "likeCount"));
        else throw new CommonException(ErrorCode.INVALID_ARGUMENT);

        List<Board> page = boardRepository.findListByTitleContainingAndIsDeleted(title, false, paging);

        //Dto 변환
        List<BoardListDto> list = page.stream()
                .map(b -> new BoardListDto(b.getId(), b.getTitle(), b.getContent(), b.getUser().getName(), b.getRegion(),
                        b.getLastModifiedDate(), b.getReadCnt(), boardUtil.existLike(user, b)))
                .collect(Collectors.toList());

        return list;
    }

    //지역으로 검색
    public List<BoardListDto> getBoardListByRegion(Long userId, String region, String sorting, Long pageIndex, Long pageSize) {
        Pageable paging = null;

        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        if (sorting.equals("date"))
            paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(Sort.Direction.DESC, "lastModifiedDate"));
        else if (sorting.equals("view"))
            paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(Sort.Direction.DESC, "readCnt"));
        else if (sorting.equals("like"))
            paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(Sort.Direction.DESC, "likeCount"));
        else throw new CommonException(ErrorCode.INVALID_ARGUMENT);

        ERegion boardRegion = ERegion.from(region);

        List<Board> page = boardRepository.findListByRegionAndIsDeleted(boardRegion, false, paging);

        //Dto 변환
        List<BoardListDto> list = page.stream()
                .map(b -> new BoardListDto(b.getId(), b.getTitle(), b.getContent(), b.getUser().getName(), b.getRegion(),
                        b.getLastModifiedDate(), b.getReadCnt(), boardUtil.existLike(user, b)))
                .collect(Collectors.toList());

        return list;
    }


    //유저로 검색
    public List<BoardListDto> getBoardListByUser(Long userId, Long boardUserId, String sorting, Long pageIndex, Long pageSize) {
        Pageable paging = null;

        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        User boardUser = userRepository.findById(boardUserId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        if (sorting.equals("date"))
            paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(Sort.Direction.DESC, "lastModifiedDate"));
        else if (sorting.equals("view"))
            paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(Sort.Direction.DESC, "readCnt"));
        else if (sorting.equals("like"))
            paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue(), Sort.by(Sort.Direction.DESC, "likeCount"));
        else throw new CommonException(ErrorCode.INVALID_ARGUMENT);

        List<Board> page = boardRepository.findListByUserAndIsDeleted(boardUser, false, paging);

        List<BoardListDto> list = page.stream()
                .map(b -> new BoardListDto(b.getId(), b.getTitle(), b.getContent(), b.getUser().getName(), b.getRegion(),
                        b.getLastModifiedDate(), b.getReadCnt(), boardUtil.existLike(user, b)))
                .collect(Collectors.toList());

        return list;
    }


    //게시판 좋아요
    public Map<String, Object> likeBoard(Long userId, Long boardId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Board board = boardRepository.findById(boardId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_BOARD));

        likeRepository.findByUserAndBoard(user, board)
                .ifPresent(l -> {
                    throw new CommonException(ErrorCode.EXIST_ENTITY_REQUEST);
                });

        likeRepository.save(Like.builder()
                .user(user)
                .board(board)
                .build());

        Map<String, Object> map = new HashMap<>();
        map.put("like_cnt", board.getLikes().size());
        map.put("is_like", Boolean.TRUE);

        return map;
    }


    //게시판 좋아요 취소
    public Map<String, Object> dislikeBoard(Long userId, Long boardId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Board board = boardRepository.findById(boardId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_BOARD));

        Like like = likeRepository.findByUserAndBoard(user, board)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_EXIST_ENTITY_REQUEST));

        likeRepository.delete(like);

        Map<String, Object> map = new HashMap<>();
        map.put("like_cnt", board.getLikes().size() - 1);
        map.put("is_like", Boolean.FALSE);

        return map;
    }
}
