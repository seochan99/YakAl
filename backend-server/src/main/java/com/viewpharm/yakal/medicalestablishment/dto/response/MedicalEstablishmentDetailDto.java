package com.viewpharm.yakal.medicalestablishment.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class MedicalEstablishmentDetailDto {
    private String type;
    private String chiefName;
    private String chiefTel;
    private String facilityName;
    private String facilityNumber;
    private String zipCode;
    private String address;
    private String businessRegiNumber;
    private String certificateImg;
    private String tel;
    private String clinicHours;
    private String features;
    private LocalDate requestedAt;

}
