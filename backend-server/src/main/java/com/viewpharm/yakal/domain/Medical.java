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
    @Column(name="id")
    private Long id;

    @Column(name="medical_name")
    private String medicalName;

    @Column(name="medical_introduction")
    private String medicalIntroduction;

    //서울시 성북구...
    @Column(name="medical_location")
    private String medicalLocation;

    //좌표
    @Column(name="medical_point")
    private Point medicalPoint;

    // ----------------------------------------------------------

    @OneToOne(mappedBy = "medical",fetch = FetchType.LAZY)
    private Image image;

}
