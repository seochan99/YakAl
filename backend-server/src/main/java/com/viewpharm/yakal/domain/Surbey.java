package com.viewpharm.yakal.domain;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicUpdate;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor
@DynamicUpdate
@Table(name = "surbeys")
public class Surbey {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "introduction", nullable = false)
    private String introduction;

    @Column(name = "total_score", nullable = false)
    private String totalScore;

    //-------------------------------------------------------------------

    @OneToMany(mappedBy = "surbey", fetch = FetchType.LAZY)
    private List<Answer> answers = new ArrayList<>();

    @Builder
    public Surbey(String title, String introduction, String totalScore) {
        this.title = title;
        this.introduction = introduction;
        this.totalScore = totalScore;
    }
}
