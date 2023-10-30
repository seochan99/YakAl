package com.viewpharm.yakal.domain;

import com.viewpharm.yakal.base.type.EMedical;
import com.viewpharm.yakal.base.type.ERecive;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.DynamicUpdate;

@Entity
@Getter
@Setter
@DynamicUpdate
@NoArgsConstructor
@Table(name = "registrations")
public class Registration {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private EMedical eMedical;

    @Column(nullable = false)
    private String directorName;

    @Column(nullable = false)
    private String directorTel;

    @Column(nullable = false)
    private String medicalName;

    @Column(nullable = false)
    private String medicalTel;

    @Column(nullable = false)
    private String zipCode;

    @Column(nullable = false)
    private String medicalAddress;

    @Column(nullable = false)
    private String medicalDetailAddress;

    @Column(nullable = false)
    private String businessRegistrationNumber;

    @OneToOne(mappedBy = "registration", fetch = FetchType.LAZY)
    private Image image;

    @Column(nullable = false)
    private ERecive eRecive;

    @Column
    private String medicalRuntime;

    @Column
    private String medicalCharacteristics;

    @Column
    private Boolean isPrecessed;

    @Builder
    public Registration(Long id, EMedical eMedical, String directorName, String directorTel, String medicalName, String medicalTel, String zipCode, String medicalAddress, String medicalDetailAddress, String businessRegistrationNumber, Image image, ERecive eRecive, String medicalRuntime, String medicalCharacteristics, Boolean isPrecessed) {
        this.id = id;
        this.eMedical = eMedical;
        this.directorName = directorName;
        this.directorTel = directorTel;
        this.medicalName = medicalName;
        this.medicalTel = medicalTel;
        this.zipCode = zipCode;
        this.medicalAddress = medicalAddress;
        this.medicalDetailAddress = medicalDetailAddress;
        this.businessRegistrationNumber = businessRegistrationNumber;
        this.image = image;
        this.eRecive = eRecive;
        this.medicalRuntime = medicalRuntime;
        this.medicalCharacteristics = medicalCharacteristics;
        this.isPrecessed = isPrecessed;
    }
}
