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
        String content = comment.getContent(), userName;
        if (comment.getIsDeleted()) content = "삭제된 댓글입니다.";

        if (comment.getUser() == null) userName = "탈퇴한 사용자";
        else userName = comment.getUser().getName();

        return new CommentListDto(comment.getId(), content, userName);

    }
}
