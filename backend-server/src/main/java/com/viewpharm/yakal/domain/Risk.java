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
    @Column(name = "id", columnDefinition = "CHAR(7)")
    private String atcCode;

    @Column(name = "score", columnDefinition = "TINYINT", nullable = false)
    private int score;
}
