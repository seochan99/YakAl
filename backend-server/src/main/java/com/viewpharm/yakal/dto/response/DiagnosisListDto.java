package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
public class DiagnosisListDto {
    private Long id;
    private String name;

    @Builder
    public DiagnosisListDto(Long id, String name) {
        this.id = id;
        this.name = name;
    }
}
