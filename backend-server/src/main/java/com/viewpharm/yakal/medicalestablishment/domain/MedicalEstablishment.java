package com.viewpharm.yakal.medicalestablishment.domain;


import com.viewpharm.yakal.base.type.EMedical;
import com.viewpharm.yakal.user.domain.User;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicUpdate;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor
@Table(name = "medical_establishments")
@DynamicUpdate
public class MedicalEstablishment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long id;

    @Column(name = "type", nullable = false)
    @Enumerated(EnumType.STRING)
    private EMedical type;

    @Column(name = "chief_name", nullable = false)
    private String chiefName;

    @Column(name = "chief_tel", nullable = false)
    private String chiefTel;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "establishment_number", nullable = false)
    private String establishmentNumber;

    @Column(name = "zip_code", nullable = false)
    private String zipCode;

    @Column(name = "address", nullable = false)
    private String address;

    @Column(name = "business_number", nullable = false)
    private String businessNumber;

    @Column(name = "tel")
    private String tel;

    @Column(name = "clinic_hours")
    private String clinicHours;

    @Column(name = "features")
    private String features;

    @Column(name = "chief_license_img", nullable = false)
    private String chiefLicenseImg;

    @Column(name = "is_register", nullable = false)
    private Boolean isRegister = false;

    @OneToMany(mappedBy = "medicalEstablishment", fetch = FetchType.LAZY)
    private List<User> users = new ArrayList<>();

    @OneToMany(mappedBy = "medicalEstablishment", fetch = FetchType.LAZY)
    private List<ExpertCertification> expertCertifications = new ArrayList<>();

    @Column(name = "created_at")
    private LocalDate createdDate;

    @Builder
    public MedicalEstablishment(EMedical type, String chiefName, String chiefTel, String name, String establishmentNumber, String zipCode, String address, String businessNumber, String tel, String clinicHours, String features, String chiefLicenseImg) {
        this.type = type;
        this.chiefName = chiefName;
        this.chiefTel = chiefTel;
        this.name = name;
        this.establishmentNumber = establishmentNumber;
        this.zipCode = zipCode;
        this.address = address;
        this.businessNumber = businessNumber;
        this.tel = tel;
        this.clinicHours = clinicHours;
        this.features = features;
        this.chiefLicenseImg = chiefLicenseImg;
        this.createdDate =LocalDate.now();
    }

    public void updateIsRegister(boolean isRegister) {
        this.isRegister = isRegister;
    }
}
