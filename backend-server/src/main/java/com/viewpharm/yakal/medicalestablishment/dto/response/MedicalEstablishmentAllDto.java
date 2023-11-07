package com.viewpharm.yakal.medicalestablishment.dto.response;

import com.viewpharm.yakal.base.dto.PageInfo;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
public class MedicalEstablishmentAllDto {
    private List<MedicalEstablishmentListForAdminDto> datalist;
    private PageInfo pageInfo;

    @Builder
    public MedicalEstablishmentAllDto(List<MedicalEstablishmentListForAdminDto> datalist, PageInfo pageInfo) {
        this.datalist = datalist;
        this.pageInfo = pageInfo;
    }
}
