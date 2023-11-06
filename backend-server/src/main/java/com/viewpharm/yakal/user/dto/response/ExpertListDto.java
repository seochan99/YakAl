package com.viewpharm.yakal.user.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
public class ExpertListDto {
    Long id;
    String name;
    String medicalEstablishment;

    @Builder
    public ExpertListDto(Long id, String name, String medicalEstablishment) {
        this.id = id;
        this.name = name;
        this.medicalEstablishment = medicalEstablishment;
    }
}
