package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.Board;
import com.viewpharm.yakal.domain.Comment;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.dto.request.CommentForUpdateRequestDto;
import com.viewpharm.yakal.dto.request.CommentRequestDto;
import com.viewpharm.yakal.dto.response.CommentListDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.BoardRepository;
import com.viewpharm.yakal.repository.CommentRepository;
import com.viewpharm.yakal.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class CommentService {
    private final UserRepository userRepository;
    private final BoardRepository boardRepository;
    private final CommentRepository commentRepository;

    //Create
    public Boolean createComment(Long userId, Long boardId, CommentRequestDto requestDto) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        Board board = boardRepository.findById(boardId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_BOARD));

        //대댓글 여부 확인
        if (requestDto.getParentId() != null) {
            Comment parentComment = commentRepository.findById(requestDto.getParentId())
                    .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_COMMENT));
            commentRepository.save(Comment.CommentWithParent()
                    .user(user)
                    .content(requestDto.getContent())
                    .board(board)
                    .parent(parentComment)
                    .build());
        } else {
            commentRepository.save(Comment.builder()
                    .user(user)
                    .content(requestDto.getContent())
                    .board(board)
                    .build());
        }
        return Boolean.TRUE;

        //Sort.NullHandling.NULLS_FIRST
    }


    //Read

    public List<CommentListDto> getCommentList(Long boardId, Long pageIndex, Long pageSize) {
        Board board = boardRepository.findById(boardId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_BOARD));
        Pageable paging = PageRequest.of(pageIndex.intValue(), pageSize.intValue());

        Page<Comment> page = commentRepository.findByBoardIdAndIsDeleted(board.getId(), paging);
        List<CommentListDto> list = new ArrayList<>();
        Map<Long, CommentListDto> commentDTOHashMap = new HashMap<>();

        page.forEach(c -> {
            CommentListDto commentListDto = CommentListDto.convertCommentToDto(c);
            commentDTOHashMap.put(commentListDto.getId(), commentListDto);
            if (c.getParent() != null) commentDTOHashMap.get(c.getParent().getId()).getChildren().add(commentListDto);
            else list.add(commentListDto);
        });


        return list;
    }


    //Update
    public Boolean updateComment(Long userId, Long boardId, Long commentId, CommentForUpdateRequestDto commentForUpdateRequestDto) {
        // User, Course, Comment 존재유무 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Board board = boardRepository.findById(boardId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_BOARD));

        Comment comment = commentRepository.findByIdAndUserAndBoardAndIsDeleted(commentId, user, board, false)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_COMMENT));

        // Comment 수정
        if ((commentForUpdateRequestDto.getContent() == null) || (commentForUpdateRequestDto.getContent().length() == 0)) {
            throw new CommonException(ErrorCode.NOT_EXIST_PARAMETER);
        }

        comment.updateComment(commentForUpdateRequestDto.getContent());

        return Boolean.TRUE;
    }

    //Delete
    public Boolean deleteComment(Long userId, Long boardId, Long commentId) {
        // User, Course, Comment 존재유무 확인
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        Board board = boardRepository.findById(boardId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_BOARD));

        Comment comment = commentRepository.findByIdAndUserAndBoardAndIsDeleted(commentId, user, board, false)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_COMMENT));

        // 삭제 - status 변경
        comment.deleteComment();
        return Boolean.TRUE;
    }
}
