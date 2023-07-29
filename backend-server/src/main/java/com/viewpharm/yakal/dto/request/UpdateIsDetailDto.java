package com.viewpharm.yakal.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UpdateIsDetailDto {

    @NotNull
    private Boolean isDetail;

    @Builder
    public UpdateIsDetailDto(final Boolean isDetail) {
        this.isDetail = isDetail;
    }
}
