package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;

//기저 질환 및 알러지로 변경 예정
@Deprecated
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
