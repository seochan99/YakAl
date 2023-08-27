package com.viewpharm.yakal.domain;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor
@Table(name = "counsels")
public class Counsel extends BaseCreateEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @JoinColumn(name = "patient_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private User patient;

    @JoinColumn(name = "expert_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private User expert;

    @Column(name = "is_deleted", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isDeleted;

    //----------------------------------------------------------------

    @OneToMany(mappedBy = "counsel", fetch = FetchType.LAZY)
    private List<Note> notes = new ArrayList<>();

    public void deleteCounsel() {
        this.isDeleted = true;
    }

    @Builder
    public Counsel(User patient, User expert) {
        this.patient = patient;
        this.expert = expert;
        this.isDeleted = false;
    }
}
