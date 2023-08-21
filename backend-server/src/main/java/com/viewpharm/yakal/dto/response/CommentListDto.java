package com.viewpharm.yakal.dto.response;

import com.viewpharm.yakal.domain.Comment;
import lombok.Getter;

import java.util.ArrayList;
import java.util.List;

@Getter
public class CommentListDto {
    private Long id;
    private String content;
    private String userName;
    private List<CommentListDto> children = new ArrayList<>();

    public CommentListDto(Long id, String content, String userName) {
        this.id = id;
        this.content = content;
        this.userName = userName;
    }

    public static CommentListDto convertCommentToDto(Comment comment) {
        return comment.getIsDeleted() ?
                new CommentListDto(comment.getId(), "삭제된 댓글입니다.", "삭제된 사용자") :
                new CommentListDto(comment.getId(), comment.getContent(), comment.getUser().getName());
    }
}
