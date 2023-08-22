package com.viewpharm.yakal.domain;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.annotations.DynamicUpdate;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor
@Table(name = "comments")
@DynamicUpdate
public class Comment extends BaseCreateEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @JoinColumn(name = "user_id", nullable = true)
    @ManyToOne(fetch = FetchType.LAZY)
    private User user;

    @Column(name = "context", nullable = false)
    private String content;

    @Column(name = "is_edit", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isEdit;

    @Column(name = "is_deleted", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isDeleted;

    //----------------------------------------------------------------
    @JoinColumn(name = "board_id", nullable = true)
    @ManyToOne(fetch = FetchType.LAZY)
    private Board board;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "perent_comment")
    private Comment parent;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "parent")
    private List<Comment> child = new ArrayList<>();

    public void updateComment(String content) {
        this.content = content;
        this.isEdit = true;
    }

    public void updateParent(Comment parent) {
        this.parent = parent;
    }

    public void deleteComment() {
        this.isDeleted = true;
    }


    @Builder
    public Comment(User user, String content, Board board) {
        this.user = user;
        this.content = content;
        this.isEdit = false;
        this.isDeleted = false;
        this.parent = null;
        this.board = board;
    }
}
