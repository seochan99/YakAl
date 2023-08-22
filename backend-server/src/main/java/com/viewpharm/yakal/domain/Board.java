package com.viewpharm.yakal.domain;

import com.viewpharm.yakal.type.ERegion;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.Formula;

import java.util.ArrayList;
import java.util.List;

@Getter
@DynamicUpdate
@NoArgsConstructor
@Table(name = "boards")
@Entity
public class Board extends BaseCreateEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "content", nullable = false)
    private String content;

    @Column(name = "is_deleted", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isDeleted;

    @Column(name = "is_edit", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isEdit;

    @Column(name = "read_cnt", nullable = false)
    private Long readCnt;

    @Formula("(select count(*) from likes where likes.board_id = id)")
    private int likeCount;

    //-------------------------------------------------------------------

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @JoinColumn(name = "region")
    @Enumerated(EnumType.STRING)
    private ERegion region;

    @OneToMany(mappedBy = "board", fetch = FetchType.LAZY)
    private List<Like> likes = new ArrayList<>();

    @OneToMany(mappedBy = "board", fetch = FetchType.LAZY)
    private List<Comment> comments = new ArrayList<>();

    //-----------------------------------------------------------------
    public void addCnt() {
        this.readCnt++;
    }

    public void modifyBoard(String title, String content, ERegion region) {
        this.title = title;
        this.content = content;
        this.region = region;
        this.isEdit = true;
    }

    public void deleteBoard() {
        this.isDeleted = true;
    }

    @Builder
    public Board(String title, String content, User user, ERegion region) {
        this.title = title;
        this.content = content;
        this.isDeleted = false;
        this.isEdit = false;
        this.readCnt = 0L;
        this.user = user;
        this.region = region;
    }
}
