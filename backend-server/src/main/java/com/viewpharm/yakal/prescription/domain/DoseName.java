package com.viewpharm.yakal.prescription.domain;

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
@Table(name = "dosenames")
public class DoseName {
    @Id
    @Column(name = "id")
    private String kdCode;

    @Column(name = "atc_code", nullable = false)
    private String atcCode;

    @Column(name = "dose_name", nullable = false)
    private String doseName;
}
