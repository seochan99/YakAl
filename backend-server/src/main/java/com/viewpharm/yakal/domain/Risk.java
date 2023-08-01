package com.viewpharm.yakal.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.DynamicUpdate;

@Entity
@Getter
@Setter
@DynamicUpdate
@NoArgsConstructor
@Table(name = "risks")
public class Risk {
    @Id
    @Column(name = "id")
    private String id;

    @Column(name = "score", nullable = false)
    private int score;
}
