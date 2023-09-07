package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
public class MedicalListAndTotalDto {

    private List<MedicalDto> medicalList;
    private Long totalCount;

    @Builder
    public MedicalListAndTotalDto(final List<MedicalDto> medicalList, final Long totalCount) {
        this.medicalList = medicalList;
        this.totalCount = totalCount;
    }
}
