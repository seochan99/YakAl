package com.viewpharm.yakal.prescription.dto.response;

import com.viewpharm.yakal.base.dto.PageInfo;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
public class DoseAllWithRiskDto {
    private List<AnticholinergicDoseDto> datalist;
    private PageInfo pageInfo;

    @Builder
    public DoseAllWithRiskDto(List<AnticholinergicDoseDto> datalist, PageInfo pageInfo) {
        this.datalist = datalist;
        this.pageInfo = pageInfo;
    }
}