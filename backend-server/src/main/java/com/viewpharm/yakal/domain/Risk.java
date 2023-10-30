package com.viewpharm.yakal.domain;

import com.viewpharm.yakal.base.type.EMedicalProperties;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
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

    @Column(name = "properties")
    private EMedicalProperties properties;
}
