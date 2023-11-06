package com.viewpharm.yakal.prescription.dto.response;

import com.viewpharm.yakal.base.dto.PageInfo;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
public class DoseAllDto {
    private List<DoseRecentDto> datalist;
    private PageInfo pageInfo;

    @Builder
    public DoseAllDto(List<DoseRecentDto> datalist, PageInfo pageInfo) {
        this.datalist = datalist;
        this.pageInfo = pageInfo;
    }
}

