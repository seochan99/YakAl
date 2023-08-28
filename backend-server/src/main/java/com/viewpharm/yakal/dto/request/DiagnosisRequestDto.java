package com.viewpharm.yakal.dto.request;

import lombok.Builder;
import lombok.Getter;

@Getter
public class DiagnosisRequestDto {
    private String name;

    @Builder
    public DiagnosisRequestDto(String name) {
        this.name = name;
    }
}
