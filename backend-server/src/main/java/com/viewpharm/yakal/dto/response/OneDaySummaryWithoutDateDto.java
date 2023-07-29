package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class OneDaySummaryWithoutDateDto {

    private Long progressOrNull;
    private Boolean isOverlapped;

    @Builder
    public OneDaySummaryWithoutDateDto(final Long progressOrNull, final Boolean isOverlapped) {
        this.progressOrNull = progressOrNull;
        this.isOverlapped = isOverlapped;
    }
}
