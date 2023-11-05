package com.viewpharm.yakal.prescription.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.time.LocalDate;

@Getter
public class AnticholinergicDoseDto {
    private String name;
    private LocalDate prescribedAt;
    private Integer riskLevel;

    public AnticholinergicDoseDto(String name, LocalDate prescribedAt, Integer riskLevel) {
        this.name = name;
        this.prescribedAt = prescribedAt;
        this.riskLevel = riskLevel;
    }
}