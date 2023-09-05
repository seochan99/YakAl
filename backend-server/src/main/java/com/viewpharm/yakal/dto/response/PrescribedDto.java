package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.time.LocalDate;

@Getter
@Builder
public class PrescribedDto {
    private String KDCode;
    private int Score;
    private LocalDate prescribedDate;

    public PrescribedDto(String KDCode, int score, LocalDate prescribedDate) {
        this.KDCode = KDCode;
        Score = score;
        this.prescribedDate = prescribedDate;
    }
}
