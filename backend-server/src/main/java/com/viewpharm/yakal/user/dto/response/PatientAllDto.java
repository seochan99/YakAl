package com.viewpharm.yakal.user.dto.response;

import com.viewpharm.yakal.base.dto.PageInfo;
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
