package com.viewpharm.yakal.desire.dto.response;

import com.viewpharm.yakal.base.dto.PageInfo;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
public class DesireAllDto {
    private List<DesireListDto> datalist;
    private PageInfo pageInfo;

    @Builder
    public DesireAllDto(List<DesireListDto> datalist, PageInfo pageInfo) {
        this.datalist = datalist;
        this.pageInfo = pageInfo;
    }
}
