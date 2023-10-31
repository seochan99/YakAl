package com.viewpharm.yakal.survey.domain;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicUpdate;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@DynamicUpdate
@Table(name = "surveys")
public class Survey {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "mini_title", nullable = false)
    private String miniTitle;

    @Column(name = "introduction", nullable = false)
    private String introduction;

    @Column(name = "total_score", nullable = false)
    private String totalScore;

    //-------------------------------------------------------------------

    @OneToMany(mappedBy = "survey", fetch = FetchType.LAZY)
    private List<Answer> answers = new ArrayList<>();

    @Builder
    public Survey(String title, String miniTitle, String introduction, String totalScore) {
        this.title = title;
        this.miniTitle = miniTitle;
        this.introduction = introduction;
        this.totalScore = totalScore;
    }
}
