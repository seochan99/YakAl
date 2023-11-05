package com.viewpharm.yakal.prescription.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.time.LocalDate;

@Getter
public class DoseRecentDto {
    private String name;
    private LocalDate prescribedAt;

    public DoseRecentDto(String name, LocalDate prescribedAt) {
        this.name = name;
        this.prescribedAt = prescribedAt;
    }
}
