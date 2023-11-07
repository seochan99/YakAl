package com.viewpharm.yakal.prescription.dto.response;

import lombok.Getter;

import java.time.LocalDate;
@Getter
public class DoseAntiDto {
    private String name;
    private LocalDate prescribedAt;
    private int riskLevel;

    public DoseAntiDto(String name, LocalDate prescribedAt, int riskLevel) {
        this.name = name;
        this.prescribedAt = prescribedAt;
        this.riskLevel = riskLevel;
    }
}
