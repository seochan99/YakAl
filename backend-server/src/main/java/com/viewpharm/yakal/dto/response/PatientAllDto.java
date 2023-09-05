package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;
import org.apache.poi.ss.formula.functions.T;

import java.util.List;

@Getter
public class PatientAllDto {
    private List<PatientDto> data;
    private PageInfo pageInfo;

    @Builder
    public PatientAllDto(List<PatientDto> data, PageInfo pageInfo) {
        this.data = data;
        this.pageInfo = pageInfo;
    }
}
