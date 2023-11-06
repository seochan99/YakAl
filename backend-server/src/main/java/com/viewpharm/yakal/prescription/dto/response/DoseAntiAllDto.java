package com.viewpharm.yakal.prescription.dto.response;

import com.viewpharm.yakal.base.dto.PageInfo;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
public class DoseAntiAllDto {
    private List<DoseAntiDto> datalist;
    private PageInfo pageInfo;

    @Builder
    public DoseAntiAllDto(List<DoseAntiDto> datalist, PageInfo pageInfo) {
        this.datalist = datalist;
        this.pageInfo = pageInfo;
    }
}
