package com.viewpharm.yakal.survey.domain;

import com.viewpharm.yakal.user.domain.User;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicUpdate;

import java.time.LocalDate;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@DynamicUpdate
@Table(name = "answers")
public class Answer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "content", nullable = false)
    private String content;

    @Column(name = "score", nullable = false)
    private int score;

    @Column(name = "create_date", nullable = false)
    private LocalDate createdDate;

    @Column(name = "result_comment", nullable = false)
    private String resultComment;

    //-------------------------------------------------------------------

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "surbey_id")
    private Survey survey;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @Builder
    public Answer(String content, int score, Survey survey, String resultComment, User user) {
        this.content = content;
        this.score = score;
        this.survey = survey;
        this.createdDate = LocalDate.now();
        this.resultComment = resultComment;
        this.user = user;
    }
}
