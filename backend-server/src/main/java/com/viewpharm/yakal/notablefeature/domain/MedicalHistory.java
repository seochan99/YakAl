package com.viewpharm.yakal.notablefeature.domain;

import com.viewpharm.yakal.domain.User;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

//기저 질환 및 알러지로 변경예정
@Entity
@Getter
@NoArgsConstructor
@Table(name = "medical_histories")
public class MedicalHistory {
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
    public MedicalHistory(String name, User user) {
        this.name = name;
        this.user = user;
    }
}
