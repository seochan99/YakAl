package com.viewpharm.yakal.medicalestablishment.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ExpertCertificationDetailDto {
    private MedicalEstablishmentForExpertDto belongInfo;
    private String name;
    private String tel;
    private LocalDate requestedAt;
    private String type;
    private String certificateImg;
    private String affiliationImg;
}