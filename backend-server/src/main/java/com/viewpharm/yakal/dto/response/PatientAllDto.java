package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
public class PatientAllDto {
    private List<PatientDto> datalist;
    private PageInfo pageInfo;

    @Builder
    public PatientAllDto(List<PatientDto> datalist, PageInfo pageInfo) {
        this.datalist = datalist;
        this.pageInfo = pageInfo;
    }
}
