package com.viewpharm.yakal.domain;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor
@Table(name = "notes")
public class Note extends BaseCreateEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    private String title;
    private String description;


    @JoinColumn(name = "counsel_id", nullable = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private Counsel counsel;

    @Column(name = "is_deleted", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isDeleted;

    @Column(name = "is_edit", columnDefinition = "TINYINT(1)", nullable = false)
    private Boolean isEdit;

    public void modifyNote(String title, String description) {
        this.title = title;
        this.description = description;
        this.isEdit = true;
    }

    public void deleteNote() {
        this.isDeleted = true;
    }

    @Builder
    public Note(String title, String description, Counsel counsel) {
        this.title = title;
        this.description = description;
        this.counsel = counsel;
        this.isDeleted = false;
        this.isEdit = false;
    }
}
