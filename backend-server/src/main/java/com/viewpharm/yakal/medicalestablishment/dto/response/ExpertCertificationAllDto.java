package com.viewpharm.yakal.medicalestablishment.dto.response;

import com.viewpharm.yakal.base.dto.PageInfo;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
public class ExpertCertificationAllDto {
    private List<ExpertCertificationListDto> datalist;
    private PageInfo pageInfo;

    @Builder
    public ExpertCertificationAllDto(List<ExpertCertificationListDto> datalist, PageInfo pageInfo) {
        this.datalist = datalist;
        this.pageInfo = pageInfo;
    }
}
