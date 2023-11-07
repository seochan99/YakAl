package com.viewpharm.yakal.medicalestablishment.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class MedicalEstablishmentListForAdminDto {
    private Long id;
    private String name;
    private String type;
    private String directorName;
    private String directorTel;
    private LocalDate requestedAt;
}