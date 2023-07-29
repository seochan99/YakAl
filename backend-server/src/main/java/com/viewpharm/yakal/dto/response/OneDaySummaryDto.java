package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class OneDaySummaryDto {

    private LocalDate date;
    private Long progressOrNull;
    private Boolean isOverlapped;

    @Builder
    public OneDaySummaryDto(final LocalDate date,
                            final Long progressOrNull,
                            final Boolean isOverlapped) {
        this.date = date;
        this.progressOrNull = progressOrNull;
        this.isOverlapped = isOverlapped;
    }
}