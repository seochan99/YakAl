package com.viewpharm.yakal.domain;

import com.viewpharm.yakal.type.EMedicalProperties;
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

    @Column(name = "is_beers_criteria")
    private Boolean isBeersCriteria;

    @Column(name = "anticholinergic")
    private EMedicalProperties properties;
}
