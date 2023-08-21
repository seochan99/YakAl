package com.viewpharm.yakal.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.DynamicUpdate;

import java.awt.*;

@Entity
@Getter
@Setter
@DynamicUpdate
@NoArgsConstructor
@Table(name ="medicals")
public class Medical {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long id;

    @Column
    private String medicalName;

    @Column
    private String medicalIntroduction;

    //서울시 성북구...
    @Column
    private String medicalLocation;

    //좌표
    @Column
    private Point medicalPoint;

    // ----------------------------------------------------------

    @OneToOne(mappedBy = "medical",fetch = FetchType.LAZY)
    private Image image;

}
