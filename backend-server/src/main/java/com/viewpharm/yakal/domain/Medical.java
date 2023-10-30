package com.viewpharm.yakal.domain;

import com.viewpharm.yakal.base.type.EMedical;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.DynamicUpdate;
import org.locationtech.jts.geom.Point;

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

    @Column(nullable = false)
    private String medicalName;

    @Column
    private String medicalAddress;

    @Column
    private String medicalTel;

    //좌표
    @Column(columnDefinition = "point")
    private Point medicalPoint;

    @Column(name="type")
    @Enumerated(EnumType.STRING)
    private EMedical type;

    @Column
    private boolean isRegister = false;

    // ----------------------------------------------------------

    @OneToOne(mappedBy = "medical",fetch = FetchType.LAZY)
    private Image image;

    @Builder
    public Medical(Long id, String medicalName, String medicalAddress, String medicalTel, Point medicalPoint, EMedical eMedical) {
        this.id = id;
        this.medicalName = medicalName;
        this.medicalAddress = medicalAddress;
        this.medicalTel = medicalTel;
        this.medicalPoint = medicalPoint;
        this.type = eMedical;
    }
}
