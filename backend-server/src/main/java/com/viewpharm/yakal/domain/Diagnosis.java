package com.viewpharm.yakal.domain;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.DynamicUpdate;

//기저 질환 및 알러지로 변경예정
@Deprecated
@Entity
@Getter
@Setter
@DynamicUpdate
@NoArgsConstructor
@Table(name = "diagnosis")
public class Diagnosis {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "name", nullable = false)
    private String name;

    /* -------------------------------------------------- */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    public void modifyDiagnosis(String name) {
        this.name = name;
    }

    @Builder
    public Diagnosis(String name, User user) {
        this.name = name;
        this.user = user;
    }
}
